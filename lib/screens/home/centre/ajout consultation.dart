import 'package:flutter/material.dart';

 class AjoutConsultation extends StatelessWidget {
   const AjoutConsultation({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(backgroundColor: Colors.white,),
       body: SingleChildScrollView(
         child: Padding(
           padding: const EdgeInsets.all(10),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               ListTile(
                 leading: Icon(Icons.person_outline, color: Colors.blue,),
                 title: Text("Sélection du patient"),
                 subtitle: Text("Recherchez et sélectionnez le patient pour cette consultation"),
               ),
               SizedBox(height: 12,),
               Text("Recherche patient",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
               SizedBox(height: 10,),
               TextField(
                 cursorColor: Colors.grey,
                 decoration: InputDecoration(
                   hintText: "Nom, Téléphone  ou ID Vitalia ",
                   prefixIcon: const Icon(Icons.search, color: Colors.grey),
                   filled: true,
                   fillColor: Colors.white,
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(color: Colors.grey),
                   ),
                   focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(color: Colors.grey)
                   )
                 ),
               ),
               SizedBox(height: 13,),
               Text('Détails de consultation',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.blue),),
               Text('Saisissez le diagnostic et le traitement prescrit'),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   const SizedBox(height: 10),
                   const Text('Diagnostic', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 10),
                   const TextField(
                     maxLines: 4,
                     minLines: 3,
                     decoration: InputDecoration(
                       labelText: "Diagnostic ...",
                         labelStyle: TextStyle(
                           color: Colors.grey,
                         ),
                       border: OutlineInputBorder(),
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.grey)
                         )
                     ),
                   ),
                 ],
               ),
               const SizedBox(width: 10),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   SizedBox(height:5,),
                   const Text('Traitement', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                   const SizedBox(height: 15),
                   const TextField(
                     cursorColor: Colors.grey,
                     maxLines: 4,
                     minLines: 3,
                     decoration: InputDecoration(
                       labelText: "Traitement ",
                         labelStyle: TextStyle(
                           color: Colors.grey,
                         ),
                       border: OutlineInputBorder(),
                         focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.grey)
                         )
                     ),
                   ),
                 ],
               ),
               SizedBox(height: 10,),
               Text('Notes complémentaires',style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
               TextField(
                 cursorColor: Colors.grey,
                 maxLines: 6,
                 minLines: 3,
                 decoration: InputDecoration(
                   labelText: "Observations, recommandations",
                     labelStyle: TextStyle(
                       color: Colors.grey,
                     ),
                   border: OutlineInputBorder(),
                     focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     )
                 ),
               ),
               SizedBox(height: 10,),
               Text("Ordonnance",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.blue),),
               Text("Médicaments et posologie prescrits"),
               SizedBox(height: 10,),
               Text("Prescription",style: TextStyle(fontWeight: FontWeight.bold),),
               SizedBox(height: 7,),
               TextField(
                 cursorColor: Colors.grey,
                 maxLines: 6,
                 minLines: 3,
                 decoration: InputDecoration(
                     labelText: "Observations, recommandations",
                     labelStyle: TextStyle(
                       color: Colors.grey,
                     ),
                     border: OutlineInputBorder(),
                     focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(color: Colors.grey)
                     )
                 ),
               ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                        onPressed: (){},
                        child: Text("Entregistrer la consultation")
                    ),
                    ElevatedButton(onPressed: (){},
                        child: Text("Annuler",style: TextStyle(color: Colors.black),)
                    ),
                    SizedBox(height: 10,)
                  ],
                )
               
             ],
           ),
         ),
       ),
     );

   }
 }
 