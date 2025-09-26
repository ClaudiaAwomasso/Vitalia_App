/*import 'package:vitalia_app/modeles/consultation_model.dart';

class PatientModel {
  final String id;
  final String nom;
  final String telephone;
  final String idVitalia;
  final int age;
  final String? photoUrl;
  final Map<String, String>? contactUrgence;

  PatientModel({

    required this.id,
    required this.nom,
    required this.telephone,
    required this.idVitalia,
    required this.age,
    this.photoUrl,
    this.contactUrgence,

  });

  // Firestore -> PatientModel
  factory PatientModel.fromMap(Map<String, dynamic> map, String documentId,) {
    return PatientModel(
     id: documentId,
      nom: map['nom'],
      telephone: map['telephone'],
      idVitalia: map['idVitalia'],
      age: map['age'],
      photoUrl: map['photoUrl'],
      contactUrgence: map['contactUrgence'] != null
          ? Map<String, String>.from(map['contactUrgence'])
          : null,
    );
  }
  // PatientModel -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'telephone': telephone,
      'idVitalia': idVitalia,
      'age': age,
      'photoUrl': photoUrl,
      'contactUrgence': contactUrgence,
    };
  }
}
*/



import 'package:vitalia_app/modeles/consultation_model.dart';

class PatientModel {
  final String id;                 // ID Firestore
  final String idVitalia;          // Identifiant unique patient
  final String nom;
  final String prenom;
  final String telephone;
  final String? email;
  final String? adresse;
  final String dateNaissance;      // format "jj/mm/aaaa"
  final String sexe;
  final int age;
  late final String? photoUrl;

  // Contact d’urgence (champs séparés)
  final String? contactNom;
  final String? contactRelation;
  final String? contactTelephone;
  final String? contactEmail;

  // Infos médicales
  final String? antecedentsMedicaux;
  final String? allergies;
  final String? traitementsEnCours;

  final String dateInscription;
  final int consultations;

  PatientModel({
    required this.id,
    required this.idVitalia,
    required this.nom,
    required this.prenom,
    required this.telephone,
    this.email,
    this.adresse,
    required this.dateNaissance,
    required this.sexe,
    required this.age,
    this.photoUrl,
    this.contactNom,
    this.contactRelation,
    this.contactTelephone,
    this.contactEmail,
    this.antecedentsMedicaux,
    this.allergies,
    this.traitementsEnCours,
    required this.dateInscription,
    required this.consultations,
  });

  // Firestore -> PatientModel
  factory PatientModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PatientModel(
      id: documentId,
      idVitalia: map['idVitalia'] ?? "",
      nom: map['nom'] ?? "",
      prenom: map['prenom'] ?? "",
      telephone: map['telephone'] ?? "",
      email: map['email'],
      adresse: map['adresse'],
      dateNaissance: map['dateNaissance'] ?? "",
      sexe: map['sexe'] ?? "",
      age: map['age'] ?? 0,
      photoUrl: map['photoUrl'],
      contactNom: map['contactNom'],
      contactRelation: map['contactRelation'],
      contactTelephone: map['contactTelephone'],
      contactEmail: map['contactEmail'],
      antecedentsMedicaux: map['antecedentsMedicaux'],
      allergies: map['allergies'],
      traitementsEnCours: map['traitementsEnCours'],
      dateInscription: map['dateInscription'] ?? "",
      consultations: map['consultations'] ?? 0,
    );
  }

  // PatientModel -> Firestore
  Map<String, dynamic> toMap() {
    return {
      'idVitalia': idVitalia,
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'adresse': adresse,
      'dateNaissance': dateNaissance,
      'sexe': sexe,
      'age': age,
      'photoUrl': photoUrl,
      'contactNom': contactNom,
      'contactRelation': contactRelation,
      'contactTelephone': contactTelephone,
      'contactEmail': contactEmail,
      'antecedentsMedicaux': antecedentsMedicaux,
      'allergies': allergies,
      'traitementsEnCours': traitementsEnCours,
      'dateInscription': dateInscription,
      'consultations': consultations,
    };
  }
}
