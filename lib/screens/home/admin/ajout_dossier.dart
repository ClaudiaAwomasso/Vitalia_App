
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/services/firestore_service.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/utils/id_generator.dart';
import '../../../providers/patient_provider.dart';

class NouveauDossierPatientPage extends StatefulWidget {
  const NouveauDossierPatientPage({super.key});

  @override
  State<NouveauDossierPatientPage> createState() => _NouveauDossierPatientPageState();
}

class _NouveauDossierPatientPageState extends State<NouveauDossierPatientPage> {
  int currentStep = 1;
  String? selectedSexe;

  // Controllers étape 1
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  // Controllers étape 2 (contact d'urgence)
  final TextEditingController contactNomController = TextEditingController();
  final TextEditingController contactRelationController = TextEditingController();
  final TextEditingController contactTelephoneController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestore = FirestoreService();

  void nextStep() {
    if (validateCurrentStep()) {
      if (currentStep < 2) {
        setState(() => currentStep++);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez renseigner toutes les informations")),
      );
    }
  }

  void previousStep() {
    if (currentStep > 1) setState(() => currentStep--);
  }

  bool validateCurrentStep() {
    if (currentStep == 1) {
      return nomController.text.trim().isNotEmpty &&
          prenomController.text.trim().isNotEmpty &&
          dateNaissanceController.text.trim().isNotEmpty &&
          selectedSexe != null &&
          telephoneController.text.trim().isNotEmpty;
    } else {
      return contactNomController.text.trim().isNotEmpty &&
          contactRelationController.text.trim().isNotEmpty &&
          contactTelephoneController.text.trim().isNotEmpty;
    }
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
    if (!validateCurrentStep()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez renseigner toutes les informations")),
      );
      return;
    }

    if (selectedSexe == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner le sexe du patient")),
      );
      return;
    }

    String idVitalia = generateVitaliaID();
    String phone = telephoneController.text.trim();
    if (!phone.startsWith("+229")) phone = "+229$phone";

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
      sexe: selectedSexe!,
      age: age,
      contactNom: contactNomController.text.trim(),
      contactRelation: contactRelationController.text.trim(),
      contactTelephone: contactTelephoneController.text.trim(),
      contactEmail: contactEmailController.text.trim().isNotEmpty ? contactEmailController.text.trim() : null,
      dateInscription: "${DateTime.now().day.toString().padLeft(2,'0')}/"
          "${DateTime.now().month.toString().padLeft(2,'0')}/"
          "${DateTime.now().year}",
      consultations: 0,
    );

    try {
      final patientProvider = Provider.of<PatientProvider>(context, listen: false);
      await patientProvider.addPatient(patient);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Patient ajouté : ID $idVitalia")),
      );

      Navigator.pop(context);
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
                      cursorColor: Colors.blue,
                      controller: nomController,
                      decoration: const InputDecoration(labelText: "Nom", border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      cursorColor: Colors.blue,
                      controller: prenomController,
                      decoration: const InputDecoration(labelText: "Prénom",
                        labelStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
    ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: dateNaissanceController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date de naissance",
                  labelStyle: TextStyle(color: Colors.black),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Sexe", style: TextStyle(fontSize: 16)),
                  Row(
                    children: [
                      Radio<String>(
                        value: "Masculin",
                        groupValue: selectedSexe,
                        activeColor: Colors.blue,
                        onChanged: (v) => setState(() => selectedSexe = v),
                      ),
                      const Text("Masculin"),
                      Radio<String>(
                        value: "Féminin",
                        activeColor: Colors.blue,
                        groupValue: selectedSexe,
                        onChanged: (v) => setState(() => selectedSexe = v),
                      ),
                      const Text("Féminin"),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                cursorColor: Colors.blue,
                controller: telephoneController,
                decoration: const InputDecoration(labelText: "Téléphone",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.blue,
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.blue,
                controller: adresseController,
                decoration: const InputDecoration(labelText: "Adresse complète",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
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
                cursorColor: Colors.blue,
                controller: contactNomController,
                decoration: const InputDecoration(labelText: "Nom complet",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.blue,
                controller: contactRelationController,
                decoration: const InputDecoration(
                    labelText: "Relation (Époux, Parent, Ami...)",
                    labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.black,
                controller: contactTelephoneController,
                decoration: const InputDecoration(labelText: "Téléphone",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextFormField(
                cursorColor: Colors.blue,
                controller: contactEmailController,
                decoration: const InputDecoration(labelText: "Email",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
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
      children: List.generate(2, (index) {
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
              child: Center(child: Text("$step", style: const TextStyle(color: Colors.white))),
            ),
            if (step != 2)
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
        child: Column(
          children: [
            _buildStepIndicator(),
            const SizedBox(height: 20),
            Expanded(child: _buildStepContent()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Bouton Précédent (affiché seulement après la première étape)
                if (currentStep > 1)
                  ElevatedButton.icon(
                    onPressed: previousStep,
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    label: const Text(
                      "Précédent",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[600], // couleur du bouton précédent
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 3,
                    ),
                  ),

                // ➡️ Bouton Suivant ou Créer le dossier
                ElevatedButton.icon(
                  onPressed: currentStep == 2 ? finish : nextStep,
                  icon: Icon(
                    currentStep == 2 ? Icons.check : Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  label: Text(
                    currentStep == 2 ? "Créer le dossier" : "Suivant",
                    style: const TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    currentStep == 2 ? Colors.green : Colors.blue, // ✅ vert ou bleu
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}

