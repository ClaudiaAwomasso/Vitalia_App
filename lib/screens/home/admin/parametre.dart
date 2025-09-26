import 'package:flutter/material.dart';

class ParametresSystemePage extends StatefulWidget {
  const ParametresSystemePage({Key? key}) : super(key: key);

  @override
  State<ParametresSystemePage> createState() => _ParametresSystemePageState();
}

class _ParametresSystemePageState extends State<ParametresSystemePage> {
  // Switch states
  bool notifNouveauxPatients = true;
  bool notifUrgences = true;
  bool notifMaintenance = false;
  bool notifRapports = true;

  bool modeMaintenance = false;
  bool sauvegardeAuto = true;
  bool journalisation = true;
  bool auth2FA = false;

  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paramètres système"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.save, size: 18),
              label: const Text("Sauvegarder"),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Informations système
          _buildSectionTitle("Informations système"),
          _buildInfoRow("Version Vitalia", "v2.1.4"),
          _buildInfoRow("Dernière mise à jour", "15/01/2024"),
          _buildInfoRow("Serveurs actifs", "3/3 opérationnels",
              valueColor: Colors.green),
          _buildInfoRow("Espace de stockage", "2.3 TB / 5 TB"),

          const SizedBox(height: 16),

          // Notifications administrateur
          _buildSectionTitle("Notifications administrateur"),
          _buildSwitchRow("Nouveaux patients", "Alerte lors d’inscriptions",
              notifNouveauxPatients, (val) {
                setState(() => notifNouveauxPatients = val);
              }),
          _buildSwitchRow("Urgences critiques", "Alerte immédiate pour urgences",
              notifUrgences, (val) {
                setState(() => notifUrgences = val);
              }),
          _buildSwitchRow("Maintenance centres", "Notifications de maintenance",
              notifMaintenance, (val) {
                setState(() => notifMaintenance = val);
              }),
          _buildSwitchRow("Rapports quotidiens",
              "Synthèse quotidienne des activités", notifRapports, (val) {
                setState(() => notifRapports = val);
              }),

          const SizedBox(height: 16),

          // Configuration système
          _buildSectionTitle("Configuration système"),
          _buildSwitchRow("Mode maintenance", "Maintenance programmée du système",
              modeMaintenance, (val) {
                setState(() => modeMaintenance = val);
              }),
          _buildSwitchRow("Sauvegarde automatique",
              "Sauvegarde quotidienne des données", sauvegardeAuto, (val) {
                setState(() => sauvegardeAuto = val);
              }),
          _buildSwitchRow("Journalisation",
              "Enregistrement des activités système", journalisation, (val) {
                setState(() => journalisation = val);
              }),
          _buildSwitchRow("Authentification 2FA",
              "Double authentification obligatoire", auth2FA, (val) {
                setState(() => auth2FA = val);
              }),

          const SizedBox(height: 16),

          // Actions d'administration
          _buildSectionTitle("Actions d’administration"),
          _buildActionButton(Icons.download, "Exporter toutes les données",
              Colors.blue[50]!, Colors.blue),
          _buildActionButton(Icons.restart_alt, "Redémarrer les services",
              Colors.green[50]!, Colors.green),
          _buildActionButton(Icons.list_alt, "Consulter les logs système",
              Colors.red[50]!, Colors.red),

          const SizedBox(height: 16),

          // Service client
          _buildSectionTitle("Service client"),
          const Text(
            "Besoin d’aide ou d’assistance ?",
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            icon: const Icon(Icons.support_agent),
            label: const Text("Contacter le service client"),
            onPressed: () {
              // 👉 Ici tu peux ajouter ouverture d'email, chat ou popup
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Ouverture du support client..."),
                ),
              );
            },
          ),
        ],
      ),

      // Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: "Tableau de bord",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital_outlined),
            label: "Centres",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: "Utilisateurs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: "Paramètres",
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: valueColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchRow(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      value: value,
      activeColor: Colors.blue,
      onChanged: onChanged,
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color bgColor, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          backgroundColor: bgColor,
          foregroundColor: iconColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        icon: Icon(icon, color: iconColor),
        label: Text(label, style: TextStyle(color: iconColor)),
        onPressed: () {},
      ),
    );
  }
}
