import 'package:vitalia_app/modeles/consultation_model.dart';

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
