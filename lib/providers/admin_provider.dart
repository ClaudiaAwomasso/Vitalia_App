import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vitalia_app/modeles/admin_model.dart';
import 'package:vitalia_app/services/firestore_service.dart';

class AdminProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  AdminModel? _admin;
  AdminModel? get admin => _admin;

  bool _loading = false;
  bool get loading => _loading;

  // 🔹 Inscription Admin
  Future<String?> registerAdmin({
    required String nom,
    required String email,
    required String telephone,
    required String password,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      // 1️⃣ Créer utilisateur Firebase Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // 2️⃣ Créer modèle Admin
      AdminModel newAdmin = AdminModel(
        id: uid,
        nom: nom,
        email: email,
        telephone: telephone,
      );

      // 3️⃣ Enregistrer dans Firestore
      await _firestoreService.addAdmin(newAdmin);

      _admin = newAdmin;
      _loading = false;
      notifyListeners();
      return null; // succès
    } on FirebaseAuthException catch (e) {
      _loading = false;
      notifyListeners();
      return e.message;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return e.toString();
    }
  }

  // 🔹 Connexion Admin
  Future<String?> loginAdmin({
    required String email,
    required String password,
  }) async {
    try {
      _loading = true;
      notifyListeners();

      // 1️⃣ Connexion Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String uid = userCredential.user!.uid;

      // 2️⃣ Récupérer les infos de l'admin depuis Firestore
      AdminModel? fetchedAdmin = await _firestoreService.getAdminById(uid);

      if (fetchedAdmin == null) {
        _loading = false;
        notifyListeners();
        return "Admin non trouvé dans Firestore";
      }

      _admin = fetchedAdmin;
      _loading = false;
      notifyListeners();
      return null; // succès
    } on FirebaseAuthException catch (e) {
      _loading = false;
      notifyListeners();
      return e.message;
    } catch (e) {
      _loading = false;
      notifyListeners();
      return e.toString();
    }
  }

  // 🔹 Déconnexion
  Future<void> logout() async {
    await _auth.signOut();
    _admin = null;
    notifyListeners();
  }
}
