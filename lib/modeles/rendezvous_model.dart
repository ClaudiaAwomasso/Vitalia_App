import 'package:cloud_firestore/cloud_firestore.dart';

class RendezVousModel {
  final String id;
  final DateTime date;
  final String statut;    // "a_venir" | "passe" | "confirme" | "annule"
  final String? centreId; // présent côté patient
  final String? patientId;// présent côté centre

  RendezVousModel({
    required this.id,
    required this.date,
    required this.statut,
    this.centreId,
    this.patientId,
  });

  factory RendezVousModel.fromDoc(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return RendezVousModel(
      id: doc.id,
      date: (data['date'] as Timestamp).toDate(),
      statut: data['statut'] ?? 'a_venir',
      centreId: data['centreId'],
      patientId: data['patientId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'statut': statut,
      if (centreId != null) 'centreId': centreId,
      if (patientId != null) 'patientId': patientId,
    };
  }
}
