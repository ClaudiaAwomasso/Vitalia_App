import 'package:flutter/material.dart';
import 'package:vitalia_app/screens/home/admin/utilisateurs.dart';
import 'dashboard_page.dart';
import 'gestion_centres.dart';

class HomeCentre extends StatefulWidget {
  const HomeCentre({Key? key}) : super(key: key);

  @override
  State<HomeCentre> createState() => _HomeCentreState();
}

class _HomeCentreState extends State<HomeCentre> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminDashboardPage(),
    const GestionCentresPage(),
    const GestionUtilisateursPage(),
    const Center(child: Text("Paramètres")),       // à remplacer
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey[400],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Tableau de bord",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: "Centres",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Utilisateurs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Paramètres",
          ),
        ],
      ),
    );
  }
}
