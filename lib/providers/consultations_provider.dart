import 'package:flutter/material.dart';
import 'package:vitalia_app/modeles/consultation_model.dart';
import 'package:vitalia_app/services/firestore_service.dart';

import '../services/firestore_service.dart';

class ConsultationProvider extends ChangeNotifier {
  final FirestoreService _firestore = FirestoreService();

  List<Consultation> _consultations = [];
  Consultation? _consultation; // consultation courante (optionnel)
  bool _isLoading = false;

  List<Consultation> get consultations => _consultations;
  Consultation? get consultation => _consultation;
  bool get isLoading => _isLoading;

  // ==================== AJOUTER ====================
  Future<void> addConsultation(Consultation consultation) async {
    try {
      final id = await _firestore.addConsultation(consultation);
      _consultations.add(
        Consultation(
          id: id,
          patientId: consultation.patientId,
          medecinId: consultation.medecinId,
          date: consultation.date,
          motif: consultation.motif,
          statut: consultation.statut,
          diagnostic: consultation.diagnostic,
          notes: consultation.notes,
          ordonnances: consultation.ordonnances,
          traitements: consultation.traitements,
          antecedents: consultation.antecedents,
        ),
      );
      notifyListeners();
    } catch (e) {
      debugPrint("Erreur ajout consultation: $e");
    }
  }

  // ==================== CHARGER ====================
  Future<void> fetchAllConsultations() async {
    _isLoading = true;
    notifyListeners();
    try {
      _consultations = await _firestore.getAllConsultations();
    } catch (e) {
      debugPrint("Erreur fetch consultations: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchConsultationsByPatient(String patientId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _consultations = await _firestore.getConsultationsByPatient(patientId);
    } catch (e) {
      debugPrint("Erreur fetch consultations patient: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  // ==================== METTRE À JOUR ====================
  Future<void> updateConsultation(String id, Consultation updated) async {
    try {
      await _firestore.updateConsultation(id, updated);
      final index = _consultations.indexWhere((c) => c.id == id);
      if (index != -1) {
        _consultations[index] = updated;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Erreur update consultation: $e");
    }
  }

  // ==================== SUPPRIMER ====================
  Future<void> deleteConsultation(String id) async {
    try {
      await _firestore.deleteConsultation(id);
      _consultations.removeWhere((c) => c.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Erreur delete consultation: $e");
    }
  }

  // ==================== STREAM ====================
  Stream<List<Consultation>> consultationsStream() {
    return _firestore.consultationsStream();
  }
}
