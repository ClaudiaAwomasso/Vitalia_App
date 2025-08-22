import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitalia_app/modeles/patient_model.dart';


class FirestoreService{

  final CollectionReference patients = FirebaseFirestore.instance.collection('patients');


  // Ajouter un patient
  /*
  addPatient : ajoute un patient dans Firestore.
 */
  Future<void> addPatient(PatientModel patient) async {
    await patients.add(patient.toMap());
  }


  // Vérifier patient par téléphone + ID Vitalia

  /*

  getPatientByPhoneAndID : vérifie la connexion patient.
  */
  Future<PatientModel?> getPatientByPhoneAndID(
      String phone, String idVitalia) async {
    final query = await patients
        .where('phone', isEqualTo: phone)
        .where('idVitalia', isEqualTo: idVitalia)
        .get();

    if (query.docs.isNotEmpty) {
      return PatientModel.fromMap(query.docs.first.data() as Map<String, dynamic>);
    }
    return null;
  }
}