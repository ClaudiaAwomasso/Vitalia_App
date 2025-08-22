class PatientModel{
  final String nom;
  final String telephone;
  final String idVitalia;

  PatientModel({
    required this.nom,
    required this.telephone,
    required this.idVitalia,
  });

  // Firestore -> PatientModel
  // La fonction fromMap convertit une donnée Firestore en objet Flutter.

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      nom: map['nom'],
      telephone: map['telephone'],
      idVitalia: map['idVitalia'],

    );
  }
  // PatientModel -> Firestore
  // La fonction toMap convertit l’objet Flutter pour l’envoyer à Firestore.
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'telephone': telephone,
      'idVitalia': idVitalia,

    };
  }
}