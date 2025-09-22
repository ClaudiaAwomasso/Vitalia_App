import 'package:flutter/material.dart';

class RecherchePatientPage extends StatefulWidget {
  const RecherchePatientPage({super.key});

  @override
  State<RecherchePatientPage> createState() => _RecherchePatientPageState();
}

class _RecherchePatientPageState extends State<RecherchePatientPage> {
  String filtreActif = "Tous";

  // 🔹 Données fictives (à remplacer plus tard par Firestore)
  final List<Map<String, dynamic>> patients = [
    {
      "nom": "Marie Dubois",
      "naissance": "15/03/1985",
      "telephone": "1 85 03 75 123 456",
      "motif": "Douleurs thoraciques",
      "lastConsult": "12/01/2024",
      "hopital": "Hôpital Saint-Antoine",
      "urgence": true,
    },
    {
      "nom": "Jean Moreau",
      "naissance": "03/09/1978",
      "telephone": "1 78 09 75 321 654",
      "motif": "Fracture suspectée",
      "lastConsult": "15/01/2024",
      "hopital": "Centre Médical Saint-Louis",
      "urgence": true,
    },
    {
      "nom": "Sophie Martin",
      "naissance": "20/06/1990",
      "telephone": "1 90 06 75 987 654",
      "motif": "Contrôle général",
      "lastConsult": "18/01/2024",
      "hopital": "Hôpital Saint-Antoine",
      "urgence": false,
    },
    {
      "nom": "Claire Rousseau",
      "naissance": "28/05/1995",
      "telephone": "1 95 05 75 369 258",
      "motif": "Bilan de santé",
      "lastConsult": "20/01/2024",
      "hopital": "Clinique Pasteur",
      "urgence": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> patientsFiltres;

    if (filtreActif == "Urgences") {
      // 🔹 Seulement urgences
      patientsFiltres = patients.where((p) => p["urgence"] == true).toList();
    } else if (filtreActif == "Récents") {
      // 🔹 Seulement récents
      patientsFiltres = patients.where((p) => p["urgence"] == false).toList();
    } else {
      // 🔹 Tous : alterner Urgence → Récent → Urgence → Récent
      final urgences = patients.where((p) => p["urgence"] == true).toList();
      final recents = patients.where((p) => p["urgence"] == false).toList();

      patientsFiltres = [];
      int maxLength = urgences.length + recents.length;

      for (int i = 0; i < maxLength; i++) {
        if (i % 2 == 0 && urgences.isNotEmpty) {
          patientsFiltres.add(urgences.removeAt(0));
        } else if (recents.isNotEmpty) {
          patientsFiltres.add(recents.removeAt(0));
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Historique patient",
          style: TextStyle( fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Champ de recherche
            TextField(
              decoration: InputDecoration(
                hintText: "Nom, prénom ou n° sécurité sociale",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filtres
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChip("Tous", Colors.blue),
                const SizedBox(width: 8),
                _buildChip("Urgences", Colors.red),
                const SizedBox(width: 8),
                _buildChip("Récents", Colors.green),
              ],
            ),
            const SizedBox(height: 16),

            // Liste patients
            Expanded(
              child: ListView.builder(
                itemCount: patientsFiltres.length,
                itemBuilder: (context, index) {
                  final p = patientsFiltres[index];
                  return _buildPatientCard(p);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget filtre (chips)
  Widget _buildChip(String label, Color color) {
    return ChoiceChip(
      label: Text(label),
      selected: filtreActif == label,
      selectedColor: color,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: filtreActif == label ? Colors.white : Colors.black,
      ),
      onSelected: (_) {
        setState(() => filtreActif = label);
      },
    );
  }

  // Widget carte patient
  Widget _buildPatientCard(Map<String, dynamic> p) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom + Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  p["nom"],
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (p["urgence"] == true)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "URGENT",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "RÉCENT",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text("Né(e) le ${p["naissance"]}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(p["telephone"]),
            const SizedBox(height: 8),
            Text(p["motif"]),
            const SizedBox(height: 8),
            Text("Dernière consultation: ${p["lastConsult"]}"),
            const SizedBox(height: 8),
            Text(p["hopital"], style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}
