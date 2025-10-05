import 'package:flutter/material.dart';

class CentresDeSantePage extends StatefulWidget {
  const CentresDeSantePage({Key? key}) : super(key: key);

  @override
  State<CentresDeSantePage> createState() => _CentresDeSantePageState();
}
class _CentresDeSantePageState extends State<CentresDeSantePage> {
  String filtreActif = "Tous";

  final List<Map<String, dynamic>> centres = [
    {
      "nom": "Centre Médical Saint-Louis",
      "adresse": "12 Rue de la Santé, 75014 Paris",
      "distance": "0.8 km",
      "horaires": "Lun-Ven: 8h-19h, Sam: 9h-17h",
      "note": "4.8/5",
      "tags": ["Urgences", "Proche"],
      "specialites": ["Médecine générale", "Cardiologie", "Pédiatrie"]
    },
    {
      "nom": "Clinique des Lilas",
      "adresse": "8 Avenue des Lilas, 93260 Les Lilas",
      "distance": "2.3 km",
      "horaires": "Tous les jours: 7h-20h",
      "note": "4.5/5",
      "tags": ["Récent"],
      "specialites": ["Gynécologie", "Dermatologie"]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Centres de santé"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Rechercher un centre ou une spécialité",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // Filtres
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                _buildChip("Tous", Colors.blue),
                _buildChip("Proche", Colors.green),
                _buildChip("Urgences", Colors.red),
                _buildChip("Récent", Colors.purple),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Liste des centres
          Expanded(
            child: ListView.builder(
              itemCount: centres.length,
              itemBuilder: (context, index) {
                final c = centres[index];

                // Filtrage selon l’onglet actif
                if (filtreActif != "Tous" && !c["tags"].contains(filtreActif)) {
                  return const SizedBox.shrink();
                }
                return Card(
                  margin: const EdgeInsets.all(12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nom + tags
                        Row(
                          children: [
                            Expanded(
                              child: Text(c["nom"],
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Wrap(
                              spacing: 6,
                              children: c["tags"].map<Widget>((tag) {
                                return Chip(
                                  label: Text(tag,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 12)),
                                  backgroundColor: tag == "Urgences"
                                      ? Colors.red
                                      : tag == "Proche"
                                      ?  Colors.green
                                      : Colors.purple,
                                );
                              }).toList(),
                            )
                          ],
                        ),

                        const SizedBox(height: 4),
                        Text(c["adresse"]),
                        Text(c["horaires"],
                            style: const TextStyle(color: Colors.grey)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Colors.orange, size: 18),
                            Text(c["note"]),
                            const Spacer(),
                            Text(c["distance"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Spécialités
                        Wrap(
                          spacing: 6,
                          children: c["specialites"]
                              .map<Widget>((s) => Chip(
                            label: Text(s),
                            backgroundColor: Colors.grey[200],
                          ))
                              .toList(),
                        ),

                        const SizedBox(height: 8),

                        // Boutons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue),
                                onPressed: () {},
                                icon: const Icon(Icons.call, color: Colors.white,),
                                label: const Text("Appeler",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                onPressed: () {},
                                icon: const Icon(Icons.calendar_month_rounded, color: Colors.white,),
                                label: const Text("Prendre RDV",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  // Widget pour un bouton filtre (chip)
  Widget _buildChip(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ChoiceChip(
        label: Text(label),
        selected: filtreActif == label,
        selectedColor: color.withOpacity(0.2),
        onSelected: (val) {
          setState(() => filtreActif = label);
        },
      ),
    );
  }
}
