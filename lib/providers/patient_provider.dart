import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/services/firestore_service.dart';

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
