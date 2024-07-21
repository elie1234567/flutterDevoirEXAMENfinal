import 'package:flutter/material.dart';
import 'package:test/routes.dart';

class MainMenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.crudList),
              child: Text('Liste des utilisateurs'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.addCrud),
              child: Text('Ajouter un utilisateur'),
            ),
          ],
        ),
      ),
    );
  }
}
