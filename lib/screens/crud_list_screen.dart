import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/crud.dart';

class CrudListScreen extends StatefulWidget {
  @override
  _CrudListScreenState createState() => _CrudListScreenState();
}

class _CrudListScreenState extends State<CrudListScreen> {
  final ValueNotifier<List<Crud>> _crudsNotifier = ValueNotifier([]);

  @override
  void initState() {
    super.initState();
    _loadCruds();
  }

  Future<void> _loadCruds() async {
    try {
      final cruds = await ApiService().getCruds();
      _crudsNotifier.value = cruds;
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _deleteCrud(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmer la suppression'),
        content: Text('Êtes-vous sûr de vouloir supprimer cet utilisateur ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Supprimer'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      try {
        await ApiService().deleteCrud(id);
        _loadCruds(); // Recharger les données après suppression
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la suppression')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste des utilisateurs')),
      body: ValueListenableBuilder<List<Crud>>(
        valueListenable: _crudsNotifier,
        builder: (context, cruds, child) {
          if (cruds.isEmpty) {
            return Center(child: Text('Aucun utilisateur trouvé'));
          }
          return ListView.builder(
            itemCount: cruds.length,
            itemBuilder: (context, index) {
              final crud = cruds[index];
              return Card(
                margin: EdgeInsets.all(8.0),
                elevation: 5.0,
                child: ListTile(
                  contentPadding: EdgeInsets.all(16.0),
                  title: Text('${crud.nom} ${crud.prenom}', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                  subtitle: Text('Contact: ${crud.contact}', style: TextStyle(fontSize: 16.0)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          '/modcrud', // Assurez-vous que la route est correctement définie
                          arguments: crud.id,
                        ).then((_) => _loadCruds()), // Recharger les données après modification
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteCrud(crud.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/add').then((_) => _loadCruds()),
        child: Icon(Icons.add),
      ),
    );
  }
}
