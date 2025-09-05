import 'package:flutter/material.dart';
import 'package:vitalia_app/modeles/consultation_model.dart';
import 'package:vitalia_app/services/firestore_service.dart';

class CentreAddConsultationPage extends StatefulWidget {
  final String patientId; // ID Firestore du patient

  const CentreAddConsultationPage({super.key, required this.patientId});

  @override
  State<CentreAddConsultationPage> createState() =>
      _CentreAddConsultationPageState();
}

class _CentreAddConsultationPageState extends State<CentreAddConsultationPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _medecinController = TextEditingController();
  final TextEditingController _lieuController = TextEditingController();
  final TextEditingController _diagnosticController = TextEditingController();
  DateTime? _selectedDate;

  List<Traitement> traitements = [];
  List<Ordonnance> ordonnances = [];

  final TextEditingController _medicamentController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _frequenceController = TextEditingController();

  final TextEditingController _ordMedController = TextEditingController();
  final TextEditingController _ordDateController = TextEditingController();

  final FirestoreService _firestoreService = FirestoreService();

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _addTraitement() {
    if (_medicamentController.text.isNotEmpty &&
        _dosageController.text.isNotEmpty &&
        _frequenceController.text.isNotEmpty) {
      setState(() {
        traitements.add(Traitement(
          medicament: _medicamentController.text,
          dosage: _dosageController.text,
          frequence: _frequenceController.text,
        ));
        _medicamentController.clear();
        _dosageController.clear();
        _frequenceController.clear();
      });
    }
  }

  void _addOrdonnance() {
    if (_ordMedController.text.isNotEmpty && _ordDateController.text.isNotEmpty) {
      setState(() {
        ordonnances.add(Ordonnance(
          medicaments: _ordMedController.text,
          date: _ordDateController.text,
        ));
        _ordMedController.clear();
        _ordDateController.clear();
      });
    }
  }

  void _submit() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final consultation = ConsultationModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        titre: _titreController.text,
        medecin: _medecinController.text,
        lieu: _lieuController.text,
        date: _selectedDate!,
        diagnostic: _diagnosticController.text,
        traitements: traitements,
        ordonnances: ordonnances,
      );

      // 🔹 Ici on ajoute dans la sous-collection 'consultations'
      await _firestoreService.addConsultation(widget.patientId as String, consultation);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Consultation ajoutée avec succès !')),
      );

      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez remplir tous les champs.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter Consultation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titreController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) =>
                value!.isEmpty ? 'Veuillez entrer un titre' : null,
              ),
              TextFormField(
                controller: _medecinController,
                decoration: const InputDecoration(labelText: 'Médecin'),
                validator: (value) =>
                value!.isEmpty ? 'Veuillez entrer le médecin' : null,
              ),
              TextFormField(
                controller: _lieuController,
                decoration: const InputDecoration(labelText: 'Lieu'),
                validator: (value) =>
                value!.isEmpty ? 'Veuillez entrer le lieu' : null,
              ),
              TextFormField(
                controller: _diagnosticController,
                decoration: const InputDecoration(labelText: 'Diagnostic'),
                validator: (value) =>
                value!.isEmpty ? 'Veuillez entrer le diagnostic' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Aucune date sélectionnée'
                          : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _pickDate(context),
                    child: const Text('Choisir la date'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Traitements', style: TextStyle(fontWeight: FontWeight.bold)),
              ...traitements.map((t) => ListTile(
                title: Text(t.medicament),
                subtitle: Text('${t.dosage} - ${t.frequence}'),
              )),
              TextFormField(
                controller: _medicamentController,
                decoration: const InputDecoration(labelText: 'Médicament'),
              ),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(labelText: 'Dosage'),
              ),
              TextFormField(
                controller: _frequenceController,
                decoration: const InputDecoration(labelText: 'Fréquence'),
              ),
              ElevatedButton(onPressed: _addTraitement, child: const Text('Ajouter Traitement')),
              const SizedBox(height: 16),
              const Text('Ordonnances', style: TextStyle(fontWeight: FontWeight.bold)),
              ...ordonnances.map((o) => ListTile(
                title: Text(o.medicaments),
                subtitle: Text(o.date),
              )),
              TextFormField(
                controller: _ordMedController,
                decoration: const InputDecoration(labelText: 'Médicaments'),
              ),
              TextFormField(
                controller: _ordDateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              ElevatedButton(onPressed: _addOrdonnance, child: const Text('Ajouter Ordonnance')),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: const Text('Ajouter Consultation')),
            ],
          ),
        ),
      ),
    );
  }
}
