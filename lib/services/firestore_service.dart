import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/modeles/consultation_model.dart';

import '../modeles/admin_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // -------------------- PATIENTS --------------------
  final String collectionPatients = 'patients';

  Future<void> addPatient(PatientModel patient) async {
    await _db.collection(collectionPatients).doc(patient.idVitalia).set(patient.toMap());
  }

  Future<PatientModel?> getPatientByPhoneAndID(String phone, String idVitalia) async {
    final doc = await _db.collection(collectionPatients).doc(idVitalia).get();
    if (doc.exists && doc.data()!['telephone'] == phone) {
      return PatientModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<PatientModel?> getPatientById(String idVitalia) async {
    final doc = await _db.collection(collectionPatients).doc(idVitalia).get();
    if (doc.exists) return PatientModel.fromMap(doc.data()!, doc.id);
    return null;
  }

  Future<void> updatePatient(String idVitalia, PatientModel updatedPatient) async {
    await _db.collection(collectionPatients).doc(idVitalia).update(updatedPatient.toMap());
  }

  Future<void> updatePatientPhoto(String idVitalia, String photoUrl) async {
    await _db.collection(collectionPatients).doc(idVitalia).update({'photoUrl': photoUrl});
  }

  Future<void> deletePatient(String idVitalia) async {
    await _db.collection(collectionPatients).doc(idVitalia).delete();
  }

  Future<List<PatientModel>> listPatients({int? limit}) async {
    Query<Map<String, dynamic>> query = _db.collection(collectionPatients);
    if (limit != null) query = query.limit(limit);
    final snap = await query.get();
    return snap.docs.map((d) => PatientModel.fromMap(d.data(), d.id)).toList();
  }

  Stream<List<PatientModel>> patientsStream() {
    return _db.collection(collectionPatients).snapshots().map(
          (snap) => snap.docs.map((d) => PatientModel.fromMap(d.data(), d.id)).toList(),
    );
  }

  // -------------------- CONSULTATIONS --------------------
  final String collectionConsultations = 'consultations';

  Future<String> addConsultation(Consultation consultation) async {
    final ref = await _db.collection(collectionConsultations).add(consultation.toMap());
    return ref.id;
  }

  Future<List<Consultation>> getAllConsultations() async {
    final snap = await _db.collection(collectionConsultations)
        .orderBy('date', descending: true)
        .get();
    return snap.docs.map((d) => Consultation.fromMap(d.data(), d.id)).toList();
  }

  Future<Consultation?> getConsultationById(String id) async {
    final doc = await _db.collection(collectionConsultations).doc(id).get();
    if (doc.exists) return Consultation.fromMap(doc.data()!, doc.id);
    return null;
  }

  Future<List<Consultation>> getConsultationsByPatient(String patientId) async {
    final snap = await _db.collection(collectionConsultations)
        .where('patientId', isEqualTo: patientId)
        .orderBy('date', descending: true)
        .get();
    return snap.docs.map((d) => Consultation.fromMap(d.data(), d.id)).toList();
  }

  Future<void> updateConsultation(String id, Consultation consultation) async {
    await _db.collection(collectionConsultations).doc(id).update(consultation.toMap());
  }

  Future<void> deleteConsultation(String id) async {
    await _db.collection(collectionConsultations).doc(id).delete();
  }

  Stream<List<Consultation>> consultationsStream() {
    return _db.collection(collectionConsultations)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((d) => Consultation.fromMap(d.data(), d.id)).toList());
  }

  // -------------------- ADMINS --------------------
  final String collectionAdmins = 'admins';

// Ajouter un admin
  Future<void> addAdmin(AdminModel admin) async {
    await _db.collection(collectionAdmins).doc(admin.id).set(admin.toMap());
  }

// Récupérer un admin par UID
  Future<AdminModel?> getAdminById(String uid) async {
    final doc = await _db.collection(collectionAdmins).doc(uid).get();
    if (doc.exists) return AdminModel.fromMap(doc.data()!, doc.id);
    return null;
  }

// Lister tous les admins (optionnel)
  Future<List<AdminModel>> listAdmins({int? limit}) async {
    Query<Map<String, dynamic>> query = _db.collection(collectionAdmins);
    if (limit != null) query = query.limit(limit);
    final snap = await query.get();
    return snap.docs.map((d) => AdminModel.fromMap(d.data(), d.id)).toList();
  }

}


