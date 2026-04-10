import 'package:flutter/material.dart';

void main() => runApp(
  const MaterialApp(home: FirstPage(), debugShowCheckedModeBanner: false),
);

class User {
  final String name;
  final String age;
  final String genre;
  final List<String> interests;
  final double skill;
  final String formation;

  User(
    this.name,
    this.age,
    this.genre,
    this.interests,
    this.skill,
    this.formation,
  );
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _genre = "Homme";
  final Map<String, bool> _interests = {
    "Codage": false,
    "Design": false,
    "Gaming": false,
  };
  double _skillLevel = 0.0;
  String _formation = "Informatique";

  List<User> userList = [];

  void _addUser() {
    if (_nameController.text.isEmpty || _ageController.text.isEmpty) return;

    setState(() {
      userList.add(
        User(
          _nameController.text,
          _ageController.text,
          _genre!,
          _interests.entries.where((e) => e.value).map((e) => e.key).toList(),
          _skillLevel,
          _formation,
        ),
      );

      _nameController.clear();
      _ageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("First Page"),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saisir votre nom",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: "Entrez votre nom",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Saisir votre Age",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "Entrez votre Age",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Genre :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio<String>(
                  value: "Homme",
                  groupValue: _genre,
                  onChanged: (v) => setState(() => _genre = v),
                ),
                const Text("Homme"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Femme",
                  groupValue: _genre,
                  onChanged: (v) => setState(() => _genre = v),
                ),
                const Text("Femme"),
              ],
            ),
            const SizedBox(height: 15),
            const Text(
              "Centre d'interet :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ..._interests.keys.map((String key) {
              return CheckboxListTile(
                title: Text(key),
                value: _interests[key],
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                onChanged: (bool? value) =>
                    setState(() => _interests[key] = value!),
              );
            }).toList(),
            const Text(
              "Niveau en programmation :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Slider(
              value: _skillLevel,
              max: 100,
              divisions: 10,
              label: _skillLevel.round().toString(),
              onChanged: (double value) => setState(() => _skillLevel = value),
            ),
            const SizedBox(height: 15),
            const Text(
              "Formation :",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _formation,
              isExpanded: true,
              items: [
                'Informatique',
                'Gestion',
                'Marketing',
                'Design',
              ].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
              onChanged: (v) => setState(() => _formation = v!),
            ),
            const SizedBox(height: 25),

            // BUTTON VALIDATE
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _addUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[400],
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "VALIDER ET AJOUTER",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 30),
            const Divider(thickness: 2),
            const Text(
              "Liste des utilisateurs ajoutés:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // LIST T-TA7T MN L-BUTTON
            ListView.builder(
              shrinkWrap: true, // Daroriya mli koun ListView west Column
              physics:
                  const NeverScrollableScrollPhysics(), // Bach may-kounch sda3 m3a SingleChildScrollView
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(userList[index].name),
                    subtitle: Text("Age: ${userList[index].age}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailsPage(user: userList[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  final User user;
  const DetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background khedam b-light grey bach l-cards y-bano mzyan
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile Details",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- Top Profile Header ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: user.genre == "Homme"
                        ? Colors.blue[50]
                        : Colors.pink[50],
                    child: Icon(
                      user.genre == "Homme" ? Icons.male : Icons.female,
                      size: 50,
                      color: user.genre == "Homme" ? Colors.blue : Colors.pink,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    user.formation,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // --- Info Section ---
            _buildInfoCard(Icons.cake, "Age", "${user.age} Years Old"),
            _buildInfoCard(Icons.wc, "Genre", user.genre),
            _buildInfoCard(Icons.school, "Specialty", user.formation),

            const SizedBox(height: 15),

            // --- Interests Section ---
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.favorite, color: Colors.redAccent, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Interests",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: user.interests
                        .map(
                          (interest) => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.blue[100]!),
                            ),
                            child: Text(
                              interest,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function bach n-bniw ay line dyal l-ma3loumat
  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue[700], size: 24),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF334155),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
