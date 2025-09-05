import 'package:flutter/material.dart';

class Rendezvous extends StatelessWidget {
  const Rendezvous({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // 2 onglets
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F7FE),
        appBar: AppBar(

          backgroundColor: Colors.white,
          title: const Text("Mes rendez-vous"),
       //   centerTitle: true,
          actions: [
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color:Colors.blue,
              shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add, color: Colors.white),
              ),
            )
          ],
        ),
        // ---------------- BODY ----------------
        body: Column(
          children: [
            const SizedBox(height: 15),

            // --- Onglets ---
            Container(
              margin: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.black87,
                indicatorColor: Colors.blue,
                tabs: [
                  Tab(text: "À venir (2)"),
                  Tab(text: "Passés (2)"),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // --- Contenu des onglets ---
            Expanded(
              child: TabBarView(
                children: [
                  RdvsAvenir(),
                  RdvsPasses(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/// --------------------
/// Onglet À venir
/// --------------------
class RdvsAvenir extends StatelessWidget {
  const RdvsAvenir({super.key});

  @override
  Widget build(BuildContext context) {
    final rdvs = [
      {
        "titre": "Consultation de suivi",
        "date": "25/01/2024",
        "heure": "14:30",
        "medecin": "Dr. Martin - Médecine générale",
        "lieu": "Centre Médical Saint Louis\n12 Rue de la Santé, 75014 Paris",
      },
      {
        "titre": "Contrôle annuel",
        "date": "02/02/2024",
        "heure": "09:15",
        "medecin": "Dr. Laurent - Cardiologie",
        "lieu": "Clinique des Lilas\n8 Avenue des Lilas, 93260 Les Lilas",
      },
    ];

    return ListView.builder(
      itemCount: rdvs.length,
      itemBuilder: (context, index) {
        final r = rdvs[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre + date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.calendar_month_outlined, color: Colors.blue),
                    Text(r["titre"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(r["date"]!,
                            style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        Text(r["heure"]!,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(r["medecin"]!,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.blue),
                    const SizedBox(width: 4),
                    Expanded(child: Text(r["lieu"]!)),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.call_outlined, color: Colors.white),
                      label: const Text("Appeler",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      label: const Text("Modifier",
                          style: TextStyle(color: Colors.blue)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 1),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6C6D7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.close,
                            color: Colors.red, size: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/// --------------------
/// Onglet Passés
/// --------------------
class RdvsPasses extends StatelessWidget {
  const RdvsPasses({super.key});

  @override
  Widget build(BuildContext context) {
    final rdvsPasses = [
      {
        "titre": "Consultation ORL",
        "date": "15/12/2023",
        "heure": "10:00",
        "medecin": "Dr. Dupont - ORL",
        "lieu": "Hôpital Lariboisière, Paris",
        "notes": "Contrôle des oreilles, tout est normal.",
      },
      {
        "titre": "Suivi diabète",
        "date": "05/01/2024",
        "heure": "11:15",
        "medecin": "Dr. Bernard - Endocrinologie",
        "lieu": "Clinique Saint Anne, Paris",
        "notes": "Taux de glycémie stabilisé.",
      },
    ];
    return ListView.builder(
      itemCount: rdvsPasses.length,
      itemBuilder: (context, index) {
        final r = rdvsPasses[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre + date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(r["titre"]!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(r["date"]!,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold)),
                        Text(r["heure"]!,
                            style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(r["medecin"]!,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(child: Text(r["lieu"]!)),
                  ],
                ),
                const SizedBox(height: 8),
                Text("Notes : ${r["notes"]}",
                    style: const TextStyle(color: Colors.black87)),
              ],
            ),
          ),
        );
      },
    );
  }
}
