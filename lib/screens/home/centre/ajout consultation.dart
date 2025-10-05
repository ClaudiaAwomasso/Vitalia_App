import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/modeles/consultation_model.dart';
import 'package:vitalia_app/services/firestore_service.dart';
import '../../../providers/consultations_provider.dart';

class AjoutConsultation extends StatefulWidget {
  const AjoutConsultation({super.key});

  @override
  State<AjoutConsultation> createState() => _AjoutConsultationState();
}

class _AjoutConsultationState extends State<AjoutConsultation> {
  PatientModel? selectedPatient;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController diagnosticController = TextEditingController();
  final TextEditingController traitementController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController ordonnanceController = TextEditingController();
  final TextEditingController antecedentsController = TextEditingController();
  final TextEditingController autreMotifController = TextEditingController();

  String? selectedMotif;
  final FirestoreService firestore = FirestoreService();

  final List<String> motifs = [
    "Consultation générale",
    "Suivi médical",
    "Urgence médicale",
    "Douleurs / symptômes",
    "Consultation pédiatrique",
    "Consultation gynécologique",
    "Consultation prénatale",
    "Vaccination",
    "Examen de routine",
    "Résultats d’examens",
    "Consultation spécialisée",
    "Renouvellement d’ordonnance",
    "Autre"
  ];

  @override
  Widget build(BuildContext context) {
    final consultationProvider = Provider.of<ConsultationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Ajouter Consultation", style: TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey, // 🔑 Validation ici
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- Sélection du patient ----------
              const Text("Sélection du patient", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              StreamBuilder<List<PatientModel>>(
                stream: firestore.patientsStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const CircularProgressIndicator(color: Colors.blue,);
                  final patients = snapshot.data!;
                  return DropdownButtonFormField<String>(
                    value: selectedPatient?.idVitalia,
                    items: patients.map((p) {
                      return DropdownMenuItem(
                        value: p.idVitalia,
                        child: Text("${p.nom} (${p.idVitalia})"),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedPatient = patients.firstWhere((p) => p.idVitalia == value);
                      });
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    ),
                    validator: (value) =>
                    value == null ? "Veuillez sélectionner un patient" : null,
                  );
                },
              ),

              const SizedBox(height: 20),
              const Text('Détails de consultation',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue)),
              const SizedBox(height: 10),

              // ---------- Motif ----------
              DropdownButtonFormField<String>(
                value: selectedMotif,
                items: motifs.map((motif) {
                  return DropdownMenuItem(
                    value: motif,
                    child: Text(motif),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMotif = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Motif de consultation",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                validator: (value) => value == null ? "Veuillez choisir un motif" : null,
              ),

              if (selectedMotif == "Autre") ...[
                const SizedBox(height: 10),
                TextFormField(
                  cursorColor: Colors.black,
                  controller: autreMotifController,
                  decoration: const InputDecoration(
                    labelText: "Préciser le motif",
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (selectedMotif == "Autre" && (value == null || value.isEmpty)) {
                      return "Veuillez préciser le motif";
                    }
                    return null;
                  },
                ),
              ],

              const SizedBox(height: 10),
              // ---------- Diagnostic ----------
              TextFormField(
                cursorColor: Colors.black,
                controller: diagnosticController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Diagnostic",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Veuillez entrer un diagnostic" : null,
              ),
              const SizedBox(height: 10),

              // ---------- Traitement ----------
              TextFormField(
                cursorColor: Colors.black,
                controller: traitementController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: "Traitement",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Veuillez entrer un traitement" : null,
              ),
              const SizedBox(height: 10),

              // ---------- Notes ----------
              TextFormField(
                cursorColor: Colors.black,
                controller: notesController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Notes complémentaires",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // ---------- Ordonnance ----------
              TextFormField(
                cursorColor: Colors.black,
                controller: ordonnanceController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Ordonnance / Prescription",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Veuillez entrer une ordonnance" : null,
              ),
              const SizedBox(height: 10),

              // ---------- Antécédents ----------
              TextFormField(
                cursorColor: Colors.black,
                controller: antecedentsController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Antécédents médicaux",
                  labelStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                  ),
                ),
              ),

              const SizedBox(height: 20),
              // ---------- Boutons ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final motifFinal =
                        (selectedMotif == "Autre") ? autreMotifController.text : selectedMotif!;

                        final newConsultation = Consultation(
                          id: "",
                          patientId: selectedPatient!.idVitalia,
                          medecinId: 'id_medecin_connecté', // à remplacer
                          date: DateTime.now(),
                          motif: motifFinal,
                          statut: "En attente",
                          diagnostic: diagnosticController.text,
                          notes: notesController.text,
                          ordonnances: [ordonnanceController.text],
                          traitements: [traitementController.text],
                          antecedents: [antecedentsController.text],
                        );

                        await consultationProvider.addConsultation(newConsultation);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Consultation enregistrée !")),
                        );
                        Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Veuillez renseigner tous les champs obligatoires")),
                        );
                      }
                    },
                    child: const Text("Enregistrer"),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Annuler",style: TextStyle(color: Colors.black),),
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
