import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vitalia_app/screens/home/admin/ajout_dossier.dart';

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
                // ouvrir formulaire ajout médecin
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>NouveauDossierPatientPage()));
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
                _buildFilterChip("Médecins (5)", filtreActif == "Médecins", Colors.purple, () {
                  setState(() {
                    filtreActif = "Médecins";
                  });
                }),
                const SizedBox(width: 8),
                _buildFilterChip("Patients (6)", filtreActif == "Patients", Colors.teal, () {
                  setState(() {
                    filtreActif = "Patients";
                  });
                }),
              ],
            ),
            const SizedBox(height: 16),

            // Affichage selon filtre
            if (filtreActif == "Médecins") ...[
              _buildUserCard(
                nom: "Dr. Martin Dubois",
                specialite: "Médecine générale",
                centre: "Centre Médical Saint-Louis",
                email: "martin.dubois@medconnect.fr",
                telephone: "+33 6 12 34 56 78",
                inscrit: "15/03/2023",
                patients: "156",
                consultations: "12",
              ),
              const SizedBox(height: 16),
              _buildUserCard(
                nom: "Dr. Sophie Laurent",
                specialite: "Cardiologie",
                centre: "Hôpital Saint-Antoine",
                email: "sophie.laurent@medconnect.fr",
                telephone: "+33 6 22 44 55 66",
                inscrit: "10/06/2022",
                patients: "89",
                consultations: "7",
              ),
              const SizedBox(height: 16),
              _buildUserCard(
                nom: "Dr. Ahmed Ben Salah",
                specialite: "Pédiatrie",
                centre: "Clinique Les Lilas",
                email: "ahmed.bensalah@medconnect.fr",
                telephone: "+33 6 45 67 89 00",
                inscrit: "02/01/2024",
                patients: "120",
                consultations: "9",
              ),
              const SizedBox(height: 16),
              _buildUserCard(
                nom: "Dr. Claire Fontaine",
                specialite: "Dermatologie",
                centre: "Centre Dermatologique Paris",
                email: "claire.fontaine@medconnect.fr",
                telephone: "+33 6 77 88 99 11",
                inscrit: "20/07/2023",
                patients: "64",
                consultations: "5",
              ),
              const SizedBox(height: 16),
              _buildUserCard(
                nom: "Dr. Jean Dupont",
                specialite: "Orthopédie",
                centre: "CHU Lyon Sud",
                email: "jean.dupont@medconnect.fr",
                telephone: "+33 6 33 44 55 66",
                inscrit: "05/05/2022",
                patients: "101",
                consultations: "8",
              ),
            ] else ...[
              _buildPatientCard(
                nom: "Alice Martin",
                age: "29 ans",
                email: "alice.martin@example.com",
                telephone: "+33 6 99 88 77 66",
                inscrit: "10/04/2023",
                consultations: "3",
              ),
              const SizedBox(height: 16),
              _buildPatientCard(
                nom: "Lucas Bernard",
                age: "42 ans",
                email: "lucas.bernard@example.com",
                telephone: "+33 6 55 44 33 22",
                inscrit: "01/08/2022",
                consultations: "7",
              ),
              const SizedBox(height: 16),
              _buildPatientCard(
                nom: "Camille Durand",
                age: "35 ans",
                email: "camille.durand@example.com",
                telephone: "+33 6 77 11 22 33",
                inscrit: "15/01/2024",
                consultations: "2",
              ),
              const SizedBox(height: 16),
              _buildPatientCard(
                nom: "Nicolas Petit",
                age: "50 ans",
                email: "nicolas.petit@example.com",
                telephone: "+33 6 88 77 66 55",
                inscrit: "23/09/2021",
                consultations: "5",
              ),
              const SizedBox(height: 16),
              _buildPatientCard(
                nom: "Sophie Morel",
                age: "27 ans",
                email: "sophie.morel@example.com",
                telephone: "+33 6 22 11 44 55",
                inscrit: "09/11/2023",
                consultations: "1",
              ),
              const SizedBox(height: 16),
              _buildPatientCard(
                nom: "Hugo Lefevre",
                age: "31 ans",
                email: "hugo.lefevre@example.com",
                telephone: "+33 6 66 55 44 33",
                inscrit: "30/06/2022",
                consultations: "4",
              ),
            ]
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
            // Ligne titre + action
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
            // Statut
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatItem(patients, "Patients", Colors.blue),
                  _buildStatItem(consultations, "Consultations hier", Colors.green),
                  Text("Détails",
                      style: TextStyle(color: Colors.purple[700], fontWeight: FontWeight.bold)),
                ],
              ),
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
            // Ligne titre + action
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
                        Text(age,
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

  // --- Petit widget stat ---
  Widget _buildStatItem(String number, String label, Color color) {
    return Row(
      children: [
        Text(number,
            style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
