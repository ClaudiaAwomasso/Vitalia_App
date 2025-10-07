import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vitalia_app/screens/home/admin/parametre.dart';
import 'package:vitalia_app/screens/home/admin/utilisateurs.dart';

import 'gestion_centres.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              "Vitalia",
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "Admin",
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.search, color: Colors.black54),
          SizedBox(width: 12),
          Icon(Icons.account_circle, color: Colors.black54),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              "Tableau de bord administrateur",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Vue d'ensemble du système Vitalia",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 20),

            // 🔹 Statistiques
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                _buildStatCard("12", "Centres de santé", Icons.local_hospital, Colors.blue),
                _buildStatCard("1847", "Patients inscrits", Icons.people, Colors.green),
                _buildStatCard("45", "Médecins actifs", Icons.person, Colors.purple),
                _buildStatCard("156", "Consultations hier", Icons.event_note, Colors.orange),
              ],
            ),
            const SizedBox(height: 20),

            // 🔹 Gestion rapide
            const Text(
              "Gestion rapide",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    "Centres de santé",
                    "Gérer les établissements",
                    Icons.local_hospital,
                    Colors.blue,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>GestionCentresPage()));
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickAction(
                    "Utilisateurs",
                    "Patients et médecins",
                    Icons.people,
                    Colors.green,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>GestionUtilisateursPage()));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildQuickAction(
                    "Statistiques",
                    "Analyses et rapport",
                    Icons.bar_chart,
                    Colors.purple,
                        () {
                      print("Navigation vers statistiques");
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildQuickAction(
                    "Paramètres",
                    "Configuration système",
                    Icons.settings,
                    Colors.orange,
                        () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>ParametresSystemePage()));

                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            const Text(
              "Activité récente",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const ListTile(
              leading: Icon(FontAwesomeIcons.stethoscope,
                  size: 20, color: Colors.blue),
              title: Text("Nouveau centre : Clinique des Oliviers",
                  style: TextStyle(fontSize: 16)),

              trailing: Text("il y à 2h"),
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
    );
  }

  // 🔹 Widget Statistique
  Widget _buildStatCard(String number, String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            number,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(title, style: const TextStyle(color: Colors.black54, fontSize: 17)),
          ),
        ],
      ),
    );
  }

  // 🔹 Widget Gestion rapide avec onTap
  Widget _buildQuickAction(
      String title,
      String subtitle,
      IconData icon,
      Color color,
      VoidCallback onTap,
      ) {
    return InkWell(
      onTap: onTap, //  Action quand on clique
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
