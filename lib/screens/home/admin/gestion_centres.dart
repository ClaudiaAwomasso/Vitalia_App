
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
                MaterialPageRoute(
                  builder: (context) => const AjouterCentrePage(),
                ),
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

          // 🔹 Liste dynamique Firestore
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("centres").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.blue,));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text("Aucun centre trouvé"));
                }

                // 🔸 Récupération des centres
                List<Map<String, dynamic>> centres = snapshot.data!.docs.map((doc) {
                  final data = doc.data() as Map<String, dynamic>;
                  return {
                    "id": doc.id,
                    "data": data,
                  };
                }).toList();

                // 🔸 Filtrage
                if (filtre != "Tous") {
                  centres = centres.where((c) => c["data"]["statut"] == filtre).toList();
                }

                // 🔸 Affichage
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: centres.length,
                  itemBuilder: (context, index) {
                    final String centreId = centres[index]["id"];
                    final Map<String, dynamic> data = centres[index]["data"];

                    return Column(
                      children: [
                        _buildCentreCard(
                          context: context,
                          centreId: centreId,
                          data: data,
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

  // 🔹 Widget carte centre
  Widget _buildCentreCard({
    required BuildContext context,
    required String centreId,
    required Map<String, dynamic> data,
  }) {
    final nom = data["nom"] ?? "";
    final type = data["type"] ?? "";
    final statut = data["statut"] ?? "Actif";
    final directeur = data["directeur"] ?? "Non défini";
    final telephone = data["telephone"] ?? "";
    final adresse = data["adresse"] ?? "";
    final medecins = (data["medecins"] ?? 0).toString();
    final patients = (data["patients"] ?? 0).toString();
    final consultations = (data["consultations"] ?? 0).toString();

    final Color statutColor = statut == "Actif" ? Colors.green : Colors.orange;

    return Container(
      width: double.infinity, // 🔹 Prend toute la largeur dispo
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titre + icônes
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(Icons.local_hospital, color: Colors.blue, size: 20),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nom,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          type,
                          style: const TextStyle(fontSize: 12, color: Colors.black54),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit, size: 20, color: Colors.blue),
                    onPressed: () async {
                      final updated = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AjouterCentrePage(
                            centreId: centreId,
                            centreData: data,
                          ),
                        ),
                      );
                      if (updated == true) setState(() {});
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, size: 20, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Confirmer la suppression"),
                          content: Text("Supprimer le centre « $nom » ?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text("Annuler",style: TextStyle(color: Colors.black),),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text("Supprimer", style: TextStyle(color: Colors.blue),),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await FirebaseFirestore.instance.collection("centres").doc(centreId).delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Centre « $nom » supprimé")),
                        );
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Statut
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

              // Détails
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text("Directeur: $directeur", style: const TextStyle(fontSize: 13))),
                  Flexible(child: Text("Téléphone: $telephone", style: const TextStyle(fontSize: 13), textAlign: TextAlign.right)),
                ],
              ),
              const SizedBox(height: 4),
              Text(adresse, style: const TextStyle(fontSize: 13)),

              const SizedBox(height: 12),

              // Statistiques
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatItem(medecins, "Médecins", Icons.person, Colors.blue),
                  _buildStatItem(patients, "Patients", Icons.people, Colors.green),
                  _buildStatItem(consultations, "Consultations", Icons.history, Colors.orange),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String number, String label, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        Text(number, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
