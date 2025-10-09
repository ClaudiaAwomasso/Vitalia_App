import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vitalia_app/modeles/medecin_model.dart';

class AjoutMedecin extends StatefulWidget {
  const AjoutMedecin({super.key});

  @override
  State<AjoutMedecin> createState() => _AjoutMedecinState();
}

class _AjoutMedecinState extends State<AjoutMedecin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _specialiteController = TextEditingController();
  final TextEditingController _centreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  bool _loading = false;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final medecin = MedecinModel(
      id: '', // Firestore génère automatiquement l'ID
      nom: _nomController.text.trim(),
      prenom: _prenomController.text.trim(),
      specialite: _specialiteController.text.trim(),
      centre: _centreController.text.trim(),
      email: _emailController.text.trim(),
      telephone: _telephoneController.text.trim(),
      dateInscription: DateTime.now().toIso8601String(),
    );

    try {
      final docRef = await FirebaseFirestore.instance.collection('medecins').add(medecin.toMap());
      // Mettre l'ID généré par Firestore
      await docRef.update({'id': docRef.id});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Médecin ${medecin.nom} ajouté avec succès !')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur: $e')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un Médecin')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                    cursorColor: Colors.blue,
                  controller: _nomController,
                  decoration: const InputDecoration(labelText: 'Nom',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                    ),

                  ),
                  validator: (v) => v!.isEmpty ? 'Requis' : null,

                ),
                SizedBox(height: 15,),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _prenomController,
                  decoration: const InputDecoration(labelText: 'Prénom',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                    ),
                  ),
                  validator: (v) => v!.isEmpty ? 'Requis' : null,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _specialiteController,
                  decoration: const InputDecoration(labelText: 'Spécialité',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                    ),
                  ),
                  validator: (v) => v!.isEmpty ? 'Requis' : null,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _centreController,
                  decoration: const InputDecoration(labelText: 'Centre',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                    ),),
                  validator: (v) => v!.isEmpty ? 'Requis' : null,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                    ),

                  ),
                  validator: (v) => v!.isEmpty ? 'Requis' : null,
                ),
                SizedBox(height: 15,),
                TextFormField(
                  cursorColor: Colors.blue,
                  controller: _telephoneController,
                  decoration: const InputDecoration(labelText: 'Téléphone',
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                    ),
                  ),
                  validator: (v) => v!.isEmpty ? 'Requis' : null,
                ),
                const SizedBox(height: 20),
                _loading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Ajouter le Médecin',style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
