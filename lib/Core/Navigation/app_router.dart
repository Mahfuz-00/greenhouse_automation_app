import 'package:go_router/go_router.dart';

import '../../Presentation/Screens/Admin/admin_dashboard_screen.dart';
import '../../Presentation/Screens/Admin/greenhouse_management_screen.dart';
import '../../Presentation/Screens/Admin/user_management_screen.dart';
import '../../Presentation/Screens/Users/profile_management_screen.dart';
import '../../Presentation/Screens/Users/report_screen.dart';
import '../../Presentation/Screens/Users/user_dashboard_screen.dart';
import '../../Presentation/Screens/login_screen.dart';
import '../../Presentation/Screens/signup_screen.dart';
import '../../Presentation/Screens/splash_screen.dart';


class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/admin_dashboard',
        builder: (context, state) => const AdminDashboardScreen(),
        routes: [
          GoRoute(
            path: 'greenhouse_management',
            builder: (context, state) => const GreenhouseManagementScreen(),
          ),
          GoRoute(
            path: 'user_management',
            builder: (context, state) => const UserManagementScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileManagementScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/user_dashboard',
        builder: (context, state) => const UserDashboardScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileManagementScreen(),
          ),
          GoRoute(
            path: 'report',
            builder: (context, state) => const ReportScreen(),
          ),
        ],
      ),
    ],
  );
}