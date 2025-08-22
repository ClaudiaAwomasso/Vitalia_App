import 'package:flutter/material.dart';

class PatientLoginScreen extends StatelessWidget {
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController idCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Patient")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: phoneCtrl,
              decoration: InputDecoration(labelText: "Téléphone"),
            ),
            TextField(
              controller: idCtrl,
              decoration: InputDecoration(labelText: "ID Vitalia"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (phoneCtrl.text.isNotEmpty && idCtrl.text.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PatientHomeScreen(
                        phone: phoneCtrl.text,
                        id: idCtrl.text,
                      ),
                    ),
                  );
                }
              },
              child: Text("Se connecter"),
            ),
          ],
        ),
      ),
    );
  }
}

class PatientHomeScreen extends StatelessWidget {
  final String phone;
  final String id;

  PatientHomeScreen({required this.phone, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Accueil Patient")),
      body: Center(
        child: Text(
          "Bienvenue !\nTéléphone : $phone\nID : $id",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
