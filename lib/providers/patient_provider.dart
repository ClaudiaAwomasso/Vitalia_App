import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/services/firestore_service.dart';

import '../modeles/consultation_model.dart';
/*
class PatientProvider extends ChangeNotifier {
  PatientModel? _patient; // patient connecté
  final FirestoreService _firestore = FirestoreService();

  PatientModel? get patient => _patient;

  // Connexion patient
  Future<bool> login(String phone, String idVitalia) async {
    final result = await _firestore.getPatientByPhoneAndID(phone, idVitalia);
    if (result != null) {
      _patient = result;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Déconnexion
  void logout() {
    _patient = null;
    notifyListeners();
  }

  // Mettre à jour le profil complet
  Future<void> updatePatient(PatientModel updatedPatient) async {
    if (_patient != null) {
      await _firestore.updatePatient(_patient!.idVitalia, updatedPatient);
      _patient = updatedPatient;
      notifyListeners();
    }
  }

  // 🔹 Mettre à jour uniquement la photo de profil
  Future<void> updatePatientPhoto() async {
    if (_patient == null) return;

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    File file = File(image.path);

    // 📂 Upload vers Firebase Storage
    final ref = FirebaseStorage.instance
        .ref()
        .child("patients_photos/${_patient!.idVitalia}.jpg");

    await ref.putFile(file);
    String downloadUrl = await ref.getDownloadURL();

    // 🔥 Mise à jour Firestore
    await _firestore.updatePatientPhoto(_patient!.idVitalia, downloadUrl);

    // ✅ Mise à jour locale du provider
    _patient = PatientModel(
      id: _patient!.id,
      idVitalia: _patient!.idVitalia,
      nom: _patient!.nom,
      telephone: _patient!.telephone,
      age: _patient!.age,
      photoUrl: downloadUrl,
    );

    notifyListeners();
  }

  /*// Ajouter un traitement
  Future<void> addTraitement(Map<String, dynamic> traitement) async {
    if (_patient != null) {
      await _firestore.addTraitement(_patient!.idVitalia, traitement);
      notifyListeners();
    }
  }

  // Ajouter une ordonnance
  Future<void> addOrdonnance(Map<String, dynamic> ordonnance) async {
    if (_patient != null) {
      await _firestore.addOrdonnance(_patient!.idVitalia, ordonnance);
      notifyListeners();
    }
  }

  // Ajouter un rendez-vous
  Future<void> addRendezVous(Map<String, dynamic> rdv) async {
    if (_patient != null) {
      await _firestore.addRendezVous(_patient!.idVitalia, rdv);
      notifyListeners();
    }
  }*/
}
*/
/*
class PatientProvider extends ChangeNotifier {
  PatientModel? _patient; // patient connecté
  final FirestoreService _firestore = FirestoreService();

  PatientModel? get patient => _patient;

  // Méthode pour ajouter un patient
  Future<void> addPatient(PatientModel patient) async {
    await _firestore.addPatient(patient);
    // Optionnel : tu peux mettre à jour une liste locale de patients ici si nécessaire
    notifyListeners();
  }

  // Connexion patient
  Future<bool> login(String phone, String idVitalia) async {
    final result = await _firestore.getPatientByPhoneAndID(phone, idVitalia);
    if (result != null) {
      _patient = result;
      notifyListeners();
      return true;
    }
    return false;
  }

  // Déconnexion
  void logout() {
    _patient = null;
    notifyListeners();
  }

  // Mettre à jour le profil complet
  Future<void> updatePatient(PatientModel updatedPatient) async {
    if (_patient != null) {
      await _firestore.updatePatient(_patient!.idVitalia, updatedPatient);
      _patient = updatedPatient;
      notifyListeners();
    }
  }

  // Mettre à jour uniquement la photo de profil
  Future<void> updatePatientPhoto() async {
    if (_patient == null) return;

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child("patients_photos/${_patient!.idVitalia}.jpg");
    await ref.putFile(file);
    String downloadUrl = await ref.getDownloadURL();

    await _firestore.updatePatientPhoto(_patient!.idVitalia, downloadUrl);
    _patient = PatientModel(
      id: _patient!.id,
      idVitalia: _patient!.idVitalia,
      nom: _patient!.nom,
      prenom: _patient!.prenom,
      telephone: _patient!.telephone,
      dateNaissance: _patient!.dateNaissance,
      sexe: _patient!.sexe,
      age: _patient!.age,
      photoUrl: downloadUrl,
      email: _patient!.email,
      adresse: _patient!.adresse,
      contactNom: _patient!.contactNom,
      contactRelation: _patient!.contactRelation,
      contactTelephone: _patient!.contactTelephone,
      contactEmail: _patient!.contactEmail,
      antecedentsMedicaux: _patient!.antecedentsMedicaux,
      allergies: _patient!.allergies,
      traitementsEnCours: _patient!.traitementsEnCours,
    );

    notifyListeners();
  }
}
*/


class PatientProvider extends ChangeNotifier {
  PatientModel? _patient;
  final FirestoreService _firestore = FirestoreService();

  // -------------------- PATIENT --------------------
  PatientModel? get patient => _patient;

  /// Ajouter un nouveau patient
  Future<void> addPatient(PatientModel patient) async {
    await _firestore.addPatient(patient);
    notifyListeners();
  }

  /// Connexion patient
  Future<bool> login(String phone, String idVitalia) async {
    final result = await _firestore.getPatientByPhoneAndID(phone, idVitalia);
    if (result != null) {
      _patient = result;
      notifyListeners();
      return true;
    }
    return false;
  }

  /// Déconnexion patient
  void logout() {
    _patient = null;
    notifyListeners();
  }

  /// Mettre à jour toutes les infos du patient
  Future<void> updatePatient(PatientModel updatedPatient) async {
    if (_patient == null) return;
    await _firestore.updatePatient(_patient!.idVitalia, updatedPatient);
    _patient = updatedPatient;
    notifyListeners();
  }

  /// Mettre à jour uniquement la photo de profil
  Future<void> updatePatientPhoto() async {
    if (_patient == null) return;

    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    File file = File(image.path);
    final ref = FirebaseStorage.instance
        .ref()
        .child("patients_photos/${_patient!.idVitalia}.jpg");

    await ref.putFile(file);
    String downloadUrl = await ref.getDownloadURL();

    await _firestore.updatePatientPhoto(_patient!.idVitalia, downloadUrl);

    _patient!.photoUrl = downloadUrl;
    notifyListeners();
  }

  // -------------------- CONSULTATIONS --------------------
  List<Consultation> _consultations = [];

  List<Consultation> get consultations => _consultations;

  /// Récupérer toutes les consultations d’un patient
  Future<void> fetchConsultationsForPatient(String patientId) async {
    _consultations =
    await _firestore.getConsultationsByPatient(patientId);
    notifyListeners();
  }

  /// Ajouter une consultation pour ce patient
  Future<void> addConsultation(Consultation consultation) async {
    final id = await _firestore.addConsultation(consultation);
    // Rafraîchir la liste
    await fetchConsultationsForPatient(consultation.patientId);
  }

  /// Mettre à jour une consultation
  Future<void> updateConsultation(Consultation consultation) async {
    if (consultation.id.isEmpty) return;
    await _firestore.updateConsultation(consultation.id, consultation);
    await fetchConsultationsForPatient(consultation.patientId);
  }

  /// Supprimer une consultation
  Future<void> deleteConsultation(Consultation consultation) async {
    if (consultation.id.isEmpty) return;
    await _firestore.deleteConsultation(consultation.id);
    await fetchConsultationsForPatient(consultation.patientId);
  }
}
