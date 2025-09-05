import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vitalia_app/providers/patient_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vitalia_app/screens/home/patient/Patient_home.dart';

class PatientLogin extends StatefulWidget {
  const PatientLogin({super.key});

  @override
  State<PatientLogin> createState() => _PatientLoginState();
}

class _PatientLoginState extends State<PatientLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = Provider.of<PatientProvider>(context, listen: false);

    final success = await provider.login(
      _phoneController.text.trim(),
      _idController.text.trim(),
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const PatientHomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("❌ Numéro ou ID Vitalia invalide")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F7FE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF1F7FE),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Image.asset(
                "assets/images/logotransparent.png",
                width: 200,
              ),
              const SizedBox(height: 20),
              const Text(
                'Accédez à votre dossier médical',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Colors.grey,
                        controller: _phoneController,
                        decoration: const InputDecoration(
                          labelText: "Téléphone",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez renseigner le téléphone";
                          }
                          if (value.length < 8) {
                            return "Le téléphone doit avoir au moins 8 chiffres";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        cursorColor: Colors.grey,
                        controller: _idController,
                        decoration: const InputDecoration(
                          labelText: "ID Vitalia",
                          labelStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Veuillez renseigner l'ID Vitalia";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2196F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // coins légèrement arrondis
                            ),
                          ),
                          onPressed: _login,
                          child: const Text(
                            "Se connecter",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // ---- Section Vos avantages ----
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Vos avantages",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFBBDEFB), // bleu clair
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.medical_services, color: Color(0xFF2196F3)),
                      ),
                      title: const Text("Dossier médical numérique" ,style: TextStyle(fontWeight:FontWeight.w400),),
                      subtitle: Text('Accès sécurisé à votre historique',style: TextStyle(fontSize: 13),),
                    ),
                    SizedBox(height: 5,),
                    ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFC8E6C9), // vert clair
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.calendar_month_rounded, color: Color(0xFF4CAF50)),
                      ),
                      title: const Text("Prise de rendez-vous"),
                      subtitle: Text('Planifiez vos consultations en ligne',style: TextStyle(fontSize: 13),),
                    ),
                    SizedBox(height: 5,),
                    ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1BEE7), // violet clair
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FontAwesomeIcons.hospitalUser, color: Color(0xFF9C27B0)),
                      ),
                      title: const Text("Réseau de centres"),
                      subtitle: Text("Trouvez le centre le plus proche",style: TextStyle(fontSize: 13),),
                    ),
                  ],
                ),
              ),
          SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
