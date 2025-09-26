class CentreModel {
  final String id;
  final String nom;
  final String adresse;
  final String telephone;
  final String email;
  final String profil;
  final String? type;
  final String? directeur;
  final int patients;
  final int medecins;
  final int consultations;
  final String statut; // ⬅️ ajouté


  CentreModel({
    required this.id,
    required this.nom,
    required this.adresse,
    required this.telephone,
    required this.email,
    required this.profil,
    this.type,
    this.directeur,
    this.patients = 0,
    this.medecins = 0,
    this.consultations = 0,
    this.statut = "Actif",
  });

  /// Factory pour reconstruire depuis Firestore
  factory CentreModel.fromMap(Map<String, dynamic> data, String documentId) {
    return CentreModel(
      id: documentId,
      nom: data['nom'] ?? '',
      adresse: data['adresse'] ?? '',
      telephone: data['telephone'] ?? '',
      email: data['email'] ?? '',
      profil: data['profil'] ?? '',
      type: data['type'],
      directeur: data['directeur'],
      patients: data['patients'] ?? 0,
      medecins: data['medecins'] ?? 0,
      consultations: data['consultations'] ?? 0,
      statut: data['statut'] ?? 'Actif',
    );
  }

  /// Conversion vers Map (pour Firestore)
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'adresse': adresse,
      'telephone': telephone,
      'email': email,
      'profil': profil,
      if (type != null) 'type': type,
      if (directeur != null) 'directeur': directeur,
      'patients': patients,
      'medecins': medecins,
      'consultations': consultations,
      'statut': statut,
    };
  }
}
