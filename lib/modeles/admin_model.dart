class AdminModel {
  final String id;           // UID Firebase
  final String nom;
  final String email;
  final String telephone;

  AdminModel({
    required this.id,
    required this.nom,
    required this.email,
    required this.telephone,
  });

  factory AdminModel.fromMap(Map<String, dynamic> data, String documentId) {
    return AdminModel(
      id: documentId,
      nom: data['nom'] ?? '',
      email: data['email'] ?? '',
      telephone: data['telephone'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'email': email,
      'telephone': telephone,
    };
  }
}
