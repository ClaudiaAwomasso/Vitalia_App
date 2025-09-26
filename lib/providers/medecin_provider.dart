import 'package:flutter/material.dart';
import '../modeles/medecin_model.dart';
import '../services/firebase_auth_service.dart';

class MedecinProvider extends ChangeNotifier {
  final FirebaseService _service = FirebaseService();

  List<MedecinModel> _medecins = [];
  List<MedecinModel> get medecins => _medecins;

  MedecinProvider() {
    _init();
  }

  /// Initialisation : écoute Firestore en temps réel
  void _init() {
    _service.getMedecinsStream().listen((data) {
      _medecins = data;
      notifyListeners();
    });
  }

  /// Ajouter un médecin
  Future<void> ajouterMedecin(MedecinModel medecin) async {
    try {
      await _service.ajouterMedecin(medecin);
    } catch (e) {
      throw Exception("Erreur ajout médecin : $e");
    }
  }

  /// Modifier un médecin
  Future<void> modifierMedecin(MedecinModel medecin) async {
    try {
      await _service.modifierMedecin(medecin);
    } catch (e) {
      throw Exception("Erreur modification médecin : $e");
    }
  }

  /// Supprimer un médecin
  Future<void> supprimerMedecin(String id) async {
    try {
      await _service.supprimerMedecin(id);
    } catch (e) {
      throw Exception("Erreur suppression médecin : $e");
    }
  }

  /// Récupérer un médecin par ID
  Future<MedecinModel?> getMedecinById(String id) async {
    try {
      return await _service.getMedecinById(id);
    } catch (e) {
      throw Exception("Erreur récupération médecin : $e");
    }
  }
}
