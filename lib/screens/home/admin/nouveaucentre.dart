/*import 'package:flutter/material.dart';
import '../../../modeles/centre_model.dart';
import '../../../services/firebase_auth_service.dart';

class AjouterCentrePage extends StatefulWidget {
  const AjouterCentrePage({super.key});

  @override
  State<AjouterCentrePage> createState() => _AjouterCentrePageState();
}

class _AjouterCentrePageState extends State<AjouterCentrePage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomController = TextEditingController();
  final typeController = TextEditingController();
  final directeurController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  final medecinsController = TextEditingController();
  final patientsController = TextEditingController();
  final consultationsController = TextEditingController();

  bool showPassword = false;
  bool _loading = false;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un centre")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email de connexion",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value!.isEmpty ? "Entrez un email valide" : null,
              ),
              const SizedBox(height: 12),

              // Mot de passe
              TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                ),
                validator: (value) =>
                value!.length < 6 ? "Min. 6 caractères" : null,
              ),
              const SizedBox(height: 12),

              // Nom du centre
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: "Nom du centre",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Entrez le nom du centre" : null,
              ),
              const SizedBox(height: 12),

              // Type
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: "Type (Clinique, Hôpital, etc.)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Directeur
              TextFormField(
                controller: directeurController,
                decoration: const InputDecoration(
                  labelText: "Directeur",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Téléphone
              TextFormField(
                controller: telephoneController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              // Adresse
              TextFormField(
                controller: adresseController,
                decoration: const InputDecoration(
                  labelText: "Adresse",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Nombre de médecins
              TextFormField(
                controller: medecinsController,
                decoration: const InputDecoration(
                  labelText: "Nombre de médecins",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Entrez le nombre de médecins" : null,
              ),
              const SizedBox(height: 12),

              // Nombre de patients
              TextFormField(
                controller: patientsController,
                decoration: const InputDecoration(
                  labelText: "Nombre de patients",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Entrez le nombre de patients" : null,
              ),
              const SizedBox(height: 12),

              // Nombre de consultations
              TextFormField(
                controller: consultationsController,
                decoration: const InputDecoration(
                  labelText: "Nombre de consultations",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Entrez le nombre de consultations" : null,
              ),
              const SizedBox(height: 20),

              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _loading = true);

                    try {
                      await _firebaseService.registerCentre(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        nom: nomController.text.trim(),
                        adresse: adresseController.text.trim(),
                        telephone: telephoneController.text.trim(),
                        type: typeController.text.trim(),
                        directeur: directeurController.text.trim(),
                        medecins: int.parse(medecinsController.text.trim()),
                        patients: int.parse(patientsController.text.trim()),
                        consultations: int.parse(consultationsController.text.trim()),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Centre ajouté avec succès"),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur: $e")),
                      );
                    } finally {
                      setState(() => _loading = false);
                    }
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text("Enregistrer"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import '../../../services/firebase_auth_service.dart';

class AjouterCentrePage extends StatefulWidget {
  const AjouterCentrePage({super.key});

  @override
  State<AjouterCentrePage> createState() => _AjouterCentrePageState();
}

class _AjouterCentrePageState extends State<AjouterCentrePage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nomController = TextEditingController();
  final typeController = TextEditingController();
  final directeurController = TextEditingController();
  final telephoneController = TextEditingController();
  final adresseController = TextEditingController();
  final medecinsController = TextEditingController();
  final patientsController = TextEditingController();
  final consultationsController = TextEditingController();

  bool showPassword = false;
  bool _loading = false;
  String statut = "Actif";
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajouter un centre")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: "Email de connexion",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                value!.isEmpty ? "Entrez un email valide" : null,
              ),
              const SizedBox(height: 12),

              // Mot de passe
              TextFormField(
                controller: passwordController,
                obscureText: !showPassword,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      showPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () => setState(() => showPassword = !showPassword),
                  ),
                ),
                validator: (value) =>
                value!.length < 6 ? "Min. 6 caractères" : null,
              ),
              const SizedBox(height: 12),

              // Nom du centre
              TextFormField(
                controller: nomController,
                decoration: const InputDecoration(
                  labelText: "Nom du centre",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value!.isEmpty ? "Entrez le nom du centre" : null,
              ),
              const SizedBox(height: 12),

              // Type
              TextFormField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: "Type (Clinique, Hôpital, etc.)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Directeur
              TextFormField(
                controller: directeurController,
                decoration: const InputDecoration(
                  labelText: "Directeur",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),

              // Téléphone
              TextFormField(
                controller: telephoneController,
                decoration: const InputDecoration(
                  labelText: "Téléphone",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              // Adresse
              TextFormField(
                controller: adresseController,
                decoration: const InputDecoration(
                  labelText: "Adresse",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              // Statut
              DropdownButtonFormField<String>(
                value: statut,
                decoration: const InputDecoration(
                  labelText: "Statut du centre",
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: "Actif", child: Text("Actif")),
                  DropdownMenuItem(value: "Maintenance", child: Text("Maintenance")),
                ],
                onChanged: (value) {
                  setState(() {
                    statut = value!;
                  });
                },
              ),
              const SizedBox(height: 12),

              // Nombre de médecins
              TextFormField(
                controller: medecinsController,
                decoration: const InputDecoration(
                  labelText: "Nombre de médecins",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Entrez le nombre de médecins" : null,
              ),
              const SizedBox(height: 12),

              // Nombre de patients
              TextFormField(
                controller: patientsController,
                decoration: const InputDecoration(
                  labelText: "Nombre de patients",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Entrez le nombre de patients" : null,
              ),
              const SizedBox(height: 12),

              // Nombre de consultations
              TextFormField(
                controller: consultationsController,
                decoration: const InputDecoration(
                  labelText: "Nombre de consultations",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) =>
                value!.isEmpty ? "Entrez le nombre de consultations" : null,
              ),
              const SizedBox(height: 20),

              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => _loading = true);

                    try {
                      await _firebaseService.registerCentre(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        nom: nomController.text.trim(),
                        adresse: adresseController.text.trim(),
                        telephone: telephoneController.text.trim(),
                        type: typeController.text.trim(),
                        directeur: directeurController.text.trim(),
                        medecins:
                        int.parse(medecinsController.text.trim()),
                        patients:
                        int.parse(patientsController.text.trim()),
                        consultations: int.parse(
                            consultationsController.text.trim()),
                        statut: statut,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Centre ajouté avec succès"),
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Erreur: $e")),
                      );
                    } finally {
                      setState(() => _loading = false);
                    }
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text("Enregistrer"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

