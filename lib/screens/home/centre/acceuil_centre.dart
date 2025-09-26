/*import 'package:flutter/material.dart';
import 'package:vitalia_app/screens/home/centre/profil_centre.dart';
import 'package:vitalia_app/screens/home/centre/urgence.dart';

import '../admin/ajout_dossier.dart';
import 'ajout consultation.dart';
import 'historique_patient.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text("Vitalia",style: TextStyle(fontSize: 30,color: Colors.blue),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.person_outline,size: 30,),)
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              /// INFO UTILISATEUR
              const Text(
                "Bonjour, Dr. Martin",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                "Centre Médical Saint-Louis",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),

              /// STATISTIQUES
              Row(
                children: [
                  _StatCard(
                    value: "24",
                    label: "Patients\naujourd'hui",
                    icon: Icons.people,
                    color: Colors.blue,
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    value: "156",
                    label: "Dossiers\naccessibles",
                    icon: Icons.folder,
                    color: Colors.green,

                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// ACTIONS RAPIDES
              const Text(
                "Actions rapides",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  _ActionCard(
                    title: "Ajouter consulation",
                    subtitle: "Créer une nouvelle consultation patient",
                    icon: Icons.add,
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>AjoutConsultation ()),
                      );
                    },
                  ),
                  _ActionCard(
                    title: "Rendez-vous",
                    subtitle: "Planification &  suivi des rendez-vous",
                    icon: Icons.calendar_month_rounded,
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>RendezVousPage()));
                    },
                  ),
                  _ActionCard(
                    title: "Profil",
                    subtitle: "coordonnées  et informations du centre",
                    icon: Icons.local_hospital,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>ProfilMedecinPage()));
                    },
                  ),
                  _ActionCard(
                    title: "Historique patients",
                    subtitle: "Dossier patients enregistrés",
                    icon: Icons.people_alt_outlined,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>RecherchePatientPage ()));
                    },
                  ),
                ],
              ),
              //  Activité récente
              SizedBox(height: 20,),
              const Text(
                "Activité récente",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color:  Color(0xB0D2E6FD),
                        borderRadius: BorderRadius.circular(30)
                  ),
                  child: const Icon(Icons.person_outline,
                      size: 20, color: Colors.blue),
                ),
                title: const Text("Marie Dubois",
                    style: TextStyle(fontSize: 16)),
                subtitle: const Text("Consultation générale",
                    style: TextStyle(fontSize: 12)),
                trailing: const Text("il y à 2h"),
              ),
               ListTile(
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      color:  Color(0xFFC7E3CC),
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: Icon(Icons.person_outline,
                      size: 20, color: Colors.green),
                ),
                title: Text("Pierre Laurent",
                    style: TextStyle(fontSize: 16)),
                subtitle: Text("Suivi cardiologique",
                    style: TextStyle(fontSize: 12)),
                trailing: Text('Il y à 1j'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget carte statistique
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(label, style: const TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget carte d’action rapide
class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(icon, color: color, size: 35),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vitalia_app/modeles/centre_model.dart';
import 'package:vitalia_app/screens/home/centre/urgence.dart';

import 'ajout consultation.dart';
import 'historique_patient.dart';
import 'profil_centre.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  /// Récupère les infos du centre depuis Firestore
  Future<CentreModel?> _getCentreInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('centres')
        .doc(user.uid) // UID du centre utilisé comme docId
        .get();

    if (!doc.exists) return null;
    return CentreModel.fromMap(doc.data()!, doc.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          "Vitalia",
          style: TextStyle(fontSize: 30, color: Colors.blue),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_outline, size: 30),
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: FutureBuilder<CentreModel?>(
          future: _getCentreInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text("Aucune information trouvée"));
            }

            final centre = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  /// INFO UTILISATEUR
                  Text(
                    "Bonjour, ${centre.directeur ?? 'Directeur inconnu'}",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    centre.nom,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  /// STATISTIQUES
                  Row(
                    children: [
                      _StatCard(
                        value: centre.patients.toString(),
                        label: "Patients\naujourd'hui",
                        icon: Icons.people,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 12),
                      _StatCard(
                        value: centre.consultations.toString(),
                        label: "Consultations",
                        icon: Icons.medical_services,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// ACTIONS RAPIDES
                  const Text(
                    "Actions rapides",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _ActionCard(
                        title: "Ajouter consultation",
                        subtitle: "Créer une nouvelle consultation patient",
                        icon: Icons.add,
                        color: Colors.green,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AjoutConsultation()),
                          );
                        },
                      ),
                      _ActionCard(
                        title: "Rendez-vous",
                        subtitle: "Planification & suivi des rendez-vous",
                        icon: Icons.calendar_month_rounded,
                        color: Colors.red,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RendezVousPage()),
                          );
                        },
                      ),
                      _ActionCard(
                        title: "Profil",
                        subtitle: "Coordonnées et informations du centre",
                        icon: Icons.local_hospital,
                        color: Colors.purple,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilCentrePage()),
                          );
                        },
                      ),
                      _ActionCard(
                        title: "Historique patients",
                        subtitle: "Dossiers patients enregistrés",
                        icon: Icons.people_alt_outlined,
                        color: Colors.blue,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecherchePatientPage()),
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  //  Activité récente
                  const Text(
                    "Activité récente",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                  const ListTile(
                    leading: Icon(FontAwesomeIcons.stethoscope,
                        size: 20, color: Colors.blue),
                    title: Text("Marie Dubois",
                        style: TextStyle(fontSize: 16)),
                    subtitle: Text("Consultation générale",
                        style: TextStyle(fontSize: 12)),
                    trailing: Text("12/01/2024"),
                  ),
                  const ListTile(
                    leading: Icon(FontAwesomeIcons.prescriptionBottleMedical,
                        size: 20, color: Colors.green),
                    title: Text("Pierre Laurent",
                        style: TextStyle(fontSize: 16)),
                    subtitle: Text("Suivi cardiologique",
                        style: TextStyle(fontSize: 12)),
                    trailing: Text("13/01/2024"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
/// Widget carte statistique
class _StatCard extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
    required this.color,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(label, style: const TextStyle(fontSize: 12)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget carte d’action rapide
class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            Icon(icon, color: color, size: 35),
            Text(
              title,
              textAlign: TextAlign.center,
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

