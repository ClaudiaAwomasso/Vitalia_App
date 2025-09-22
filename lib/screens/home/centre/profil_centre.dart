import 'package:flutter/material.dart';

class ProfilMedecinPage extends StatefulWidget {
  const ProfilMedecinPage({super.key});

  @override
  State<ProfilMedecinPage> createState() => _ProfilMedecinPageState();
}
class _ProfilMedecinPageState extends State<ProfilMedecinPage> {
  // Switch states
  bool notifUrgences = true;
  bool rappelRdv = true;
  bool syncSystem = false;

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
            onPressed: () {},
            child: const Text("Modifier", style: TextStyle(color: Colors.blue),),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Carte profil
          Card(
            color: Colors.white,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                   backgroundImage: AssetImage("assets/images/hopital.jpg"),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Centre Médical Saint-Louis",
                            style: TextStyle(color: Colors.black,fontSize: 18,fontWeight:FontWeight.bold)),
                        const SizedBox(height: 6),
                        Text("Établi depuis 2015"),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 30), // or
                            Icon(Icons.star, color: Colors.amber, size: 30), // or
                            Icon(Icons.star, color: Colors.amber, size: 30), // or
                            Icon(Icons.star, color: Colors.amber, size: 30), // or
                            Icon(Icons.star, color: Colors.grey, size: 30),  // gris
                          ],
                        ),
                        Row(
                          children: [
                            Chip(
                              label: const Text("Actif"),
                              backgroundColor: Colors.blue.shade100,
                              side: BorderSide.none,
                              labelStyle:
                              const TextStyle(color: Colors.blueAccent),
                            ),
                            const SizedBox(width: 6),
                            Chip(
                              label: const Text("Certifié"),
                              backgroundColor: Colors.green.shade100,
                              side: BorderSide.none,
                              labelStyle:
                              const TextStyle(color: Colors.green),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Statistiques
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12)
                ),
                child: const _StatBox(
                    value: "156",
                    label: "Consultations ce mois",
                    color: Colors.blue),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                    color:  Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const _StatBox(
                    value: "1245",
                    label: "Patients suivis",
                    color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                    color:  Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const _StatBox(
                    value: "45",
                    label: "Urgences traitées",
                    color: Colors.red),
              ),
              Container(
                padding: EdgeInsets.all(10),
                width: 120,
                height: 100,
                decoration: BoxDecoration(
                    color:  Colors.grey[100],
                    borderRadius: BorderRadius.circular(12)
                ),
                child: const _StatBox(
                    value: "15",
                    label: "Médecins actifs",
                    color: Colors.purple),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Informations de contact
          const Text("Informations de contact",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue)),
          const SizedBox(height: 8),
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.location_on_outlined,color: Colors.blue,),
                    title: Text("Adresse", style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Text("456 Avenue des Soins, 75018 Paris"),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone,color: Colors.blue,),
                    title: Text("Téléphone",style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("+229 0154869632"),
                  ),
                  ListTile(
                    leading: Icon(Icons.email,color: Colors.blue,),
                    title: Text("Email"),
                    subtitle: Text('contact@csparissnord.fr'),
                  ),

                ],
              ),
            )
          ),
          const SizedBox(height: 20),
          // Paramètres
          const Text("Paramètres",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue)),
          const SizedBox(height: 8),
          SwitchListTile(
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            title: const Text("Notifications urgences"),
            subtitle: const Text("Recevoir les alertes d'urgences"),
            value: notifUrgences,
            onChanged: (val) {
              setState(() {
                notifUrgences = val;
              });
            },
          ),
          SwitchListTile(
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            title: const Text("Rappels rendez-vous"),
            subtitle: const Text("SMS/Email avant les consultations"),
            value: rappelRdv,
            onChanged: (val) {
              setState(() {
                rappelRdv = val;
              });
            },
          ),
          SwitchListTile(
            activeColor: Colors.white,
            activeTrackColor: Colors.blue,
            title: const Text("Synchronisation"),
            subtitle: const Text("Sync avec le système central"),
            value: syncSystem,
            onChanged: (val) {
              setState(() {
                syncSystem = val;
              });
            },
          ),
          const SizedBox(height: 20),

          // Horaires
          const Text("Horaires de travail",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.blue)),
          const SizedBox(height: 8),
          Card(
            color: Colors.white,
            child: Column(
              children: const [
                ListTile(
                    title: Text("Lundi - Vendredi"),
                    subtitle: Text("08h00 - 18h00")),
                Divider(height: 1),
                ListTile(
                    title: Text("Samedi"), subtitle: Text("08h00 - 13h00")),
                Divider(height: 1),
                ListTile(title: Text("Dimanche"), subtitle: Text("Fermé ")),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Bouton Déconnexion
          Center(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[100],
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.logout, color: Colors.red),
              label: const Text("Se déconnecter",
                  style: TextStyle(color: Colors.red, fontSize: 16)),
              onPressed: () {
                // Ici tu ajoutes ta logique de logout (Firebase Auth signOut par ex.)
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _StatBox(
      {required this.value, required this.label, required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: TextStyle(
                color: color, fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.black54, fontSize: 13)),
      ],
    );
  }
}
