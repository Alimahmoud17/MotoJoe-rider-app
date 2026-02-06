import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

Future<void> sendSOS(String riderId) async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    await FirebaseFirestore.instance.collection("SOS").add({
      "riderId": riderId,
      "lat": position.latitude,
      "lng": position.longitude,
      "time": DateTime.now().toString(),
      "status": "emergency",
    });

    print("🚨 SOS Sent Successfully");
  } catch (e) {
    print("❌ SOS Error: $e");
  }
}
