import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/providers/patient_provider.dart';

class ProfilPatient extends StatelessWidget {
  const ProfilPatient({Key? key}) : super(key: key);

  Widget _infoRow(String label, String value, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20, color: Colors.blueGrey),
            const SizedBox(width: 10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(value, style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);
    final PatientModel? patient = provider.patient; // 🔹 patient connecté

    if (patient == null) {
      return const Scaffold(
        body: Center(child: Text("Aucun patient connecté")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon profil"),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: navigation vers page édition
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Page d'édition à implémenter")),
              );
            },
            child: const Text("Modifier", style: TextStyle(color: Colors.blue)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Header profil
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: (patient.photoUrl != null && patient.photoUrl!.isNotEmpty)
                          ? NetworkImage(patient.photoUrl!)
                          : null, // pas de background si pas de photo
                      child: (patient.photoUrl == null || patient.photoUrl!.isEmpty)
                          ? const Icon(Icons.person, size: 40, color: Colors.white)
                          : null,
                      backgroundColor: Colors.blueGrey.shade200, // fond gris par défaut
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${patient.nom} ${patient.prenom}",
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 6),
                          Text(patient.idVitalia, style: const TextStyle(color: Colors.black54)),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Chip(label: Text("${patient.age} ans")),
                              const SizedBox(width: 6),
                              Chip(label: Text(patient.sexe)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Infos personnelles
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Informations personnelles",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _infoRow("Téléphone", patient.telephone, icon: Icons.phone),
                    _infoRow("Email", patient.email ?? "Non renseigné", icon: Icons.email),
                    _infoRow("Adresse", patient.adresse ?? "Non renseignée", icon: Icons.location_on),
                    _infoRow("Date de naissance",
                        patient.dateNaissance.isNotEmpty ? patient.dateNaissance : "Non renseignée",
                        icon: Icons.cake),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
