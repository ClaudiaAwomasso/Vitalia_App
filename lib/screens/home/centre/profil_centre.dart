
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../auth/centre/connexion_centre.dart';

class ProfilCentrePage extends StatefulWidget {
  const ProfilCentrePage({super.key});

  @override
  State<ProfilCentrePage> createState() => _ProfilCentrePageState();
}

class _ProfilCentrePageState extends State<ProfilCentrePage> {
  bool notifUrgences = true;
  bool rappelRdv = true;
  bool syncSystem = false;

  Future<Map<String, dynamic>?> _getCentreInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection("centres")
        .doc(user.uid)
        .get();

    if (!doc.exists) return null;
    return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text("Profil du Centre"),
        actions: [
          TextButton(
            onPressed: () {
              // TODO : ouvrir une page "Modifier Profil"
            },
            child: const Text("Modifier",
                style: TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        future: _getCentreInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Aucune information trouvée"));
          }

          final centre = snapshot.data!;
          final nomCentre = centre['nom'] ?? "Centre inconnu";
          final directeur = centre['directeur'] ?? "Non défini";
          final adresse = centre['adresse'] ?? "Non renseignée";
          final email = centre['email'] ?? "Non renseigné";
          final telephone = centre['telephone'] ?? "Non renseigné";
          final profil = centre['profil']; // url image
          final statut = centre['statut'] ?? "Actif";

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// --- Carte Profil ---
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: profil != null && profil.isNotEmpty
                            ? NetworkImage(profil)
                            : const AssetImage("assets/images/hopital.jpg")
                        as ImageProvider,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nomCentre,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text("Directeur : $directeur"),
                            const SizedBox(height: 6),
                            Chip(
                              label: Text(statut),
                              backgroundColor: statut == "Actif"
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              labelStyle: TextStyle(
                                  color: statut == "Actif"
                                      ? Colors.green
                                      : Colors.red),
                              side: BorderSide.none,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// --- Infos Contact ---
              const Text("Informations de contact",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              const SizedBox(height: 8),
              Card(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.location_on_outlined,
                          color: Colors.blue),
                      title: const Text("Adresse"),
                      subtitle: Text(adresse),
                    ),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.blue),
                      title: const Text("Téléphone"),
                      subtitle: Text(telephone),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: const Text("Email"),
                      subtitle: Text(email),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              /// --- Paramètres ---
              const Text("Paramètres",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue)),
              SwitchListTile(
                activeTrackColor: Colors.blue,
                title: const Text("Notifications urgences"),
                value: notifUrgences,
                onChanged: (val) {
                  setState(() => notifUrgences = val);
                },
              ),
              SwitchListTile(
                activeTrackColor: Colors.blue,
                title: const Text("Rappels rendez-vous"),
                value: rappelRdv,
                onChanged: (val) {
                  setState(() => rappelRdv = val);
                },
              ),
              SwitchListTile(
                activeTrackColor: Colors.blue,
                title: const Text("Synchronisation"),
                value: syncSystem,
                onChanged: (val) {
                  setState(() => syncSystem = val);
                },
              ),
              const SizedBox(height: 20),

              /// --- Déconnexion ---
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade50,
                  ),
                  icon: const Icon(Icons.logout, color: Colors.red),
                  label: const Text("Se déconnecter",
                      style: TextStyle(color: Colors.red)),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const ConnexionCentrePage(),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
