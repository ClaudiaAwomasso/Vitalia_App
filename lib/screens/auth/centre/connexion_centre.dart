  import 'package:flutter/material.dart';
  import '../../../modeles/centre_model.dart';
  import '../../../services/firebase_auth_service.dart';
  import '../../home/centre/centre_home.dart';

  class ConnexionCentrePage extends StatefulWidget {
    const ConnexionCentrePage({super.key});

    @override
    State<ConnexionCentrePage> createState() => _ConnexionCentrePageState();
  }

  class _ConnexionCentrePageState extends State<ConnexionCentrePage> {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final FirebaseService _firebaseService = FirebaseService();
    bool _loading = false;
    bool showPassword = false;

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: const Text("Connexion Centre")),
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
                  'Interface professionnelle de santé',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Email
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(color:Colors.black),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (val) =>
                          val!.isEmpty ? "Entrez votre email" : null,
                        ),
                        const SizedBox(height: 12),

                        // Mot de passe
                        TextFormField(
                          cursorColor: Colors.black,
                          controller: _passwordController,
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            labelText: "Mot de passe",

                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue, width: 2), // contour quand on clique
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() => showPassword = !showPassword);
                              },
                            ),
                          ),
                          validator: (val) =>
                          val!.isEmpty ? "Entrez votre mot de passe" : null,
                        ),
                        const SizedBox(height: 20),

                        _loading
                            ? const CircularProgressIndicator()
                            : SizedBox(
                          width: double.infinity,
                          height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2196F3),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8), // coins légèrement arrondis
                                  ),),
                                onPressed: () async {
                              if (!_formKey.currentState!.validate()) return;

                              setState(() => _loading = true);

                              try {
                                // Connexion et récupération du CentreModel
                                CentreModel? centre = await _firebaseService.loginCentre(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );

                                if (centre != null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Connexion réussie")),
                                  );

                                  // Navigation vers HomeCentre
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CentreHome(),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Aucun centre trouvé")),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Erreur: $e")),
                                );
                              } finally {
                                setState(() => _loading = false);
                              }
                              },
                                child: const Text("Se connecter", style: TextStyle(color: Colors.white),),
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
                          child: const Icon(Icons.person_outline, color: Color(0xFF2196F3)),
                        ),
                        title: const Text("Gestion des patients" ,style: TextStyle(fontWeight:FontWeight.w400),),
                        subtitle: Text('Dossiers médicaux sécurisés',style: TextStyle(fontSize: 13),),
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
                        title: const Text("Planning intégré"),
                        subtitle: Text('Consultations et rendez-vous',style: TextStyle(fontSize: 13),),
                      ),
                      SizedBox(height: 5,),
                      ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFCDD2), // violet clair
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.local_hospital, color: Color(
                              0xFFE61010)),
                        ),
                        title: const Text("Gestion des urgences"),
                        subtitle: Text("Système d'alerte prioritaire",style: TextStyle(fontSize: 13),),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
