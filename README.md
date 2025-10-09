# VITALIA

## Présentation du projet
VITALIA est un carnet de santé numérique communautaire disponible sur Mobile.  
L'application permet aux centres de santé d'accéder à l'historique médical des patients où qu'ils se trouvent, afin d'améliorer :

- La continuité des soins
- La rapidité de prise en charge
- La fiabilité des diagnostics

### Public cible
- Centres de santé publics et privés
- Patients (urbains & ruraux)
- Administrateurs du système de santé

## Profils utilisateurs
1. *Patient
    - Connexion via téléphone + ID Vitalia
    - Consultation de l’historique des consultations, traitements en cours et ordonnances
    - Liste des rendez-vous à venir ou passés
    - Profil personnel (nom, téléphone, photo, contact d'urgence)
    - Liste publique des centres de santé

2. Centre de santé
    - Connexion via identifiants fournis par l’admin
    - Ajouter une consultation : diagnostic, traitement et ordonnance
    - Planification et suivi des rendez-vous
    - Historique des dossiers patients
    - Profil du centre

3. Administrateur
    - Création des comptes patients et centres de santé
    - Liste des utilisateurs
    - Supervision générale (optionnelle, statique ou simulée)

## Objectif de l’application
Fournir un accès sécurisé et centralisé aux dossiers médicaux pour faciliter la gestion des soins et améliorer la qualité du suivi médical.


## Dépendances utilisées dans le projet
flutter (SDK principal Flutter)

cupertino_icons (^1.0.8) : Icônes iOS pour l’interface

firebase_core (^4.0.0) : Initialisation et connexion à Firebase

cloud_firestore (^6.0.0) : Stockage et lecture des données Firestore

firebase_auth (^6.1.0) : Gestion de l’authentification des utilisateurs

firebase_storage (^13.0.0) : Stockage des fichiers (images, documents) sur Firebase

provider (^6.1.5+1) : Gestion de l’état de l’application

image_picker (^1.2.0) : Sélection et capture d’images depuis la galerie ou la caméra

flutter_localization (^0.3.3) : Support multilingue / localisation

flutter_launcher_icons (^0.14.4) : Configuration et génération de l’icône de l’application

font_awesome_flutter (^10.9.1) : Icônes supplémentaires pour l’interface


## Installation et exécution
### Commandes à exécuter

```bash
# Cloner le projet
git clone <URL_DU_REPO>

# Aller dans le dossier du projet
cd vitalia_app

# Installer les dépendances
flutter pub get

# Lancer l'application
flutter run

