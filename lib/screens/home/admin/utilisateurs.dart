import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vitalia_app/screens/home/admin/ajout_dossier.dart';
import 'ajout_medecin.dart';

class GestionUtilisateursPage extends StatefulWidget {
  const GestionUtilisateursPage({super.key});

  @override
  State<GestionUtilisateursPage> createState() => _GestionUtilisateursPageState();
}

class _GestionUtilisateursPageState extends State<GestionUtilisateursPage> {
  String filtreActif = "Médecins";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des utilisateurs"),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              if (filtreActif == "Médecins") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AjoutMedecin()));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NouveauDossierPatientPage()));
              }
            },
            icon: const Icon(Icons.person_add, size: 18),
            label: Text("Ajouter ${filtreActif == "Médecins" ? "Médecin" : "Patient"}"),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Champ de recherche
            TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un utilisateur...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
            const SizedBox(height: 16),

            // Filtres
            Row(
              children: [
                _buildFilterChip(
                    "Médecins",
                    filtreActif == "Médecins",
                    Colors.purple,
                        () {
                      setState(() {
                        filtreActif = "Médecins";
                      });
                    }),
                const SizedBox(width: 8),
                _buildFilterChip(
                    "Patients",
                    filtreActif == "Patients",
                    Colors.teal,
                        () {
                      setState(() {
                        filtreActif = "Patients";
                      });
                    }),
              ],
            ),
            const SizedBox(height: 16),

            // Affichage selon filtre
            if (filtreActif == "Médecins")
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('medecins').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.blue,));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucun médecin trouvé"));
                  }
                  final medecins = snapshot.data!.docs;
                  return Column(
                    children: medecins.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          _buildUserCard(
                            nom: "Dr. ${data['prenom'] ?? ''} ${data['nom'] ?? ''}",
                            specialite: data['specialite'] ?? '',
                            centre: data['centre'] ?? '',
                            email: data['email'] ?? '',
                            telephone: data['telephone'] ?? '',
                            inscrit: data['dateInscription'] ?? '',
                            patients: data['patients']?.toString() ?? '0',
                            consultations: data['consultations']?.toString() ?? '0',
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  );
                },
              )
            else
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('patients').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color:Colors.blue ,));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Aucun patient trouvé"));
                  }
                  final patients = snapshot.data!.docs;
                  return Column(
                    children: patients.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return Column(
                        children: [
                          _buildPatientCard(
                            nom: "${data['prenom'] ?? ''} ${data['nom'] ?? ''}",
                            age: data['age'] != null ? "${data['age']} ans" : 'Âge inconnu',
                            email: data['email'] ?? '',
                            telephone: data['telephone'] ?? '',
                            inscrit: data['dateInscription'] ?? '',
                            consultations: (data['consultations']?.toString() ?? '0'),
                          ),
                          const SizedBox(height: 16),
                        ],
                      );
                    }).toList(),
                  );
                },
              )
          ],
        ),
      ),
    );
  }

  // --- Filtre ---
  Widget _buildFilterChip(String label, bool selected, Color color, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: color.withOpacity(0.2),
      labelStyle: TextStyle(
        color: selected ? color : Colors.black54,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (_) => onTap(),
    );
  }

  // --- Carte médecin ---
  Widget _buildUserCard({
    required String nom,
    required String specialite,
    required String centre,
    required String email,
    required String telephone,
    required String inscrit,
    required String patients,
    required String consultations,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(FontAwesomeIcons.stethoscope,
                          color: Colors.purple, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(specialite,
                            style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.close, size: 18, color: Colors.red),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text("Actif",
                  style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Text("Centre: $centre", style: const TextStyle(fontSize: 13)),
            Text("Email: $email", style: const TextStyle(fontSize: 13)),
            Text("Téléphone: $telephone", style: const TextStyle(fontSize: 13)),
            Text("Inscrit le: $inscrit", style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(patients, "Patients", Colors.blue),
                _buildStatItem(consultations, "Consultations", Colors.green),
                Text("Détails",
                    style: TextStyle(color: Colors.purple[700], fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  // --- Carte patient ---
  Widget _buildPatientCard({
    required String nom,
    required String age,
    required String email,
    required String telephone,
    required String inscrit,
    required String consultations,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.teal.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.person, color: Colors.teal, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nom, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(age, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
                const Icon(Icons.close, size: 18, color: Colors.red),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text("Actif",
                  style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Text("Email: $email", style: const TextStyle(fontSize: 13)),
            Text("Téléphone: $telephone", style: const TextStyle(fontSize: 13)),
            Text("Inscrit le: $inscrit", style: const TextStyle(fontSize: 13)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(consultations, "Consultations", Colors.blue),
                Text("Détails",
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label, Color color) {
    return Row(
      children: [
        Text(number, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
