import 'dart:math';
/*
Ce code permet de générer l'ID vitalia des patents .
*/

String generateVitaliaID(){
  final now = DateTime.now();
  int randomNumber = 1000 + Random().nextInt(9000);
  return "VIT-${now.year}-$randomNumber";
}

