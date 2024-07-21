import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/crud.dart';

class ModCrudScreen extends StatefulWidget {
  final int crudId;

  ModCrudScreen({required this.crudId});

  @override
  _ModCrudScreenState createState() => _ModCrudScreenState();
}

class _ModCrudScreenState extends State<ModCrudScreen> {
  late Future<Crud> _crud;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _contactController;

  @override
  void initState() {
    super.initState();
    _crud = ApiService().getCrud(widget.crudId);
  }

  void _updateCrud() async {
    if (_formKey.currentState!.validate()) {
      try {
        await ApiService().updateCrud(
          widget.crudId,
          Crud(
            id: widget.crudId,
            nom: _nomController.text,
            prenom: _prenomController.text,
            contact: _contactController.text,
          ),
        );
        Navigator.pop(context, true); // Indiquer que la mise à jour a eu lieu
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la modification')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Modifier un utilisateur')),
      body: FutureBuilder<Crud>(
        future: _crud,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Aucun utilisateur trouvé'));
          } else {
            final crud = snapshot.data!;
            _nomController = TextEditingController(text: crud.nom);
            _prenomController = TextEditingController(text: crud.prenom);
            _contactController = TextEditingController(text: crud.contact);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(labelText: 'Nom'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est requis';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _prenomController,
                      decoration: InputDecoration(labelText: 'Prénom'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est requis';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contactController,
                      decoration: InputDecoration(labelText: 'Contact'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ce champ est requis';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _updateCrud,
                      child: Text('Enregistrer les modifications'),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
