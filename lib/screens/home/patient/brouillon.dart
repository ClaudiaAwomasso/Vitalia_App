/*import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/providers/patient_provider.dart';
import 'package:vitalia_app/screens/home/patient/dossier_patient.dart';
import 'package:vitalia_app/screens/home/patient/profil_patient.dart';
import 'package:vitalia_app/screens/home/patient/rendezvous.dart';


class PatientHomeSreen extends StatefulWidget {
  const PatientHomeSreen({super.key});

  @override
  State<PatientHomeSreen> createState() => _PatientHomeSreenState();
}

class _PatientHomeSreenState extends State<PatientHomeSreen> {
  int _selectedIndex = 0;
// Les page
  final List<Widget> _pages = [
    DossierPatient(),
    ProfilPatient(),
    Rendezvous(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    // ✅ On récupère le patient depuis le provider
    final patientProvider = Provider.of<PatientProvider>(context);
    final patient = patientProvider.patient; // PatientModel ?

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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xB0D2E6FD),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.blue),
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300],
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // ✅ Si patient existe → affiche son nom
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

                // ---- Ici tu peux ensuite connecter le reste (consultations, rdv, etc.)
                // Pour l'instant je garde tes widgets fixes comme exemple
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
                                  color: Colors.white70, fontSize: 14),
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
                                            color: Colors.white70,
                                            fontSize: 14)),
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
                                            color: Colors.white70,
                                            fontSize: 14)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(FontAwesomeIcons.heartPulse,
                              color: Colors.white, size: 27),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Grid de fonctionnalités
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
                      onTap: () {},
                    ),
                    _buildFeatureCard(
                      icon: Icons.calendar_month_outlined,
                      title: "Rendez-vous",
                      subtitle: "Planifier & consulter",
                      textColor: Colors.black,
                      iconColor: Colors.green,
                      containerColor: const Color(0xFFC7E3CC),
                      cardColor: const Color(0xFFF5F5F5),
                      onTap: () {},
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
                      onTap: () {},
                    ),
                  ],
                ),

                const SizedBox(height: 15),
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
          ),
        ],
      ),
    );
  }

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
}*/

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/providers/patient_provider.dart';
import 'package:vitalia_app/screens/home/patient/dossier_patient.dart';
import 'package:vitalia_app/screens/home/patient/profil_patient.dart';
import 'package:vitalia_app/screens/home/patient/rendezvous.dart';

class PatientHomeSreen extends StatefulWidget {
  const PatientHomeSreen({super.key});

  @override
  State<PatientHomeSreen> createState() => _PatientHomeSreenState();
}

class _PatientHomeSreenState extends State<PatientHomeSreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<PatientProvider>(context);
    final patient = patientProvider.patient;

    // Pages du BottomNavigationBar
    final List<Widget> _pages = [
      // Premier onglet → ton ListView actuel (Accueil)
      ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                // Carte état de santé
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
                                  color: Colors.white70, fontSize: 14),
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
                                            color: Colors.white70,
                                            fontSize: 14)),
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
                                            color: Colors.white70,
                                            fontSize: 14)),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(FontAwesomeIcons.heartPulse,
                              color: Colors.white, size: 27),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Grid de fonctionnalités
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
                        setState(() {
                          _selectedIndex = 1; // va sur DossierPatient
                        });
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
                        setState(() {
                          _selectedIndex = 2; // va sur rendez-vous patient
                        });
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
                        setState(() {
                          _selectedIndex = 3; // va sur profil patient
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
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
          ),
        ],
      ),
      DossierPatient(),
      // Deuxième onglet → Profil
      ProfilPatient(),
      // Troisième onglet → Rendez-vous
      Rendezvous(),
    ];

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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color(0xB0D2E6FD),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none, color: Colors.blue),
            ),
          ),
          const SizedBox(width: 12),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300],
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_outline),
              ),
            ),
          ),
        ],
      ),
      // Affiche la page sélectionnée
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Dossier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Rendez-vous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
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

