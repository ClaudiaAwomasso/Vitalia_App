
import 'package:flutter/material.dart';


class WelcomeScreens extends StatelessWidget {
  const WelcomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color(0xFFF1F7FE),
      ) ,
      backgroundColor: Color(0xFFF1F7FE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Center(child: Image(image: AssetImage("assets/images/logotransparent.png"), width: 200, )),
            Padding(
              padding: const EdgeInsets.all(8.0),
        
              child: SizedBox(
                  height: 20,
                  child: Text('Votre plateforme médicale connectée ',) ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20
                  ),
                  child: Image(image: AssetImage("assets/images/medecin.jpg"),)),
            ),
            Text('Choisissez votre profil', style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1, // étendue
                        blurRadius: 3,   // flou
                        offset: Offset(5, 5,), // position de l'ombre (x, y)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Container(
                  width: 70,
                      height: 120,
                      decoration: BoxDecoration(
                        color: Color(0xB0D2E6FD),
                        borderRadius: BorderRadius.circular(15)
                      ),

                      child: Icon(Icons.person_outline_rounded, color: Colors.blue,),),
                  title:Text('Patient', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text("Connectez-vous pour accéder à votre dossier médical et prenez rendez-vous. "),
                  trailing: Icon(Icons.arrow_forward_outlined),



                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1, // étendue
                        blurRadius: 3,   // flou
                        offset: Offset(5, 5,), // position de l'ombre (x, y)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Container(
                    width: 70,
                    height: 120,
                    decoration: BoxDecoration(
                        color: Color(0xFFC7E3CC),
                        borderRadius: BorderRadius.circular(15)
                    ),

                    child: Icon(Icons.medical_services, color: Colors.green,),),
                  title:Text('Centre de santé', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text("Interface médecin,gestion des patents et consultation.",  ),
                  trailing: Icon(Icons.arrow_forward_outlined),



                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1, // étendue
                        blurRadius: 3,   // flou
                        offset: Offset(5, 5,), // position de l'ombre (x, y)
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  leading: Container(
                    width: 70,
                    height: 120,
                    decoration: BoxDecoration(
                        color:Color(0xA6E9DDFB),
                        borderRadius: BorderRadius.circular(15)
                    ),

                    child: Icon(Icons.lock_person_outlined, color: Colors.deepPurple,),),
                  title:Text('Administration', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  subtitle: Text(
                    softWrap: true,
                      "Gestion du système,centres de santé et utilisateurs" ),
                  trailing: Icon(Icons.arrow_forward_outlined),



                ),
              ),
            ),

          ],
        ),
      ),
    );

  }
}
