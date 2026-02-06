import 'package:flutter/material.dart';
import '../assistantMethods/sos_service.dart';

class SOSScreen extends StatelessWidget {
  final String riderId;

  const SOSScreen({required this.riderId, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("زر الطوارئ")),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.all(30),
          ),
          onPressed: () {
            sendSOS(riderId);
          },
          child: const Text(
            "🚨 طلب مساعدة",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
