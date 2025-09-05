import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/modeles/consultation_model.dart';


class FirestoreService {
  final CollectionReference patients =
  FirebaseFirestore.instance.collection('patients');

  // ------------------- PATIENT -------------------

  // Ajouter un patient
  Future<void> addPatient(PatientModel patient) async {
    await patients.add(patient.toMap());
  }
  // Récupérer un patient par téléphone + ID Vitalia (connexion)
  Future<PatientModel?> getPatientByPhoneAndID(
      String phone, String idVitalia) async {
    final query = await patients
        .where('telephone', isEqualTo: phone)
        .where('idVitalia', isEqualTo: idVitalia)
        .get();

    if (query.docs.isNotEmpty) {
      final doc = query.docs.first;
      return PatientModel.fromMap(
          query.docs.first.data() as Map<String, dynamic> , doc.id);
    }
    return null;
  }

  // Récupérer un patient par ID Firestore
  Future<PatientModel?> getPatientById(String docId) async {
    final doc = await patients.doc(docId).get();
    if (doc.exists) {
      return PatientModel.fromMap(doc.data() as Map<String, dynamic> ,  doc.id);
    }
    return null;
  }

  // Mettre à jour les infos d’un patient
  Future<void> updatePatient(String docId, PatientModel patient) async {
    await patients.doc(docId).update(patient.toMap());
  }

  // Mettre à jour uniquement la photo d’un patient
  Future<void> updatePatientPhoto(String docId, String photoUrl) async {
    await patients.doc(docId).update({'photoUrl': photoUrl});
  }

  // ------------------- CONSULTATIONS -------------------
/*
  /// Ajouter une consultation à un patient
  Future<void> addConsultation(
      String patientDocId, ConsultationModel consultation) async {
    final doc = await patients.doc(patientDocId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> consultations = data['consultations'] ?? [];
      consultations.add(consultation.toMap());
      await patients.doc(patientDocId).update({'consultations': consultations});
    }
  }

  /// Récupérer toutes les consultations d’un patient
  Future<List<ConsultationModel>> getConsultations(String patientDocId) async {
    final doc = await patients.doc(patientDocId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> consultations = data['consultations'] ?? [];
      return consultations
          .map((c) =>
          ConsultationModel.fromMap(Map<String, dynamic>.from(c)))
          .toList();
    }
    return [];
  }

  /// Supprimer une consultation spécifique
  Future<void> deleteConsultation(
      String patientDocId, ConsultationModel consultation) async {
    await patients.doc(patientDocId).update({
      'consultations': FieldValue.arrayRemove([consultation.toMap()])
    });
  }
*/
  // Ajouter une consultation à un patient (dans la sous-collection)
  Future<void> addConsultation(
      String patientDocId, ConsultationModel consultation) async {
    await patients
        .doc(patientDocId)
        .collection('consultations') // ← sous-collection
        .add(consultation.toMap());
  }

  /// Récupérer toutes les consultations d’un patient (depuis la sous-collection)
  Future<List<ConsultationModel>> getConsultations(String patientDocId) async {
    final querySnapshot = await patients
        .doc(patientDocId)
        .collection('consultations')
        .get();

    return querySnapshot.docs
        .map((doc) => ConsultationModel.fromMap(doc.data()))
        .toList();
  }
  // ------------------- AUTRES -------------------

  // Ajouter un traitement à un patient
  Future<void> addTraitement(
      String docId, Map<String, dynamic> traitement) async {
    final doc = await patients.doc(docId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> traitements = data['traitements'] ?? [];
      traitements.add(traitement);
      await patients.doc(docId).update({'traitements': traitements});
    }
  }

  // Ajouter une ordonnance à un patient
  Future<void> addOrdonnance(
      String docId, Map<String, dynamic> ordonnance) async {
    final doc = await patients.doc(docId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> ordonnances = data['ordonnances'] ?? [];
      ordonnances.add(ordonnance);
      await patients.doc(docId).update({'ordonnances': ordonnances});
    }
  }

  // Ajouter un rendez-vous à un patient
  Future<void> addRendezVous(String docId, Map<String, dynamic> rdv) async {
    final doc = await patients.doc(docId).get();
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      final List<dynamic> rendezVous = data['rendezVous'] ?? [];
      rendezVous.add(rdv);
      await patients.doc(docId).update({'rendezVous': rendezVous});
    }
  }
}
/*
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

// === MODELS ===
// Adapte les imports à tes chemins réels :
import '../modeles/rendezvous_model.dart';
import 'package:vitalia_app/modeles/admin_model.dart';
import 'package:vitalia_app/modeles/consultation_model.dart';
import 'package:vitalia_app/modeles/centre_model.dart';

import 'package:vitalia_app/modeles/patient_model.dart';
class FirestoreService {
  FirestoreService(); // 👈
  // constructeur public par défaut
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // =========================================================
  //                       PATIENTS
  // =========================================================

  /// Ajout d’un patient (admin). Si [withId] est fourni, on force l’id du doc.
  Future<String> addPatient(PatientModel p, {String? withId}) async {
    if (withId != null) {
      await _db.collection('patients').doc(withId).set(p.toMap());
      return withId;
    }
    final ref = await _db.collection('patients').add(p.toMap());
    return ref.id;
  }

  Future<void> updatePatient(String patientId, PatientModel p) async {
    await _db.collection('patients').doc(patientId).update(p.toMap());
  }

  Future<void> updatePatientPhoto(String patientId, String photoUrl) async {
    await _db.collection('patients').doc(patientId).update({'photoUrl': photoUrl});
  }

  Future<void> deletePatient(String patientId) async {
    await _db.collection('patients').doc(patientId).delete();
  }

  Future<PatientModel?> getPatientById(String patientId) async {
    final doc = await _db.collection('patients').doc(patientId).get();
    if (!doc.exists) return null;
    return PatientModel.fromMap(doc.data()!, doc.id);
  }

  /// Connexion côté app : vérifie que le couple (téléphone, idVitalia) existe.
  Future<PatientModel?> getPatientByPhoneAndVitalia(String phone, String idVitalia) async {
    final q = await _db.collection('patients')
        .where('telephone', isEqualTo: phone)
        .where('idVitalia', isEqualTo: idVitalia)
        .limit(1)
        .get();
    if (q.docs.isEmpty) return null;
    final d = q.docs.first;
    return PatientModel.fromMap(d.data(), d.id);
  }

  Future<List<PatientModel>> listPatients({int? limit}) async {
    Query<Map<String, dynamic>> q = _db.collection('patients');
    if (limit != null) q = q.limit(limit);
    final snap = await q.get();
    return snap.docs.map((d) => PatientModel.fromMap(d.data(), d.id)).toList();
  }

  /// Stream temps réel : utile avec Provider/Consumer.
  Stream<List<PatientModel>> patientsStream() {
    return _db.collection('patients').snapshots().map(
          (snap) => snap.docs.map((d) => PatientModel.fromMap(d.data(), d.id)).toList(),
    );
  }

  // =========================================================
  //                       CENTRES
  // =========================================================

  Future<String> addCentre(CentreModel c, {String? withId}) async {
    if (withId != null) {
      await _db.collection('centres').doc(withId).set(c.toMap());
      return withId;
    }
    final ref = await _db.collection('centres').add(c.toMap());
    return ref.id;
  }

  Future<void> updateCentre(String centreId, CentreModel c) async {
    await _db.collection('centres').doc(centreId).update(c.toMap());
  }

  Future<void> deleteCentre(String centreId) async {
    await _db.collection('centres').doc(centreId).delete();
  }

  Future<CentreModel?> getCentreById(String centreId) async {
    final doc = await _db.collection('centres').doc(centreId).get();
    if (!doc.exists) return null;
    return CentreModel.fromMap(doc.data()!, doc.id);
  }

  Future<List<CentreModel>> listCentres() async {
    final snap = await _db.collection('centres').get();
    return snap.docs.map((d) => CentreModel.fromMap(d.data(), d.id)).toList();
  }

  Stream<List<CentreModel>> centresStream() {
    return _db.collection('centres').snapshots().map(
          (snap) => snap.docs.map((d) => CentreModel.fromMap(d.data(), d.id)).toList(),
    );
  }

  // =========================================================
  //                       ADMINS
  // =========================================================

  Future<String> addAdmin(AdminModel a, {String? withId}) async {
    if (withId != null) {
      await _db.collection('admins').doc(withId).set(a.toMap());
      return withId;
    }
    final ref = await _db.collection('admins').add(a.toMap());
    return ref.id;
  }

  Future<AdminModel?> getAdminById(String adminId) async {
    final doc = await _db.collection('admins').doc(adminId).get();
    if (!doc.exists) return null;
    return AdminModel.fromMap(doc.data()!, doc.id);
  }

  // =========================================================
  //                     CONSULTATIONS
  // =========================================================

  Future<String> addConsultation(ConsultationModel c, ConsultationModel consultation, {String? withId}) async {
    if (withId != null) {
      await _db.collection('consultations').doc(withId).set(c.toMap());
      return withId;
    }
    final ref = await _db.collection('consultations').add(c.toMap());
    return ref.id;
  }

  Future<void> updateConsultation(String id, ConsultationModel c) async {
    await _db.collection('consultations').doc(id).update(c.toMap());
  }

  Future<void> deleteConsultation(String id) async {
    await _db.collection('consultations').doc(id).delete();
  }

  Future<ConsultationModel?> getConsultationById(String id) async {
    final doc = await _db.collection('consultations').doc(id).get();
    if (!doc.exists) return null;
    return ConsultationModel.fromMap(doc.data()!);
  }

  Future<List<ConsultationModel>> consultationsByPatient(String patientId) async {
    final snap = await _db.collection('consultations')
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .get();
    return snap.docs.map((d) => ConsultationModel.fromMap(d.data())).toList();
  }

  Future<List<ConsultationModel>> consultationsByCentre(String centreId) async {
    final snap = await _db.collection('consultations')
        .where('centreId', isEqualTo: centreId)
        .orderBy('date', descending: true)
        .get();
    return snap.docs.map((d) => ConsultationModel.fromMap(d.data())).toList();
  }

  Stream<List<ConsultationModel>> consultationsByPatientStream(String patientId) {
    return _db.collection('consultations')
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => ConsultationModel.fromMap(d.data())).toList());
  }

  // =========================================================
  //                       RENDEZ-VOUS
  // =========================================================

  Future<String> addRendezVous(RendezVousModel r, {String? withId}) async {
    if (withId != null) {
      await _db.collection('rendezvous').doc(withId).set(r.toMap());
      return withId;
    }
    final ref = await _db.collection('rendezvous').add(r.toMap());
    return ref.id;
  }

  Future<void> updateRendezVous(String id, RendezVousModel r) async {
    await _db.collection('rendezvous').doc(id).update(r.toMap());
  }

  Future<void> deleteRendezVous(String id) async {
    await _db.collection('rendezvous').doc(id).delete();
  }

  Future<List<RendezVousModel>> rdvByPatient(String patientId) async {
    final snap = await _db.collection('rendezvous')
        .where('patientId', isEqualTo: patientId)
        .orderBy('date')
        .get();
    return snap.docs.map((d) => RendezVousModel.fromDoc(d)).toList();
  }

  Future<List<RendezVousModel>> rdvByCentre(String centreId) async {
    final snap = await _db.collection('rendezvous')
        .where('centreId', isEqualTo: centreId)
        .orderBy('date')
        .get();
    return snap.docs.map((d) => RendezVousModel.fromDoc(d)).toList();
  }

  Stream<List<RendezVousModel>> rdvByCentreStream(String centreId) {
    return _db.collection('rendezvous')
        .where('centreId', isEqualTo: centreId)
        .orderBy('date')
        .snapshots()
        .map((s) => s.docs.map((d) => RendezVousModel.fromDoc(d)).toList());
  }
  // =========================================================
  //               OUTILS : ID Vitalia & Storage
  // =========================================================

  /// Génère un id Vitalia lisible (ex: VIT-2025-034512)
  String generateIdVitalia() {
    final y = DateTime.now().year;
    final rnd = Random().nextInt(900000) + 100000; // 6 chiffres
    return 'VIT-$y-$rnd';
  }

  /// Upload d’une ordonnance (image/PDF) et retourne l’URL de téléchargement.
  /// [fileName] (optionnel) pour garder un nom propre.
  Future<String> uploadOrdonnanceFile(File file, String consultationId, {String? fileName}) async {
    final name = fileName ??
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final ref = _storage.ref().child('ordonnances/$consultationId/$name');
    final task = await ref.putFile(file, SettableMetadata(contentType: _guessMime(file.path)));
    final url = await task.ref.getDownloadURL();
    return url;
  }

  /// Upload d’une photo de profil patient/centre
  Future<String> uploadProfilePhoto(File file, String userId, {bool isCentre = false}) async {
    final folder = isCentre ? 'centres' : 'patients';
    final name = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    final ref = _storage.ref().child('$folder/$userId/$name');
    final task = await ref.putFile(file, SettableMetadata(contentType: _guessMime(file.path)));
    return task.ref.getDownloadURL();
  }

  String _guessMime(String path) {
    final ext = path.toLowerCase().split('.').last;
    switch (ext) {
      case 'png': return 'image/png';
      case 'jpg':
      case 'jpeg': return 'image/jpeg';
      case 'pdf': return 'application/pdf';
      default: return 'application/octet-stream';
    }
  }
}*/
