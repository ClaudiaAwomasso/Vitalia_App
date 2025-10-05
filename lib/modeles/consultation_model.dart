import 'package:cloud_firestore/cloud_firestore.dart';

class Consultation {
  final String id; // ID du document Firestore
  final String patientId;
  final String? medecinId;  // facultatif
  final DateTime date;
  final String? motif;      // facultatif
  final String? statut;     // facultatif
  final String diagnostic;
  final String notes;
  final List<String> ordonnances;
  final List<String> traitements;
  final List<String> antecedents;

  Consultation({
    required this.id,
    required this.patientId,
    this.medecinId,
    required this.date,
    this.motif,
    this.statut,
    required this.diagnostic,
    required this.notes,
    required this.ordonnances,
    required this.traitements,
    required this.antecedents,
  });

  // Firestore → Objet
  factory Consultation.fromMap(Map<String, dynamic> data, String documentId) {
    return Consultation(
      id: documentId,
      patientId: data['patientId'] ?? '',
      medecinId: data['medecinId'],
      date: data['date'] != null
          ? (data['date'] as Timestamp).toDate()
          : DateTime.now(),
      motif: data['motif'],
      statut: data['statut'],
      diagnostic: data['diagnostic'] ?? '',
      notes: data['notes'] ?? '',
      ordonnances: List<String>.from(data['ordonnances'] ?? []),
      traitements: List<String>.from(data['traitements'] ?? []),
      antecedents: List<String>.from(data['antecedents'] ?? []),
    );
  }

  // Objet → Firestore
  Map<String, dynamic> toMap() {
    return {
      'patientId': patientId,
      'medecinId': medecinId ?? '',  // toujours présent
      'date': Timestamp.fromDate(date),
      'motif': motif ?? '',          // toujours présent
      'statut': statut ?? '',        // toujours présent
      'diagnostic': diagnostic,
      'notes': notes,
      'ordonnances': ordonnances,
      'traitements': traitements,
      'antecedents': antecedents,
    };
  }
}
