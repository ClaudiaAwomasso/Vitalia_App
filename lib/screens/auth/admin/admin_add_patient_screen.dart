/*import 'package:flutter/material.dart';
import 'package:vitalia_app/utils/id_generator.dart';
import 'package:vitalia_app/services/firestore_service.dart';
import 'package:vitalia_app/modeles/patient_model.dart';

class AdminAddPatientScreen extends StatefulWidget {
  const AdminAddPatientScreen({super.key});
  @override
  State<AdminAddPatientScreen> createState() => _AdminAddPatientScreenState();
}
class _AdminAddPatientScreenState extends State<AdminAddPatientScreen> {
  final _formKey = GlobalKey<FormState>(); // ✅ clé du formulaire
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _ageController =TextEditingController();

  final FirestoreService _firestore = FirestoreService();
  //get id => null;

  void _addPatient() async {
    // ✅ Vérification avec les validators
    if (!_formKey.currentState!.validate()) {
      return; // si un champ n'est pas valide on arrête
    }
    // Vérifier si le numéro a déjà +229
    String phone = _phoneController.text.trim();
    if (!phone.startsWith("+229")) {
      phone = "+229$phone";
    }

    String idVitalia = generateVitaliaID();
    PatientModel patient = PatientModel(
      id:idVitalia,
      nom: _nameController.text,
      telephone: phone,
      idVitalia: idVitalia,
      age:  _ageController.text.isNotEmpty ? int.parse(_ageController.text) : 0,
    );

    await _firestore.addPatient(patient);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Patient ajouté : ID $idVitalia")),
    );

    _nameController.clear();
    _phoneController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un patient')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey, // ✅ on relie le formulaire
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Nom",
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez renseigner le nom"; // ✅ message sous le champ
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
          TextFormField(
            controller: _ageController,
            decoration: const InputDecoration(
              labelText: "Âge",
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez renseigner votre âge"; // ✅ message sous le champ
              }
              return null;
            },
          ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Veuillez renseigner le téléphone"; // ✅ message sous le champ
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addPatient,
                child: const Text("Enregistrer"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/
