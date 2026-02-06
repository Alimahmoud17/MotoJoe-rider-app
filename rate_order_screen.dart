import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RateOrderScreen extends StatefulWidget {
  final String orderId;
  const RateOrderScreen({required this.orderId, super.key});

  @override
  State<RateOrderScreen> createState() => _RateOrderScreenState();
}

class _RateOrderScreenState extends State<RateOrderScreen> {
  double rating = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentRating();
  }

  Future<void> _loadCurrentRating() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection("orders")
          .doc(widget.orderId)
          .get();
      if (doc.exists && doc['rating'] != null) {
        setState(() => rating = doc['rating'].toDouble());
      }
    } catch (e) {
      print("خطأ: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> submitRating(String orderId, double rating) async {
    await FirebaseFirestore.instance.collection("orders").doc(orderId).update({
      "rating": rating,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("تقييم الطلب")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("اختر تقييمك:"),
                  Slider(
                    value: rating,
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: rating.toString(),
                    onChanged: (val) => setState(() => rating = val),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await submitRating(widget.orderId, rating);
                      Navigator.pop(context);
                    },
                    child: Text("إرسال التقييم"),
                  ),
                ],
              ),
            ),
    );
  }
}
