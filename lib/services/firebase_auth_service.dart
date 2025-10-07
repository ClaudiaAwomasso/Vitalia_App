
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../modeles/centre_model.dart';
import 'package:vitalia_app/modeles/medecin_model.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Inscription d’un centre
  Future<CentreModel?> registerCentre({
    required String email,
    required String password,
    required String nom,
    required String adresse,
    required String telephone,
    String type = '',
    String directeur = '',
    String profil = '',
    int patients = 0,
    int medecins = 0,
    int consultations = 0,
    String statut = 'Actif',
  }) async {
    try {
      // Création Auth
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) return null;

      // Création modèle
      final centreData = CentreModel(
        id: uid,
        nom: nom,
        adresse: adresse,
        telephone: telephone,
        email: email,
        profil: profil,
        type: type.isNotEmpty ? type : null,
        directeur: directeur.isNotEmpty ? directeur : null,
        patients: patients,
        medecins: medecins,
        consultations: consultations,
        statut: statut,
      );

      final data = centreData.toMap();
      data['createdAt'] = FieldValue.serverTimestamp();

      print('Saving centre for uid $uid : $data');

      // Sauvegarde Firestore
      await _firestore.collection('centres').doc(uid).set(data);

      return centreData;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw Exception("Cet email est déjà utilisé.");
      } else if (e.code == 'weak-password') {
        throw Exception("Mot de passe trop faible.");
      } else {
        throw Exception("Erreur Auth: ${e.message}");
      }
    } catch (e) {
      throw Exception("Erreur inscription centre: $e");
    }
  }

  /// Connexion
  Future<CentreModel?> loginCentre({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user?.uid;
      if (uid == null) return null;

      final doc = await _firestore.collection('centres').doc(uid).get();
      if (!doc.exists) return null;

      return CentreModel.fromMap(doc.data()!, uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("Aucun compte trouvé pour cet email.");
      } else if (e.code == 'wrong-password') {
        throw Exception("Mot de passe incorrect.");
      } else {
        throw Exception("Erreur Auth: ${e.message}");
      }
    } catch (e) {
      throw Exception("Erreur login centre: $e");
    }
  }

  /// Mise à jour d’un centre
  Future<void> updateCentre(String id, CentreModel centre) async {
    await _firestore.collection('centres').doc(id).update(centre.toMap());
  }

  /// Suppression d’un centre
  Future<void> deleteCentre(String id) async {
    await _firestore.collection('centres').doc(id).delete();
  }

  /// Liste complète des centres (snap unique)
  Future<List<CentreModel>> listCentres() async {
    final snap = await _firestore.collection('centres').get();
    return snap.docs.map((d) => CentreModel.fromMap(d.data(), d.id)).toList();
  }

  /// Stream temps réel des centres (pour l’UI avec Provider/StreamBuilder)
  Stream<List<CentreModel>> centresStream() {
    return _firestore.collection('centres').snapshots().map(
          (snap) => snap.docs.map((d) => CentreModel.fromMap(d.data(), d.id)).toList(),
    );
  }

  /// Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }


  /// Ajouter un médecin
  Future<void> ajouterMedecin(MedecinModel medecin) async {
    final docRef = _firestore.collection('medecins').doc();
    await docRef.set(medecin.toMap());
  }

  /// Modifier un médecin
  Future<void> modifierMedecin(MedecinModel medecin) async {
    await _firestore.collection('medecins').doc(medecin.id).update(medecin.toMap());
  }

  /// Supprimer un médecin
  Future<void> supprimerMedecin(String id) async {
    await _firestore.collection('medecins').doc(id).delete();
  }

  /// Stream pour récupérer la liste des médecins en temps réel
  Stream<List<MedecinModel>> getMedecinsStream() {
    return _firestore.collection('medecins').snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => MedecinModel.fromMap(doc.data(), doc.id))
          .toList();
    });
  }

  /// Récupérer un médecin par ID
  Future<MedecinModel?> getMedecinById(String id) async {
    final doc = await _firestore.collection('medecins').doc(id).get();
    if (!doc.exists) return null;
    return MedecinModel.fromMap(doc.data()!, doc.id);
  }
}

