import 'package:flutter/material.dart';
import 'package:test/screens/password_reset_screen.dart';
import 'screens/crud_list_screen.dart';
import 'screens/add_crud_screen.dart';
import 'screens/mod_crud_screen.dart';
import 'screens/register_screen.dart';
import 'screens/login_screen.dart';
import 'screens/main_menu_screen.dart';

class AppRoutes {
 static const String home = '/';
  static const String register = '/register';
  static const String login = '/login';
  static const String mainMenu = '/mainmenu';
  static const String crudList = '/list';
  static const String addCrud = '/add';
  static const String modCrud = '/modcrud';
  static const String passwordReset = '/passwordReset';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
       case home:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case mainMenu:
        return MaterialPageRoute(builder: (_) => MainMenuScreen());
      case crudList:
        return MaterialPageRoute(builder: (_) => CrudListScreen());
      case addCrud:
        return MaterialPageRoute(builder: (_) => AddCrudScreen());
        case AppRoutes.passwordReset:
           return MaterialPageRoute(builder: (_) => PasswordResetScreen());
      case modCrud:
        return MaterialPageRoute(builder: (_) => ModCrudScreen(crudId: settings.arguments as int));
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(body: Center(child: Text('Not Found'))));
    }
  }
}
