import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/modeles/patient_model.dart';
import 'package:vitalia_app/providers/patient_provider.dart';

class DossierPatient extends StatefulWidget {
  const DossierPatient({super.key});

  @override
  State<DossierPatient> createState() => _DossierMedicalPageState();
}

class _DossierMedicalPageState extends State<DossierPatient>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PatientProvider>(context);
    final PatientModel? patient = provider.patient;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FE),
      appBar: AppBar(
        title: const Text("Mon dossier médical"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: patient == null
          ? const Center(child: Text("Aucun patient connecté"))
          : Container(
        decoration: const BoxDecoration(color: Color(0xFFF1F7FE)),
        child: Column(
          children: [
            // 🔹 Header patient
            _buildPatientHeader(patient),

            // 🔹 Onglets
            TabBar(
              isScrollable: true,
              controller: _tabController,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.blue,
              tabs: const [
                Tab(text: "Consultations"),
                Tab(text: "Traitements"),
                Tab(text: "Ordonnances"),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Contenu onglets
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildConsultations(),
                  _buildTraitements(),
                  _buildOrdonnances(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ HEADER PATIENT dynamique
  Widget _buildPatientHeader(PatientModel patient) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: 120,
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xB0D2E6FD),
              radius: 30,
              backgroundImage: (patient.photoUrl != null &&
                  patient.photoUrl!.isNotEmpty)
                  ? NetworkImage(patient.photoUrl!)
                  : null,
              child: (patient.photoUrl == null || patient.photoUrl!.isEmpty)
                  ? const Icon(Icons.person_outline,
                  size: 30, color: Colors.blue)
                  : null,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${patient.nom} ${patient.prenom}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(patient.dateNaissance.isNotEmpty
                    ? "Né(e) le ${patient.dateNaissance}"
                    : "Date de naissance non renseignée"),
                Text("ID Vitalia : ${patient.idVitalia}"),
              ],
            )
          ],
        ),
      ),
    );
  }

  // ✅ ONGLET CONSULTATIONS (exemples fictifs)
  Widget _buildConsultations() {
    final consultations = [
      {
        "titre": "Consultation générale",
        "medecin": "Dr. Martin",
        "lieu": "Centre Médical Saint Louis",
        "date": "12/01/2024",
        "traitement": "Paracétamol 1000mg - 3x/jour",
        "notes": "Légère fatigue, tension normale"
      },
      {
        "titre": "Grippe saisonnière",
        "medecin": "Dr. Durand",
        "lieu": "Hôpital Saint Antoine",
        "date": "28/12/2023",
        "traitement": "Doliprane 500mg - 3x/jour, repos",
        "notes": "Fièvre 38.5°C, courbatures"
      }
    ];

    return ListView.builder(
      itemCount: consultations.length,
      itemBuilder: (context, index) {
        final c = consultations[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(c["titre"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("${c["medecin"]}"),
                Text("${c["lieu"]}"),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(c["date"]!,
                      style: const TextStyle(color: Colors.blue)),
                ),
                const SizedBox(height: 8),
                Text("Traitement prescrit :",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(c["traitement"]!),
                const SizedBox(height: 8),
                Text("Notes : ${c["notes"]}"),
              ],
            ),
          ),
        );
      },
    );
  }

  // ✅ ONGLET TRAITEMENTS
  Widget _buildTraitements() {
    final traitements = [
      {
        "medicament": "Paracétamol 1000mg",
        "frequence": "3x/jour",
        "date": "28/12/2023",
        "medecin": "Dr. Martin",
        "duree": "7 jours"
      },
      {
        "medicament": "Doliprane 500mg",
        "frequence": "6x/jour",
        "date": "12/06/2025",
        "medecin": "Dr. Rose",
        "duree": "3 mois"
      },
    ];
    return ListView.builder(
      itemCount: traitements.length,
      itemBuilder: (context, index) {
        final t = traitements[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              ListTile(
                leading: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0xFFC8E6C9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FontAwesomeIcons.prescriptionBottle,
                      color: Colors.green,
                      size: 20,
                    )),
                title: Text(t["medicament"]!),
                subtitle: Text("Fréquence : ${t["frequence"]}"),
                trailing: Container(
                  width: 75,
                  height: 30,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Center(
                    child: Text(
                      'En cours',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Début : ${t["date"]}"),
                    Text("Durée : ${t["duree"]}"),
                  ],
                ),
                subtitle: Text("Médecin : ${t["medecin"]}"),
              ),
            ],
          ),
        );
      },
    );
  }

  // ✅ ONGLET ORDONNANCES
  Widget _buildOrdonnances() {
    final ordonnances = [
      {
        "numero": "1",
        "date": "12/01/2024",
        "medecin": "Dr. Martin",
        "centre": "Centre Médical Saint Louis",
        "medicaments": ["Paracétamol 1000mg", "Spray nasal"]
      },
      {
        "numero": "2",
        "date": "15/12/2023",
        "medecin": "Dr. Laurent",
        "centre": "Clinique des Lilas",
        "medicaments": ["Vitamine D 1000UI", "Magnésium"]
      }
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: ordonnances.length,
      itemBuilder: (context, index) {
        final o = ordonnances[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre + date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Ordonnance ${o["numero"]}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text("Date : ${o["date"]}",
                        style:
                        const TextStyle(color: Colors.blue, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 8),
                Text("${o["medecin"]}\n${o["centre"]}",
                    style: const TextStyle(color: Colors.black87)),
                const SizedBox(height: 8),
                const Text("Médicaments prescrits :",
                    style: TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (o["medicaments"] as List<String>)
                      .map((med) => Row(
                    children: [
                      const Icon(Icons.circle,
                          size: 8, color: Colors.blue),
                      const SizedBox(width: 6),
                      Text(med),
                    ],
                  ))
                      .toList(),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.download, color: Colors.blue),
                  label: const Text("Télécharger",
                      style: TextStyle(color: Colors.blue)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
