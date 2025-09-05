class AdminModel {
  final String id;           // UID Firebase
  final String nom;
  final String email;

  AdminModel({
    required this.id,
    required this.nom,
    required this.email,
  });

  factory AdminModel.fromMap(Map<String, dynamic> data, String documentId) {
    return AdminModel(
      id: documentId,
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'email': email,
    };
  }
}
