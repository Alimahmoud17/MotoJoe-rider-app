import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final DatabaseReference clientsRef = FirebaseDatabase.instance.ref('clients');
  final DatabaseReference ridersRef = FirebaseDatabase.instance.ref('riders');
  final DatabaseReference restaurantsRef = FirebaseDatabase.instance.ref('restaurants');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة الإدارة'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildSection('العملاء', clientsRef),
            _buildSection('المندوبين', ridersRef),
            _buildSection('المطاعم', restaurantsRef),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, DatabaseReference ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              final usersMap = (snapshot.data as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>?;

              if (usersMap == null) return const Text('لا يوجد بيانات');

              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: usersMap.entries.map((entry) {
                  final key = entry.key;
                  final data = entry.value as Map;
                  bool approved = data['approved'] ?? true;
                  bool disabled = data['disabled'] ?? false;

                  return Card(
                    child: ListTile(
                      title: Text(data['name'] ?? 'بدون اسم'),
                      subtitle: Text('رقم الهاتف: ${data['phone']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (data.containsKey('approved'))
                            IconButton(
                              icon: Icon(
                                approved ? Icons.check_circle : Icons.pending,
                                color: approved ? Colors.green : Colors.orange,
                              ),
                              onPressed: () {
                                ref.child(key).update({'approved': !approved});
                              },
                            ),
                          IconButton(
                            icon: Icon(disabled ? Icons.lock : Icons.lock_open, color: disabled ? Colors.red : Colors.green),
                            onPressed: () {
                              ref.child(key).update({'disabled': !disabled});
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
