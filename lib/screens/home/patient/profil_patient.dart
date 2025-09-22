import 'package:flutter/material.dart';

class ProfilPatient extends StatelessWidget {
  const ProfilPatient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Mon profil"),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: aller vers la page d’édition du profil
            },
            child: const Text(
              "Modifier",
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar rond
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=47", // image exemple
              ),
            ),
            const SizedBox(height: 20),

            // Carte infos personnelles
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Informations personnelles",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),

                    _InfoRow("Nom complet", "Marie Dubois"),
                    _InfoRow("Téléphone", "+33 6 12 34 56 78"),
                    _InfoRow("Email", "marie.dubois@email.c"
                        "om"),
                    _InfoRow("Date de naissance", "15/03/1985"),
                    _InfoRow("Adresse", "25 Rue de la Paix, 75001 Paris"),
                    _InfoRow("Numéro de sécurité sociale", "1 85 03 75 123 456"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget personnalisé pour chaque ligne d’info
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              )),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }
}
