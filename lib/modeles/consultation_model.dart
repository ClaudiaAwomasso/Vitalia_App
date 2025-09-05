import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConsultationModel {
  final String id;
  final String titre;
  final String medecin;
  final String lieu;
  final DateTime date;
  final String diagnostic;
  final List<Traitement> traitements;
  final List<Ordonnance> ordonnances;
  ConsultationModel({
    required this.id,
    required this.titre,
    required this.medecin,
    required this.lieu,
    required this.date,
    required this.diagnostic,
    this.traitements = const [],
    this.ordonnances = const [],
  });

  factory ConsultationModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ConsultationModel(
      id: id ?? map['id'] ?? "",
      titre: map['titre'] ?? "",
      medecin: map['medecin'] ?? "",
      lieu: map['lieu'] ?? "",
      date: (map['date'] as Timestamp).toDate(),
      diagnostic: map['diagnostic'] ?? "",
      traitements: (map['traitements'] as List<dynamic>? ?? [])
          .map((t) => Traitement.fromMap(t))
          .toList(),
      ordonnances: (map['ordonnances'] as List<dynamic>? ?? [])
          .map((o) => Ordonnance.fromMap(o))
          .toList(),
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'medecin': medecin,
      'lieu': lieu,
      'date': Timestamp.fromDate(date),
      'diagnostic': diagnostic,
      'traitements': traitements.map((t) => t.toMap()).toList(),
      'ordonnances': ordonnances.map((o) => o.toMap()).toList(),
    };
  }
}
// traitement_model.dart ou dans consultation_model.dart

class Traitement {
  final String medicament;
  final String dosage;
  final String frequence;

  Traitement({
    required this.medicament,
    required this.dosage,
    required this.frequence,
  });

  factory Traitement.fromMap(Map<String, dynamic> map) {
    return Traitement(
      medicament: map['medicament'] ?? "",
      dosage: map['dosage'] ?? "",
      frequence: map['frequence'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicament': medicament,
      'dosage': dosage,
      'frequence': frequence,
    };
  }
}

class Ordonnance {
  final String medicaments;
  final String date;

  Ordonnance({
    required this.medicaments,
    required this.date,
  });

  factory Ordonnance.fromMap(Map<String, dynamic> map) {
    return Ordonnance(
      medicaments: map['medicaments'] ?? "",
      date: map['date'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'medicaments': medicaments,
      'date': date,
    };
  }
}
