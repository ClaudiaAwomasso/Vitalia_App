import 'package:flutter/material.dart';

class PlanningConsultationsPage extends StatefulWidget {
  const PlanningConsultationsPage({super.key});

  @override
  State<PlanningConsultationsPage> createState() =>
      _PlanningConsultationsPageState();
}

class _PlanningConsultationsPageState extends State<PlanningConsultationsPage> {
  DateTime selectedDate = DateTime(2025, 8, 12);

  // Exemple de données
  final List<Map<String, dynamic>> consultations = [
    {
      "name": "Marie Dubois",
      "type": "Consultation générale",
      "status": "Confirmé",
      "time": "08:30",
      "duration": "30 min",
      "location": "Cabinet 1",
      "notes": "Suivi hypertension"
    },
    {
      "name": "Pierre Laurent",
      "type": "Consultation spécialisée",
      "status": "En cours",
      "time": "09:00",
      "duration": "45 min",
      "location": "Cabinet 2",
      "notes": "Suivi diabète"
    },
  ];

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Planning consultations"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              child: const Text("6", style: TextStyle(color: Colors.blue)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Date sélectionnée
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Date sélectionnée",
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDate,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Statistiques
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _StatBox(label: "Total", value: "6", color: Colors.blue),
              _StatBox(label: "Confirmés", value: "3", color: Colors.green),
              _StatBox(label: "En cours", value: "1", color: Colors.orange),
              _StatBox(label: "Attente", value: "1", color: Colors.red),
            ],
          ),
          const SizedBox(height: 16),

          // Switch Planning / Liste
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Planning"),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Liste"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Liste des consultations
          ...consultations.map((c) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Titre + Heure
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(c["name"],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("${c["time"]} • ${c["duration"]}",
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(c["type"], style: const TextStyle(color: Colors.black87)),
                    const SizedBox(height: 4),

                    Row(
                      children: [
                        Chip(
                          label: Text(c["status"]),
                          backgroundColor: c["status"] == "Confirmé"
                              ? Colors.green.shade100
                              : Colors.orange.shade100,
                          labelStyle: TextStyle(
                              color: c["status"] == "Confirmé"
                                  ? Colors.green
                                  : Colors.orange),
                        ),
                        const SizedBox(width: 8),
                        Text(c["location"], style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text("Notes: ${c["notes"]}"),

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text("Commencer"),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text("Appeler"),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }).toList()
        ],
      ),
    );
  }
}
class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const _StatBox(
      {required this.label, required this.value, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: Colors.black54)),
      ],
    );
  }
}
