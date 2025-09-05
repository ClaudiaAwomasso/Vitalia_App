import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/providers/patient_provider.dart';
import 'package:vitalia_app/screens/home/patient/dossier_patient.dart';
import 'package:vitalia_app/screens/home/patient/profil_patient.dart';
import 'package:vitalia_app/screens/home/patient/rendezvous.dart';
import 'package:vitalia_app/screens/home/patient/acceuil_patient.dart';

class PatientHomeScreen extends StatefulWidget {
  final int initialIndex; // 👈 ajout

  const PatientHomeScreen({super.key, this.initialIndex = 0}); // 👈 valeur par défaut = Accueil

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  late int _selectedIndex; // 👈 devient "l ate" car on l’initialise dans initState

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex; // 👈 démarre sur l’onglet demandé
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<PatientProvider>(context).patient;

    final List<Widget> _pages = const [
      AcceuilPatient(),
      DossierPatient(),
      Rendezvous(),
      ProfilPatient(),
    ];
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black45,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Dossier'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: 'Rendez-vous'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}
