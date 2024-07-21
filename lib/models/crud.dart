class Crud {
  final int id;
  final String nom;
  final String prenom;
  final String contact;

  Crud({required this.id, required this.nom, required this.prenom, required this.contact});

  factory Crud.fromJson(Map<String, dynamic> json) {
    return Crud(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      contact: json['contact'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'contact': contact,
    };
  }
}
