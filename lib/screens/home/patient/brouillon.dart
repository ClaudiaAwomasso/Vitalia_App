import 'package:flutter/material.dart';

import '../admin/dashboard_page.dart' show AdminDashboardPage;

class NouveauDossierPatientPage extends StatefulWidget {
  const NouveauDossierPatientPage({super.key});

  @override
  State<NouveauDossierPatientPage> createState() =>
      _NouveauDossierPatientPageState();
}

class _NouveauDossierPatientPageState extends State<NouveauDossierPatientPage> {
  int currentStep = 1;
  String? selectedSexe;

  // 🔹 Controllers étape 1
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController dateNaissanceController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adresseController = TextEditingController();

  // 🔹 Controllers étape 2
  final TextEditingController contactNomController = TextEditingController();
  final TextEditingController contactRelationController = TextEditingController();
  final TextEditingController contactTelephoneController = TextEditingController();
  final TextEditingController contactEmailController = TextEditingController();

  // 🔹 Controllers étape 3
  final TextEditingController antecedentController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController traitementsController = TextEditingController();

  void nextStep() {
    if (_validateCurrentStep()) {
      if (currentStep < 3) {
        setState(() {
          currentStep++;
        });
      }
    }
  }

  void previousStep() {
    if (currentStep > 1) {
      setState(() {
        currentStep--;
      });
    }
  }

  bool _validateCurrentStep() {
    switch (currentStep) {
      case 1:
        if (nomController.text.isEmpty ||
            prenomController.text.isEmpty ||
            dateNaissanceController.text.isEmpty ||
            selectedSexe == null ||
            telephoneController.text.isEmpty ||
            emailController.text.isEmpty ||
            adresseController.text.isEmpty) {
          _showError("Veuillez remplir tous les champs de l'étape 1.");
          return false;
        }
        break;
      case 2:
        if (contactNomController.text.isEmpty ||
            contactRelationController.text.isEmpty ||
            contactTelephoneController.text.isEmpty ||
            contactEmailController.text.isEmpty) {
          _showError("Veuillez remplir tous les champs de l'étape 2.");
          return false;
        }
        break;
      case 3:
        if (antecedentController.text.isEmpty ||
            allergiesController.text.isEmpty ||
            traitementsController.text.isEmpty) {
          _showError("Veuillez remplir tous les champs de l'étape 3.");
          return false;
        }
        break;
    }
    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void finish() {
    if (_validateCurrentStep()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dossier terminé ✅")),
      );
      // 🔹 Ici tu peux envoyer les données vers un backend ou base de données
      // 🔹 Redirection vers la page d'accueil après un petit délai pour voir le SnackBar
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminDashboardPage()), // <-- remplace HomePage par ta page d'accueil
        );
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale("fr", "FR"),
      builder: (BuildContext context, Widget? child) {
        return Theme(
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
        );
      },
    );
    if (picked != null) {
      final formattedDate =
          "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
      setState(() {
        dateNaissanceController.text = formattedDate;
      });
    }
  }

  Widget _buildStepContent() {
    switch (currentStep) {
      case 1:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Nom', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextField(
                          controller: nomController,
                          decoration: const InputDecoration(
                            labelText: "Nom",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Prénom', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        TextField(
                          controller: prenomController,
                          decoration: const InputDecoration(
                            labelText: "Prénom",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Date de naissance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: dateNaissanceController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date de naissance",
                  hintText: "jj/mm/aaaa",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text("Sexe", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Radio<String>(
                    value: "Masculin",
                    groupValue: selectedSexe,
                    onChanged: (value) => setState(() => selectedSexe = value),
                  ),
                  const Text("Masculin"),
                  Radio<String>(
                    value: "Féminin",
                    groupValue: selectedSexe,
                    onChanged: (value) => setState(() => selectedSexe = value),
                  ),
                  const Text("Féminin"),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Téléphone', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: telephoneController,
                decoration: const InputDecoration(
                  labelText: "+229 0154632145",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              const Text('Email', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "email@exemple.com",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              const Text('Adresse', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(
                controller: adresseController,
                maxLines: 4,
                minLines: 3,
                decoration: const InputDecoration(
                  labelText: "Adresse complète",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        );
      case 2:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Contact d'urgence", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              const Text("Nom du contact", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: contactNomController, decoration: const InputDecoration(labelText: "Nom Complet", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const Text("Relation", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: contactRelationController, decoration: const InputDecoration(labelText: "Époux, Parent, Ami...", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const Text("Téléphone", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: contactTelephoneController, decoration: const InputDecoration(labelText: "+229 90 00 00 00", border: OutlineInputBorder()), keyboardType: TextInputType.phone),
              const SizedBox(height: 12),
              const Text("Email", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: contactEmailController, decoration: const InputDecoration(labelText: "contact@exemplegmail.com", border: OutlineInputBorder()), keyboardType: TextInputType.emailAddress),
            ],
          ),
        );
      case 3:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Informations médicales", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              const Text("Antécédents médicaux", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: antecedentController, maxLines: 4, minLines: 3, decoration: const InputDecoration(labelText: "maladie passées , opérations...", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const Text("Allergies connues", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: allergiesController, maxLines: 4, minLines: 3, decoration: const InputDecoration(labelText: "Médicaments, aliments et autre", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              const Text("Traitements en cours", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              TextField(controller: traitementsController, maxLines: 4, minLines: 3, decoration: const InputDecoration(labelText: "Médicaments actuel...", border: OutlineInputBorder())),
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
                child: Text("$step", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            if (step != 3)
              Container(
                width: 40,
                height: 2,
                color: isCompleted ? Colors.blue : Colors.grey,
              ),
          ],
        );
      }),
    );
  }

  @override
  void dispose() {
    nomController.dispose();
    prenomController.dispose();
    dateNaissanceController.dispose();
    telephoneController.dispose();
    emailController.dispose();
    adresseController.dispose();
    contactNomController.dispose();
    contactRelationController.dispose();
    contactTelephoneController.dispose();
    contactEmailController.dispose();
    antecedentController.dispose();
    allergiesController.dispose();
    traitementsController.dispose();
    super.dispose();
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
            const SizedBox(height: 25),
            Expanded(child: _buildStepContent()),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 1)
                  ElevatedButton.icon(
                    onPressed: previousStep,
                    icon: const Icon(Icons.arrow_back_sharp, size: 20),
                    label: const Text("Précédent", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade200,
                      foregroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ElevatedButton.icon(
                  onPressed: currentStep == 3 ? finish : nextStep,
                  icon: Icon(currentStep == 3 ? Icons.check : Icons.arrow_forward_outlined, size: 20),
                  label: Text(currentStep == 3 ? "Créer le dossier" : "Suivant", style: const TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
