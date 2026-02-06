import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // بيانات تجريبية، لاحقًا تربطها مع Firebase
  List<Map<String, dynamic>> riders = [
    {"name": "محمد", "phone": "01000000001", "approved": false, "disabled": false},
    {"name": "أحمد", "phone": "01000000002", "approved": true, "disabled": false},
  ];

  List<Map<String, dynamic>> restaurants = [
    {"name": "مطعم بيتزا", "phone": "01000000003", "approved": false, "disabled": false},
    {"name": "مطعم برجر", "phone": "01000000004", "approved": true, "disabled": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة الإدارة"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "المندوبين",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...riders.map((rider) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(rider["name"]),
                    subtitle: Text("رقم الهاتف: ${rider["phone"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: rider["approved"],
                          onChanged: (val) {
                            setState(() {
                              rider["approved"] = val;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        IconButton(
                          icon: Icon(
                            rider["disabled"] ? Icons.block : Icons.check,
                            color: rider["disabled"] ? Colors.red : Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              rider["disabled"] = !rider["disabled"];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            const Text(
              "المطاعم",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...restaurants.map((rest) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.store),
                    title: Text(rest["name"]),
                    subtitle: Text("رقم الهاتف: ${rest["phone"]}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Switch(
                          value: rest["approved"],
                          onChanged: (val) {
                            setState(() {
                              rest["approved"] = val;
                            });
                          },
                          activeColor: Colors.green,
                        ),
                        IconButton(
                          icon: Icon(
                            rest["disabled"] ? Icons.block : Icons.check,
                            color: rest["disabled"] ? Colors.red : Colors.green,
                          ),
                          onPressed: () {
                            setState(() {
                              rest["disabled"] = !rest["disabled"];
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
