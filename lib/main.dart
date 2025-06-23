import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Common/Theme/app_theme.dart';
import 'Core/Dependency Injection/di.dart';
import 'Core/Navigation/app_router.dart';
import 'Presentation/Bloc/Auth/auth_bloc.dart';
import 'Presentation/Bloc/Control Items/control_item_bloc.dart';
import 'Presentation/Bloc/Greenhouse/greenhouse_bloc.dart';
import 'Presentation/Bloc/Greenhouse/greenhouse_event.dart';
import 'Presentation/Bloc/Sensor Data/sensor_data_bloc.dart';
import 'Presentation/Bloc/Trigger Log/trigger_log_bloc.dart';
import 'Presentation/Bloc/User/user_bloc.dart';
import 'Presentation/Bloc/User/user_event.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthBloc>()),
        BlocProvider(create: (_) => getIt<GreenhouseBloc>()..add(GetGreenhousesEvent(null))),
        BlocProvider(create: (_) => getIt<UserBloc>()..add(GetUsersEvent())),
        BlocProvider(create: (_) => getIt<SensorDataBloc>()),
        BlocProvider(create: (_) => getIt<ControlItemBloc>()),
        BlocProvider(create: (_) => getIt<TriggerLogBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Greenhouse Automation',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
      ),
    );
  }
}