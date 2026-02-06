import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

// دوال مؤقتة بدل Firebase عشان الكود يشتغل على الكمبيوتر
Future<void> sendOTP(String phone) async {
  print("تم إرسال OTP إلى الرقم: $phone");
}

Future<void> registerClient(String phone, String name) async {
  print("تم تسجيل العميل: الاسم=$name، الهاتف=$phone");
}

Future<void> registerRiderOrRestaurant({
  required String phone,
  required String name,
  required String password,
  required String type,
  File? profileImage,
  File? idFront,
  File? idBack,
}) async {
  print("تم تسجيل $type: الاسم=$name، الهاتف=$phone، الباسورد=$password");
  if (profileImage != null) print("تم اختيار صورة شخصية");
  if (idFront != null) print("تم اختيار وجه البطاقة");
  if (idBack != null) print("تم اختيار ظهر البطاقة");
}

// شاشة التسجيل
class إنشاء حسابScreen extends StatefulWidget {
  const إنشاء حسابScreen({Key? key}) : super(key: key);

  @override
  State<إنشاء حسابScreen> createState() => _إنشاء حسابScreenState();
}

class _إنشاء حسابScreenState extends State<إنشاء حسابScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool acceptPrivacy = false;
  String userType = "client"; // client - rider - restaurant

  File? profileImage;
  File? idFrontImage;
  File? idBackImage;

  // دالة لاختيار صورة من المعرض
  Future<File?> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) return File(pickedFile.path);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تسجيل حساب جديد")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<String>(
                value: userType,
                items: const [
                  DropdownMenuItem(value: "client", child: Text("عميل")),
                  DropdownMenuItem(value: "rider", child: Text("مندوب")),
                  DropdownMenuItem(value: "restaurant", child: Text("مطعم / محل")),
                ],
                onChanged: (val) => setState(() => userType = val!),
                decoration: const InputDecoration(labelText: "نوع الحساب"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "الاسم الكامل"),
                validator: (v) => v == null || v.isEmpty ? "الرجاء إدخال الاسم" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(labelText: "رقم الهاتف"),
                validator: (v) => v == null || v.isEmpty ? "الرجاء إدخال رقم الهاتف" : null,
              ),
              const SizedBox(height: 10),
              if (userType != "client")
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "كلمة المرور"),
                  validator: (v) {
                    if (userType != "client" && (v == null || v.isEmpty)) return "الرجاء إدخال كلمة المرور";
                    return null;
                  },
                ),
              if (userType != "client") const SizedBox(height: 10),
              if (userType == "rider") ...[
                ElevatedButton(
                  onPressed: () async {
                    profileImage = await pickImage();
                    setState(() {});
                  },
                  child: Text(profileImage == null ? "اختر صورة شخصية" : "تم اختيار صورة شخصية"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    idFrontImage = await pickImage();
                    setState(() {});
                  },
                  child: Text(idFrontImage == null ? "اختر صورة بطاقة الرقم القومي - وجه" : "تم اختيار الوجه"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    idBackImage = await pickImage();
                    setState(() {});
                  },
                  child: Text(idBackImage == null ? "اختر صورة بطاقة الرقم القومي - ظهر" : "تم اختيار الظهر"),
                ),
                const SizedBox(height: 10),
              ],
              Row(
                children: [
                  Checkbox(
                    value: acceptPrivacy,
                    onChanged: (v) => setState(() => acceptPrivacy = v!),
                  ),
                  const Text("أوافق على سياسة الخصوصية"),
                ],
              ),
              const SizedBox(height: 10),
              if (userType == "client")
                ElevatedButton(
                  onPressed: () async {
                    if (phoneController.text.isNotEmpty) {
                      await sendOTP(phoneController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("تم إرسال OTP")),
                      );
                    }
                  },
                  child: const Text("إرسال OTP"),
                ),
              if (userType == "client") const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && acceptPrivacy) {
                    if (userType == "client") {
                      await registerClient(phoneController.text, nameController.text);
                    } else {
                      await registerRiderOrRestaurant(
                        phone: phoneController.text,
                        name: nameController.text,
                        password: passwordController.text,
                        type: userType,
                        profileImage: profileImage,
                        idFront: idFrontImage,
                        idBack: idBackImage,
                      );
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("تم التسجيل بنجاح")),
                    );
                  }
                },
                child: const Text("تسجيل"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
