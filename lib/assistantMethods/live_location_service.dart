import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LiveLocationService
{
  // تحديث موقع المندوب في Firebase كل 5 ثواني
  void startLiveLocation(String riderId)
  {
    Geolocator.getPositionStream(
      locationالإعدادات: const Locationالإعدادات(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position)
    {
      FirebaseFirestore.instance.collection("riders")
          .doc(riderId)
          .update({
        "lat": position.latitude,
        "lng": position.longitude,
        "lastUpdated": DateTime.now().toString(),
      });

      print("📍 Location Updated: ${position.latitude}, ${position.longitude}");
    });
  }
}
