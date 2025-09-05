import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/providers/patient_provider.dart';
import 'package:vitalia_app/screens/home/patient/dossier_patient.dart';
import 'package:vitalia_app/screens/home/patient/profil_patient.dart';
import 'package:vitalia_app/screens/home/patient/rendezvous.dart';

import 'Patient_home.dart';

class AcceuilPatient extends StatelessWidget {
  const AcceuilPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final patient = patientProvider.patient;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          "Vitalia",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          // 🔔 Notifications
          Container(
            width: 40,
            height: 40,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xB0D2E6FD),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.blue),
            ),
          ),
          // 👤 Profil rapide
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey[300],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person_outline),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 👋 Bienvenue
          Text(
            "Bonjour, ${patient?.nom ?? 'Utilisateur'}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Votre dossier médical personnel",
            style: TextStyle(color: Colors.grey[700], fontSize: 16),
          ),
          const SizedBox(height: 16),

          // 🩺 Carte état de santé
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Colors.blue[600],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Infos santé
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "État de santé",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Dernière mise à jour: 12/01/2024",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Column(
                            children: const [
                              Text("3",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text("Traitements actifs",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14)),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Column(
                            children: const [
                              Text("2",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                              Text("RDV à venir",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14)),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  // Icône santé
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(FontAwesomeIcons.heartPulse,
                        color: Colors.white, size: 27),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // 🔹 Grid de fonctionnalités
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 1,
            children: [
              _buildFeatureCard(
                icon: Icons.folder_open,
                title: "Mon dossier",
                subtitle: "Historique & traitement",
                textColor: Colors.black,
                iconColor: Colors.blue,
                containerColor: const Color(0xB0D2E6FD),
                cardColor: const Color(0xFFF5F5F5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientHomeScreen(initialIndex: 1,)),
                  );
                },
              ),
              _buildFeatureCard(
                icon: Icons.calendar_month_outlined,
                title: "Rendez-vous",
                subtitle: "Planifier & consulter",
                textColor: Colors.black,
                iconColor: Colors.green,
                containerColor: const Color(0xFFC7E3CC),
                cardColor: const Color(0xFFF5F5F5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>   PatientHomeScreen(initialIndex: 2)),
                  );
                },
              ),
              _buildFeatureCard(
                icon: FontAwesomeIcons.hospitalSymbol,
                title: "Centres de santé",
                subtitle: "Trouver un centre",
                textColor: Colors.black,
                iconColor: Colors.purple,
                containerColor: const Color(0xA6E9DDFB),
                cardColor: const Color(0xFFF5F5F5),
                onTap: () {},
              ),
              _buildFeatureCard(
                icon: Icons.person_outline_rounded,
                title: "Mon profil",
                subtitle: "Informations personnelles",
                textColor: Colors.black,
                iconColor: Colors.orange,
                containerColor: const Color(0xFFFAE4B6),
                cardColor: const Color(0xFFF5F5F5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PatientHomeScreen(initialIndex: 3,)),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 15),

          // 📌 Activité récente
          const Text(
            "Activité récente",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          const ListTile(
            leading: Icon(FontAwesomeIcons.stethoscope,
                size: 20, color: Colors.blue),
            title: Text("Consultation générale",
                style: TextStyle(fontSize: 16)),
            subtitle: Text("Dr. Martin - Centre Saint-Louis",
                style: TextStyle(fontSize: 12)),
            trailing: Text("12/01/2024"),
          ),
          const ListTile(
            leading: Icon(FontAwesomeIcons.prescriptionBottleMedical,
                size: 20, color: Colors.green),
            title: Text("Nouvelle ordonnance",
                style: TextStyle(fontSize: 16)),
            subtitle: Text("Paracétamol 1000mg",
                style: TextStyle(fontSize: 12)),
            trailing: Text("13/01/2024"),
          ),
        ],
      ),
    );
  }

  /// 🔹 Widget carte fonctionnalité
  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color iconColor,
    required Color containerColor,
    required Color cardColor,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: iconColor, size: 25),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: textColor.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
