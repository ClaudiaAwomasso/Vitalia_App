/*import 'package:flutter/material.dart';
import 'nouveaucentre.dart';

class GestionCentresPage extends StatefulWidget {
  const GestionCentresPage({super.key});

  @override
  State<GestionCentresPage> createState() => _GestionCentresPageState();
}

class _GestionCentresPageState extends State<GestionCentresPage> {
  String filtre = "Tous"; // 🔹 Valeur par défaut

  // 🔹 Liste des centres (données fictives au départ)
  final List<Map<String, String>> centres = [
    {
      "nom": "Centre Médical Saint-Louis",
      "type": "Centre médical",
      "statut": "Actif",
      "directeur": "Dr. Martin Dubois",
      "telephone": "+33 1 42 36 15 78",
      "adresse": "15 Avenue Saint-Louis, 75001 Paris",
      "medecins": "8",
      "patients": "456",
      "consultations": "32",
    },
    {
      "nom": "Hôpital Saint-Antoine",
      "type": "Hôpital public",
      "statut": "Actif",
      "directeur": "Non défini",
      "telephone": "+33 1 50 20 30 40",
      "adresse": "20 Rue de l'Hôpital, 75012 Paris",
      "medecins": "12",
      "patients": "678",
      "consultations": "45",
    },
    {
      "nom": "Clinique des Lilas",
      "type": "Clinique privée",
      "statut": "Maintenance",
      "directeur": "Dr. Sophie Lambert",
      "telephone": "+33 1 44 55 66 77",
      "adresse": "5 Rue des Lilas, 75019 Paris",
      "medecins": "6",
      "patients": "210",
      "consultations": "15",
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 🔹 Filtrage en fonction du choix
    List<Map<String, String>> centresFiltres;
    if (filtre == "Tous") {
      centresFiltres = centres;
    } else {
      centresFiltres =
          centres.where((centre) => centre["statut"] == filtre).toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des centres"),
        actions: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () async {
              // 🔹 Aller à la page d’ajout
              final nouveauCentre = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AjouterCentrePage(),
                ),
              );

              // 🔹 Ajouter le nouveau centre à la liste avec valeurs fictives
              if (nouveauCentre != null && nouveauCentre is Map<String, String>) {
                setState(() {
                  centres.add({
                    ...nouveauCentre,
                    "medecins": "5",       // 🔹 Valeur fictive
                    "patients": "200",     // 🔹 Valeur fictive
                    "consultations": "10", // 🔹 Valeur fictive
                  });
                });
              }
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Nouveau"),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔹 Filtres
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterChip("Tous", filtre == "Tous", Colors.purple),
                const SizedBox(width: 8),
                _buildFilterChip("Actif", filtre == "Actif", Colors.green),
                const SizedBox(width: 8),
                _buildFilterChip("Maintenance", filtre == "Maintenance", Colors.orange),
              ],
            ),
            const SizedBox(height: 16),

            // 🔹 Liste des centres filtrés
            for (var centre in centresFiltres) ...[
              _buildCentreCard(
                nom: centre["nom"]!,
                type: centre["type"]!,
                statut: centre["statut"]!,
                directeur: centre["directeur"]!,
                telephone: centre["telephone"]!,
                adresse: centre["adresse"]!,
                medecins: centre["medecins"]!,
                patients: centre["patients"]!,
                consultations: centre["consultations"]!,
              ),
              const SizedBox(height: 16),
            ],
          ],
        ),
      ),
    );
  }

  // 🔹 Widget filtre
  Widget _buildFilterChip(String label, bool selected, Color color) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: color.withOpacity(0.2),
      labelStyle: TextStyle(
        color: selected ? color : Colors.black54,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (_) {
        setState(() {
          filtre = label; // 🔹 Changer le filtre sélectionné
        });
      },
    );
  }

  // 🔹 Widget carte centre
  Widget _buildCentreCard({
    required String nom,
    required String type,
    required String statut,
    required String directeur,
    required String telephone,
    required String adresse,
    required String medecins,
    required String patients,
    required String consultations,
  }) {
    Color statutColor = statut == "Actif" ? Colors.green : Colors.orange;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Titre
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.local_hospital,
                          color: Colors.blue, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 160,
                          child: Text(
                            nom,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          type,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.edit, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Icon(Icons.delete, size: 18, color: Colors.red),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Statut
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statutColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                statut,
                style: TextStyle(
                  color: statutColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 🔹 Infos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    "Directeur: $directeur",
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Flexible(
                  child: Text(
                    "Téléphone: $telephone",
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(adresse,
                style: const TextStyle(fontSize: 13),
                overflow: TextOverflow.ellipsis),

            const SizedBox(height: 12),

            // 🔹 Statistiques alignées
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(medecins, "Médecins", Icons.person, Colors.blue),
                _buildStatItem(patients, "Patients", Icons.people, Colors.green),
                _buildStatItem(
                    consultations, "Consultations", Icons.history, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Petits stats
  Widget _buildStatItem(String number, String label, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 4),
        Text(
          number,
          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'nouveaucentre.dart';

class GestionCentresPage extends StatefulWidget {
  const GestionCentresPage({super.key});

  @override
  State<GestionCentresPage> createState() => _GestionCentresPageState();
}

class _GestionCentresPageState extends State<GestionCentresPage> {
  String filtre = "Tous"; // Valeur par défaut

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gestion des centres"),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AjouterCentrePage()),
              );
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Nouveau"),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // 🔹 Filtres
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFilterChip("Tous", filtre == "Tous", Colors.purple),
              const SizedBox(width: 8),
              _buildFilterChip("Actif", filtre == "Actif", Colors.green),
              const SizedBox(width: 8),
              _buildFilterChip("Maintenance", filtre == "Maintenance", Colors.orange),
            ],
          ),
          const SizedBox(height: 16),

          // 🔹 Liste dynamique depuis Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("centres").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Aucun centre trouvé"));
                }

                // Récupération des centres
                var centres = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return {
                    "id": doc.id,
                    "nom": data["nom"] ?? "",
                    "type": data["type"] ?? "",
                    "statut": data["statut"] ?? "Actif", // valeur par défaut
                    "directeur": data["directeur"] ?? "Non défini",
                    "telephone": data["telephone"] ?? "",
                    "adresse": data["adresse"] ?? "",
                    "medecins": (data["medecins"] ?? 0).toString(),
                    "patients": (data["patients"] ?? 0).toString(),
                    "consultations": (data["consultations"] ?? 0).toString(),
                  };
                }).toList();

                // 🔹 Filtrage selon le choix
                if (filtre != "Tous") {
                  centres = centres.where((c) => c["statut"] == filtre).toList();
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: centres.length,
                  itemBuilder: (context, index) {
                    final centre = centres[index];
                    return Column(
                      children: [
                        _buildCentreCard(
                          nom: centre["nom"]!,
                          type: centre["type"]!,
                          statut: centre["statut"]!,
                          directeur: centre["directeur"]!,
                          telephone: centre["telephone"]!,
                          adresse: centre["adresse"]!,
                          medecins: centre["medecins"]!,
                          patients: centre["patients"]!,
                          consultations: centre["consultations"]!,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Widget filtre
  Widget _buildFilterChip(String label, bool selected, Color color) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: color.withOpacity(0.2),
      labelStyle: TextStyle(
        color: selected ? color : Colors.black54,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (_) {
        setState(() {
          filtre = label;
        });
      },
    );
  }

  // 🔹 Widget carte centre (inchangé)
  Widget _buildCentreCard({
    required String nom,
    required String type,
    required String statut,
    required String directeur,
    required String telephone,
    required String adresse,
    required String medecins,
    required String patients,
    required String consultations,
  }) {
    Color statutColor = statut == "Actif" ? Colors.green : Colors.orange;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // titre + icônes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.local_hospital,
                          color: Colors.blue, size: 20),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nom,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold)),
                        Text(type,
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Icon(Icons.edit, size: 18, color: Colors.grey),
                    SizedBox(width: 8),
                    Icon(Icons.delete, size: 18, color: Colors.red),
                  ],
                )
              ],
            ),
            const SizedBox(height: 8),

            // statut
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statutColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(statut,
                  style: TextStyle(
                    color: statutColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            const SizedBox(height: 12),

            // infos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Text("Directeur: $directeur",
                        style: const TextStyle(fontSize: 13))),
                Flexible(
                    child: Text("Téléphone: $telephone",
                        style: const TextStyle(fontSize: 13),
                        textAlign: TextAlign.right)),
              ],
            ),
            const SizedBox(height: 4),
            Text(adresse, style: const TextStyle(fontSize: 13)),

            const SizedBox(height: 12),

            // stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem(medecins, "Médecins", Icons.person, Colors.blue),
                _buildStatItem(patients, "Patients", Icons.people, Colors.green),
                _buildStatItem(
                    consultations, "Consultations", Icons.history, Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        Text(number,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: color, fontSize: 14)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

