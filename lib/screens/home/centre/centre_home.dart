import 'package:flutter/material.dart';
import 'package:vitalia_app/screens/home/centre/profil_centre.dart';
import 'package:vitalia_app/screens/home/centre/rendez-vous.dart';
import 'acceuil_centre.dart';
import 'historique_patient.dart';

class CentreHome extends StatefulWidget {
  const CentreHome({super.key});

  @override
  State<CentreHome> createState() => _MainPageState();
}

class _MainPageState extends State<CentreHome> {
  int _selectedIndex = 0;

  // Liste des pages
  final List<Widget> _pages = [
    DashboardPage(),
    RecherchePatientPage(),
    RendezVousPage(),
    //const UrgencesPage(),
    ProfilCentrePage(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Change la page selon l’index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _selectedIndex == 2 ? Colors.blue : Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Accueil"),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Historique"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Rendez-vous"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
        ],
      ),
    );
  }
}
