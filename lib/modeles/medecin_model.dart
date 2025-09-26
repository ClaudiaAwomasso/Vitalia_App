class MedecinModel {
  final String id;
  final String nom;
  final String prenom;
  final String specialite;
  final String centre;
  final String email;
  final String telephone;
  final String dateInscription;
  final int patients;
  final int consultations;
  final String statut;

  MedecinModel({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.specialite,
    required this.centre,
    required this.email,
    required this.telephone,
    required this.dateInscription,
    this.patients = 0,
    this.consultations = 0,
    this.statut = 'Actif',
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'prenom': prenom,
      'specialite': specialite,
      'centre': centre,
      'email': email,
      'telephone': telephone,
      'dateInscription': dateInscription,
      'patients': patients,
      'consultations': consultations,
      'statut': statut,
    };
  }

  factory MedecinModel.fromMap(Map<String, dynamic> map, String id) {
    return MedecinModel(
      id: id,
      nom: map['nom'] ?? '',
      prenom: map['prenom'] ?? '',
      specialite: map['specialite'] ?? '',
      centre: map['centre'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      dateInscription: map['dateInscription'] ?? '',
      patients: map['patients'] ?? 0,
      consultations: map['consultations'] ?? 0,
      statut: map['statut'] ?? 'Actif',
    );
  }
}
