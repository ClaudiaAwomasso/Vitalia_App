/*import 'package:flutter/material.dart';

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
}*/
/*
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecherchePatientPage extends StatefulWidget {
  const RecherchePatientPage({super.key});

  @override
  State<RecherchePatientPage> createState() => _RecherchePatientPageState();
}

class _RecherchePatientPageState extends State<RecherchePatientPage> {
  String filtreActif = "Tous";
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Historique patient",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Champ de recherche
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
              onChanged: (value) {
                setState(() => searchQuery = value.toLowerCase());
              },
            ),
            const SizedBox(height: 16),

            // 🔹 Filtres
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

            // 🔹 Liste patients depuis Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("patients")
                    .orderBy("dateInscription", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucun patient trouvé"));
                  }

                  // 🔹 Transformer les données
                  final patients = snapshot.data!.docs.map((doc) {
                    return doc.data() as Map<String, dynamic>;
                  }).toList();

                  // 🔹 Appliquer filtre
                  List<Map<String, dynamic>> patientsFiltres = patients;

                  if (filtreActif == "Urgences") {
                    patientsFiltres =
                        patients.where((p) => p["urgence"] == true).toList();
                  } else if (filtreActif == "Récents") {
                    patientsFiltres =
                        patients.where((p) => p["urgence"] == false).toList();
                  }

                  // 🔹 Appliquer recherche
                  if (searchQuery.isNotEmpty) {
                    patientsFiltres = patientsFiltres.where((p) {
                      final nom = (p["nom"] ?? "").toString().toLowerCase();
                      final prenom =
                      (p["prenom"] ?? "").toString().toLowerCase();
                      final telephone =
                      (p["telephone"] ?? "").toString().toLowerCase();
                      return nom.contains(searchQuery) ||
                          prenom.contains(searchQuery) ||
                          telephone.contains(searchQuery);
                    }).toList();
                  }

                  return ListView.builder(
                    itemCount: patientsFiltres.length,
                    itemBuilder: (context, index) {
                      final p = patientsFiltres[index];
                      return _buildPatientCard(p);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Widget filtre (chips)
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

  // 🔹 Widget carte patient
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
                  "${p["prenom"] ?? ""} ${p["nom"] ?? ""}",
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
            Text("Né(e) le ${p["dateNaissance"] ?? "Inconnue"}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text(p["telephone"] ?? "—"),
            const SizedBox(height: 8),
            Text(p["motif"] ?? "—"),
            const SizedBox(height: 8),
            Text("Dernière consultation: ${p["lastConsult"] ?? "—"}"),
            const SizedBox(height: 8),
            Text(p["hopital"] ?? "—",
                style: const TextStyle(color: Colors.blue)),
          ],
        ),
      ),
    );
  }
}*/import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecherchePatientPage extends StatefulWidget {
  const RecherchePatientPage({super.key});

  @override
  State<RecherchePatientPage> createState() => _RecherchePatientPageState();
}

class _RecherchePatientPageState extends State<RecherchePatientPage> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Historique patient",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Champ de recherche
            TextField(
              decoration: InputDecoration(
                hintText: "Nom, prénom ou téléphone",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value.toLowerCase()),
            ),
            const SizedBox(height: 16),

            // Liste patients Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection("patients").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.blue,));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucun patient trouvé"));
                  }

                  final patients = snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    data["id"] = doc.id;
                    return data;
                  }).toList();

                  // Filtrer par recherche
                  var patientsFiltres = patients.where((p) {
                    final nom = (p["nom"] ?? "").toString().toLowerCase();
                    final prenom = (p["prenom"] ?? "").toString().toLowerCase();
                    final tel = (p["telephone"] ?? "").toString().toLowerCase();
                    return searchQuery.isEmpty ||
                        nom.contains(searchQuery) ||
                        prenom.contains(searchQuery) ||
                        tel.contains(searchQuery);
                  }).toList();

                  return ListView.builder(
                    itemCount: patientsFiltres.length,
                    itemBuilder: (context, index) {
                      final p = patientsFiltres[index];
                      return _buildPatientCard(p);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            Text(
              "${p["prenom"] ?? ""} ${p["nom"] ?? ""}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("Né(e) le ${p["dateNaissance"] ?? "Inconnue"}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Text("Téléphone: ${p["telephone"] ?? "—"}"),
            const SizedBox(height: 8),

            // Consultation (une seule si elle existe)
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("consultations")
                  .where("patientId", isEqualTo: p["id"])
                  .limit(1)
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text("Aucune consultation");
                }

                final consult = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                final dateConsult = consult["date"] != null
                    ? (consult["date"] as Timestamp).toDate()
                    : null;
                final dateFormatted = dateConsult != null
                    ? "${dateConsult.day}/${dateConsult.month}/${dateConsult.year}"
                    : "—";

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Motif: ${consult["motif"] ?? "—"}"),
                    Text("Date: $dateFormatted"),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
