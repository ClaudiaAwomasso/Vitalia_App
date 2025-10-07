
import 'package:flutter/material.dart';
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
