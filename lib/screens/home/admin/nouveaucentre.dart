
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/firebase_auth_service.dart';

class AjouterCentrePage extends StatefulWidget {
  final Map<String, dynamic>? centreData;
  final String? centreId;

  const AjouterCentrePage({super.key, this.centreData, this.centreId});

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

  // décoration réutilisable
  InputDecoration _fieldDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.centreData != null) {
      final data = widget.centreData!;
      emailController.text = data['email'] ?? '';
      nomController.text = data['nom'] ?? '';
      typeController.text = data['type'] ?? '';
      directeurController.text = data['directeur'] ?? '';
      telephoneController.text = data['telephone'] ?? '';
      adresseController.text = data['adresse'] ?? '';
      medecinsController.text = (data['medecins'] ?? 0).toString();
      patientsController.text = (data['patients'] ?? 0).toString();
      consultationsController.text = (data['consultations'] ?? 0).toString();
      statut = data['statut'] ?? 'Actif';
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nomController.dispose();
    typeController.dispose();
    directeurController.dispose();
    telephoneController.dispose();
    adresseController.dispose();
    medecinsController.dispose();
    patientsController.dispose();
    consultationsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isEditing = widget.centreData != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? "Modifier le centre" : "Ajouter un centre")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Email
              TextFormField(
                cursorColor: Colors.blue,
                controller: emailController,
                decoration: _fieldDecoration("Email de connexion"),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => (value == null || value.isEmpty) ? "Entrez un email valide" : null,
              ),
              const SizedBox(height: 12),

              // Mot de passe (visible uniquement quand on ajoute)
              if (!isEditing) ...[
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: passwordController,
                  obscureText: !showPassword,
                  decoration: _fieldDecoration("Mot de passe").copyWith(
                    suffixIcon: IconButton(
                      icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () => setState(() => showPassword = !showPassword),
                    ),
                  ),
                  validator: (value) => (value == null || value.length < 6) ? "Min. 6 caractères" : null,
                ),
                const SizedBox(height: 12),
              ],

              // Nom du centre
              TextFormField(
                cursorColor: Colors.blue,
                controller: nomController,
                decoration: _fieldDecoration("Nom du centre"),
                validator: (value) => (value == null || value.isEmpty) ? "Entrez le nom du centre" : null,
              ),
              const SizedBox(height: 12),

              // Type
              TextFormField(
                cursorColor: Colors.blue,
                controller: typeController,
                decoration: _fieldDecoration("Type (Clinique, Hôpital, etc.)"),
              ),
              const SizedBox(height: 12),

              // Directeur
              TextFormField(
                cursorColor: Colors.blue,
                controller: directeurController,
                decoration: _fieldDecoration("Directeur"),
              ),
              const SizedBox(height: 12),

              // Téléphone
              TextFormField(
                cursorColor: Colors.blue,
                controller: telephoneController,
                decoration: _fieldDecoration("Téléphone"),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 12),

              // Adresse
              TextFormField(
                cursorColor: Colors.blue,
                controller: adresseController,
                decoration: _fieldDecoration("Adresse"),
              ),
              const SizedBox(height: 12),

              // Statut
              DropdownButtonFormField<String>(
                value: statut,
                decoration: _fieldDecoration("Statut du centre"),
                items: const [
                  DropdownMenuItem(value: "Actif", child: Text("Actif")),
                  DropdownMenuItem(value: "Maintenance", child: Text("Maintenance")),
                ],
                onChanged: (value) => setState(() => statut = value ?? "Actif"),
              ),
              const SizedBox(height: 12),

              // Nombre de médecins
              TextFormField(
                cursorColor: Colors.blue,
                controller: medecinsController,
                decoration: _fieldDecoration("Nombre de médecins"),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.isEmpty) ? "Entrez le nombre de médecins" : null,
              ),
              const SizedBox(height: 12),

              // Nombre de patients
              TextFormField(
                cursorColor: Colors.blue,
                controller: patientsController,
                decoration: _fieldDecoration("Nombre de patients"),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.isEmpty) ? "Entrez le nombre de patients" : null,
              ),
              const SizedBox(height: 12),

              // Nombre de consultations
              TextFormField(
                cursorColor: Colors.blue,
                controller: consultationsController,
                decoration: _fieldDecoration("Nombre de consultations"),
                keyboardType: TextInputType.number,
                validator: (value) => (value == null || value.isEmpty) ? "Entrez le nombre de consultations" : null,
              ),
              const SizedBox(height: 20),

              _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                icon: Icon(isEditing ? Icons.save : Icons.check),
                label: Text(isEditing ? "Mettre à jour" : "Enregistrer"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEditing ? Colors.green : Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  setState(() => _loading = true);

                  // Préparer map de données (valeurs nettoyées)
                  final Map<String, dynamic> centreMap = {
                    "email": emailController.text.trim(),
                    "nom": nomController.text.trim(),
                    "type": typeController.text.trim(),
                    "directeur": directeurController.text.trim(),
                    "telephone": telephoneController.text.trim(),
                    "adresse": adresseController.text.trim(),
                    "medecins": int.tryParse(medecinsController.text.trim()) ?? 0,
                    "patients": int.tryParse(patientsController.text.trim()) ?? 0,
                    "consultations": int.tryParse(consultationsController.text.trim()) ?? 0,
                    "statut": statut,
                  };

                  try {
                    if (isEditing) {
                      // Si un centreId est fourni, on met à jour directement Firestore depuis cette page
                      if (widget.centreId != null && widget.centreId!.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .collection("centres")
                            .doc(widget.centreId)
                            .update(centreMap);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Centre mis à jour avec succès")),
                        );
                        Navigator.pop(context, centreMap); // on peut aussi renvoyer la map
                      } else {
                        // Si pas de centreId fourni, on renvoie la map au parent pour qu'il mette à jour
                        Navigator.pop(context, centreMap);
                      }
                    } else {
                      // Création : on utilise ton service d'inscription (registerCentre)
                      await _firebase_service_registerOrCreate(centreMap, passwordController.text.trim());
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Centre ajouté avec succès")),
                      );
                      Navigator.pop(context, centreMap);
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Erreur: $e")),
                    );
                  } finally {
                    setState(() => _loading = false);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode wrapper pour appeler le service d'enregistrement
  Future<void> _firebase_service_registerOrCreate(Map<String, dynamic> centreMap, String password) async {
    await _firebaseService.registerCentre(
      email: centreMap['email'] ?? '',
      password: password,
      nom: centreMap['nom'] ?? '',
      adresse: centreMap['adresse'] ?? '',
      telephone: centreMap['telephone'] ?? '',
      type: centreMap['type'] ?? '',
      directeur: centreMap['directeur'] ?? '',
      medecins: centreMap['medecins'] ?? 0,
      patients: centreMap['patients'] ?? 0,
      consultations: centreMap['consultations'] ?? 0,
      statut: centreMap['statut'] ?? 'Actif',
    );
  }
}
