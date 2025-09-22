import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/services/firestore_service.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/utils/id_generator.dart';

import '../../../providers/patient_provider.dart';

class NouveauDossierPatientPage extends StatefulWidget {
  const NouveauDossierPatientPage({super.key});

  @override
  State<NouveauDossierPatientPage> createState() =>
      _NouveauDossierPatientPageState();
}

class _NouveauDossierPatientPageState extends State<NouveauDossierPatientPage> {
  int currentStep = 1;
  String? selectedSexe;

  // ✅ Controllers pour tous les champs
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  final TextEditingController contactNomController = TextEditingController();
  final TextEditingController contactRelationController = TextEditingController();
  final TextEditingController contactTelephoneController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();

  final TextEditingController antecedentsController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController traitementsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestore = FirestoreService();

  void nextStep() {
    if (currentStep < 3) setState(() => currentStep++);
  }

  void previousStep() {
    if (currentStep > 1) setState(() => currentStep--);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("fr", "FR"),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(foregroundColor: Colors.blue),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      final formattedDate =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
      setState(() => dateNaissanceController.text = formattedDate);
    }
  }

  void finish() async {
    if (!_formKey.currentState!.validate()) return;

    String idVitalia = generateVitaliaID();
    String phone = telephoneController.text.trim();
    if (!phone.startsWith("+229")) phone = "+229$phone";

    // Calcul de l’âge simple
    int age = 0;
    if (dateNaissanceController.text.isNotEmpty) {
      final parts = dateNaissanceController.text.split('/');
      if (parts.length == 3) {
        int birthYear = int.tryParse(parts[2]) ?? DateTime.now().year;
        age = DateTime.now().year - birthYear;
      }
    }

    PatientModel patient = PatientModel(
      id: idVitalia,
      idVitalia: idVitalia,
      nom: nomController.text.trim(),
      prenom: prenomController.text.trim(),
      telephone: phone,
      email: emailController.text.trim().isNotEmpty ? emailController.text.trim() : null,
      adresse: adresseController.text.trim().isNotEmpty ? adresseController.text.trim() : null,
      dateNaissance: dateNaissanceController.text,
      sexe: selectedSexe ?? "",
      age: age,
      contactNom: contactNomController.text.trim().isNotEmpty ? contactNomController.text.trim() : null,
      contactRelation: contactRelationController.text.trim().isNotEmpty ? contactRelationController.text.trim() : null,
      contactTelephone: contactTelephoneController.text.trim().isNotEmpty ? contactTelephoneController.text.trim() : null,
      contactEmail: contactEmailController.text.trim().isNotEmpty ? contactEmailController.text.trim() : null,
      antecedentsMedicaux: antecedentsController.text.trim().isNotEmpty ? antecedentsController.text.trim() : null,
      allergies: allergiesController.text.trim().isNotEmpty ? allergiesController.text.trim() : null,
      traitementsEnCours: traitementsController.text.trim().isNotEmpty ? traitementsController.text.trim() : null,
    );

    // 🔹 Utilisation du Provider pour ajouter le patient
    try {
      final patientProvider = Provider.of<PatientProvider>(context, listen: false);
      await patientProvider.addPatient(patient);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Patient ajouté : ID $idVitalia")),
      );

      Navigator.pop(context); // Retour à la page précédente
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors de l'ajout du patient : $e")),
      );
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nom & Prénom
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: nomController,
                      decoration: const InputDecoration(
                        labelText: "Nom",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? "Nom requis" : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: prenomController,
                      decoration: const InputDecoration(
                        labelText: "Prénom",
                        border: OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty ? "Prénom requis" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Date de naissance
              TextFormField(
                controller: dateNaissanceController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date de naissance",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (v) => v == null || v.isEmpty ? "Date requise" : null,
              ),
              const SizedBox(height: 16),
              // Sexe
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sexe", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Masculin",
                        groupValue: selectedSexe,
                        onChanged: (v) => setState(() => selectedSexe = v),
                      ),
                      const Text("Masculin"),
                      Radio<String>(
                        value: "Féminin",
                        groupValue: selectedSexe,
                        onChanged: (v) => setState(() => selectedSexe = v),
                      ),
                      const Text("Féminin"),
                    ],
                  ),
                  if (selectedSexe == null) const Text("Sexe requis", style: TextStyle(color: Colors.red)),
                ],
              ),
              const SizedBox(height: 16),
              // Téléphone, Email, Adresse
              TextFormField(
                controller: telephoneController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (v) => v == null || v.isEmpty ? "Téléphone requis" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: adresseController,
                decoration: const InputDecoration(
                  labelText: "Adresse complète",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Contact d'urgence", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextFormField(
                controller: contactNomController,
                decoration: const InputDecoration(
                  labelText: "Nom complet",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contactRelationController,
                decoration: const InputDecoration(
                  labelText: "Relation (Époux, Parent, Ami...)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contactTelephoneController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: contactEmailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
        );
      case 3:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Informations médicales", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              TextFormField(
                controller: antecedentsController,
                decoration: const InputDecoration(
                  labelText: "Antécédents médicaux",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: allergiesController,
                decoration: const InputDecoration(
                  labelText: "Allergies connues",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: traitementsController,
                decoration: const InputDecoration(
                  labelText: "Traitements en cours",
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildStepIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        int step = index + 1;
        bool isActive = step == currentStep;
        bool isCompleted = step < currentStep;
        return Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: isActive || isCompleted ? Colors.blue : Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text("$step", style: const TextStyle(color: Colors.white)),
              ),
            ),
            if (step != 3)
              Container(width: 40, height: 2, color: isCompleted ? Colors.blue : Colors.grey),
          ],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nouveau dossier patient")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildStepIndicator(),
              const SizedBox(height: 20),
              Expanded(child: _buildStepContent()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentStep > 1)
                    ElevatedButton(
                      onPressed: previousStep,
                      child: const Text("Précédent"),
                    ),
                  ElevatedButton(
                    onPressed: currentStep == 3 ? finish : nextStep,
                    child: Text(currentStep == 3 ? "Créer le dossier" : "Suivant"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
