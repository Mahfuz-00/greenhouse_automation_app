import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Usecases/Control Items/get_control_items.dart';
import '../../../Domain/Usecases/Control Items/update_control_item.dart';
import 'control_item_event.dart';
import 'control_item_state.dart';

class ControlItemBloc extends Bloc<ControlItemEvent, ControlItemState> {
  final GetControlItems getControlItems;
  final UpdateControlItem updateControlItem;

  ControlItemBloc(this.getControlItems, this.updateControlItem) : super(ControlItemInitial()) {
    on<GetControlItemsEvent>((event, emit) async {
      emit(ControlItemLoading());
      try {
        final controlItems = await getControlItems(event.greenhouseId);
        emit(ControlItemLoaded(controlItems));
      } catch (e) {
        emit(ControlItemError(e.toString()));
      }
    });

    on<UpdateControlItemEvent>((event, emit) async {
      emit(ControlItemLoading());
      try {
        await updateControlItem(event.controlItem);
        final controlItems = await getControlItems(event.controlItem.greenhouseId);
        emit(ControlItemLoaded(controlItems));
      } catch (e) {
        emit(ControlItemError(e.toString()));
      }
    });
  }
}