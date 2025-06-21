import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../Common/Constants/app_values.dart';
import '../../Core/Widgets/custom_button.dart';
import '../../Core/Widgets/custom_text_field.dart';
import '../../Domain/Entity/greenhouse.dart';


class GreenhouseFormWidget extends StatefulWidget {
  final Greenhouse? greenhouse;
  final Function(Greenhouse) onSubmit;

  const GreenhouseFormWidget({super.key, this.greenhouse, required this.onSubmit});

  @override
  _GreenhouseFormWidgetState createState() => _GreenhouseFormWidgetState();
}

class _GreenhouseFormWidgetState extends State<GreenhouseFormWidget> {
  final _locationController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();
  final _sizeController = TextEditingController();
  final _fanController = TextEditingController();
  final _pumpController = TextEditingController();
  final _sprinklerController = TextEditingController();
  final _dripController = TextEditingController();
  final _foggerController = TextEditingController();
  final _circFanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.greenhouse != null) {
      _locationController.text = widget.greenhouse!.location;
      _latitudeController.text = widget.greenhouse!.latitude.toString();
      _longitudeController.text = widget.greenhouse!.longitude.toString();
      _sizeController.text = widget.greenhouse!.size.toString();
    }
  }

  @override
  void dispose() {
    _locationController.dispose();
    _latitudeController.dispose();
    _longitudeController.dispose();
    _sizeController.dispose();
    _fanController.dispose();
    _pumpController.dispose();
    _sprinklerController.dispose();
    _dripController.dispose();
    _foggerController.dispose();
    _circFanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(label: 'Location', controller: _locationController),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Latitude', controller: _latitudeController, isNumber: true),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Longitude', controller: _longitudeController, isNumber: true),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Size (sq ft)', controller: _sizeController, isNumber: true),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Fans', controller: _fanController, isNumber: true, maxLength: 3),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Pumps', controller: _pumpController, isNumber: true, maxLength: 3),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Sprinklers', controller: _sprinklerController, isNumber: true, maxLength: 3),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Drips', controller: _dripController, isNumber: true, maxLength: 3),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Foggers', controller: _foggerController, isNumber: true, maxLength: 3),
            const SizedBox(height: AppValues.padding),
            CustomTextField(label: 'Circulating Fans', controller: _circFanController, isNumber: true, maxLength: 3),
          ],
        ),
      ),
      actions: [
        CustomButton(
          text: 'Submit',
          onPressed: () {
            final greenhouse = Greenhouse(
              id: widget.greenhouse?.id ?? const Uuid().v4(),
              location: _locationController.text,
              latitude: double.parse(_latitudeController.text),
              longitude: double.parse(_longitudeController.text),
              size: int.parse(_sizeController.text),
              lastUpdated: DateTime.now().millisecondsSinceEpoch,
              userId: widget.greenhouse?.userId,
            );
            widget.onSubmit(greenhouse);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}