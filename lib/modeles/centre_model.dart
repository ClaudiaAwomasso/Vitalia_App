class CentreModel {
  final String id;
  final String nom;
  final String adresse;
  final String telephone;
  final String email;
  final String profil;

  CentreModel({
    required this.id,
    required this.nom,
    required this.adresse,
    required this.telephone,
    required this.email,
    required this.profil,
  });

  factory CentreModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CentreModel(
      id: documentId,
      nom: data['nom'] ?? '',
      adresse: data['adresse'] ?? '',
      telephone: data['telephone'] ?? '',
      email: data['email'] ?? '',
      profil: data['profil']?? '',

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'adresse': adresse,
      'telephone': telephone,
      'email': email,
      'profil': profil,
    };
  }
}
