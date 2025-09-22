import 'package:flutter/material.dart';
import 'package:vitalia_app/screens/home/patient/rendezvous.dart';

class RendezVousPage extends StatefulWidget {
  const RendezVousPage({super.key});

  @override
  State<RendezVousPage> createState() => _UrgencesPageState();
}

class _UrgencesPageState extends State<RendezVousPage> {
  String selectedFilter = "Tous";

  // 🔹 Données fictives
  final List<Map<String, dynamic>> patients = [
    {
      "name": "Marie Dubois",
      "age": 39,
      "birth": "15/03/1985",
      "time": "14:30",
      "box": "3",
      "status": "CRITIQUE",
      "progress": "En cours",
      "motif": "Douleurs thoraciques intenses",
      "tension": "160/95",
      "temp": "37.2°C",
      "pouls": "110 bpm",
      "medecin": "Dr. Martin"
    },
    {
      "name": "Jean Moreau",
      "age": 46,
      "birth": "03/09/1978",
      "time": "13:45",
      "box": "1",
      "status": "STABLE",
      "progress": "En attente",
      "motif": "Vertiges soudains",
      "tension": "130/85",
      "temp": "36.8°C",
      "pouls": "90 bpm",
      "medecin": "Dr. Leroy"
    },
    {
      "name": "Sophie Bernard",
      "age": 52,
      "birth": "21/11/1971",
      "time": "15:00",
      "box": "2",
      "status": "CRITIQUE",
      "progress": "En cours",
      "motif": "Douleur abdominale",
      "tension": "150/90",
      "temp": "37.5°C",
      "pouls": "105 bpm",
      "medecin": "Dr. Martin"
    },
    {
      "name": "Pauline Petit",
      "age": 33,
      "birth": "10/06/1990",
      "time": "12:30",
      "box": "4",
      "status": "STABLE",
      "progress": "En attente",
      "motif": "Fièvre persistante",
      "tension": "120/80",
      "temp": "38°C",
      "pouls": "95 bpm",
      "medecin": "Dr. Leroy"
    },
  ];

  // 🔹 Filtrage des patients
  List<Map<String, dynamic>> get filteredPatients {
    if (selectedFilter == "Tous") {
      return patients; // 4 cartes
    } else {
      return patients
          .where((p) => p["progress"] == selectedFilter)
          .toList(); // 2 cartes selon le filtre
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Rendez-vous",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.calendar_today, color: Colors.white),
                onPressed: () {},
              ),
              Positioned(
                right: 6,
                top: 6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Text("4",
                      style: TextStyle(color: Colors.blue, fontSize: 12)),
                ),
              )
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 12),

            // 🔹 Filtres
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  _buildFilter("Tous", patients.length),
                  const SizedBox(width: 8),
                  _buildFilter(
                      "En cours",
                      patients
                          .where((p) => p["progress"] == "En cours")
                          .length),
                  const SizedBox(width: 8),
                  _buildFilter(
                      "En attente",
                      patients
                          .where((p) => p["progress"] == "En attente")
                          .length),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 🔹 Liste des patients filtrés
            Expanded(
              child: ListView.builder(
                itemCount: filteredPatients.length,
                itemBuilder: (context, index) {
                  final p = filteredPatients[index];
                  return PatientUrgenceCard(
                    name: p["name"],
                    age: p["age"],
                    birth: p["birth"],
                    time: p["time"],
                    box: p["box"],
                    status: p["status"],
                    progress: p["progress"],
                    motif: p["motif"],
                    tension: p["tension"],
                    temp: p["temp"],
                    pouls: p["pouls"],
                    medecin: p["medecin"],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Widget filtre
  Widget _buildFilter(String label, int count) {
    final isSelected = selectedFilter == label;
    return ChoiceChip(
      label: Text("$label ($count)",
          style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
      selected: isSelected,
      selectedColor: Colors.blue,
      side: BorderSide(color: Colors.grey),
      checkmarkColor: Colors.white,
      onSelected: (_) {
        setState(() => selectedFilter = label);
      },
    );
  }
}

// 🔹 Carte patient Urgences
class PatientUrgenceCard extends StatelessWidget {
  final String name,
      birth,
      time,
      box,
      status,
      progress,
      motif,
      tension,
      temp,
      pouls,
      medecin;
  final int age;

  const PatientUrgenceCard({
    super.key,
    required this.name,
    required this.age,
    required this.birth,
    required this.time,
    required this.box,
    required this.status,
    required this.progress,
    required this.motif,
    required this.tension,
    required this.temp,
    required this.pouls,
    required this.medecin,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Ligne 1 : Nom + Heure + Box
            Row(
              children: [
                Expanded(
                  child: Text(
                    "$name\n$age ans - Né(e) le $birth",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(time,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue)),
                    Text("Box $box", style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Status
            Row(
              children: [
                if (status == "CRITIQUE")
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.red[100],
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text("CRITIQUE",
                        style: TextStyle(color: Colors.red)),
                  ),
                const SizedBox(width: 8),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8)),
                  child: Text(progress, style: const TextStyle(color: Colors.blue)),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Motif
            Text("Motif de consultation:",
                style: TextStyle(color: Colors.grey[700])),
            Text(motif),
            const SizedBox(height: 8),

            // 🔹 Valeurs médicales
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Tension\n$tension"),
                Text("Température\n$temp"),
                Text("Pouls\n$pouls"),
              ],
            ),
            const SizedBox(height: 8),

            // 🔹 Médecin + boutons
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  medecin,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.folder, size: 18,color: Colors.white,),
                      label: const Text("Dossier",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.visibility, size: 18,color: Colors.white,),
                      label: const Text("Examiner",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
