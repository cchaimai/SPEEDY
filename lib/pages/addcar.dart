import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/pages/mycar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import '../widgets/widgets.dart';

class addCarScreen extends StatefulWidget {
  const addCarScreen({super.key});

  @override
  State<addCarScreen> createState() => _addCarScreenState();
}

class _addCarScreenState extends State<addCarScreen> {
  String? _selectedProvince;
  String? _selectedYear;
  String? _selectedChargeType;
  String? _selectedBattery;

  final brandController = TextEditingController();
  final modelController = TextEditingController();
  final carIdController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    brandController.dispose();
    modelController.dispose();
    carIdController.dispose();
  }

  static const List<String> years = [
    '2566',
    '2565',
    '2564',
    '2563',
    '2562',
    '2561',
    '2560',
    '2559',
    '2558',
    '2557',
    '2556',
    '2555',
  ];

  static const List<String> chargeType = [
    'Type1',
    'Type2',
    'GB/T',
    'CHAdeMO',
    'CCS-Type1',
    'CCS-Type2',
  ];

  static const List<String> batterySizes = [
    '90',
    '85',
    '80',
    '75',
    '70',
    '65',
    '60',
    '55',
    '50',
    '45',
    '40',
    '35',
  ];

  static const List<String> provinces = [
    'กระบี่',
    'กรุงเทพมหานคร',
    'กาญจนบุรี',
    'กาฬสินธุ์',
    'กำแพงเพชร',
    'ขอนแก่น',
    'จันทบุรี',
    'ฉะเชิงเทรา',
    'ชลบุรี',
    'ชัยนาท',
    'ชัยภูมิ',
    'ชุมพร',
    'เชียงราย',
    'เชียงใหม่',
    'ตรัง',
    'ตราด',
    'ตาก',
    'นครนายก',
    'นครปฐม',
    'นครพนม',
    'นครราชสีมา',
    'นครศรีธรรมราช',
    'นครสวรรค์',
    'นนทบุรี',
    'นราธิวาส',
    'น่าน',
    'บึงกาฬ',
    'บุรีรัมย์',
    'ปทุมธานี',
    'ประจวบคีรีขันธ์',
    'ปราจีนบุรี',
    'ปัตตานี',
    'พระนครศรีอยุธยา',
    'พังงา',
    'พัทลุง',
    'พิจิตร',
    'พิษณุโลก',
    'เพชรบุรี',
    'เพชรบูรณ์',
    'แพร่',
    'ภูเก็ต',
    'มหาสารคาม',
    'มุกดาหาร',
    'แม่ฮ่องสอน',
    'ยโสธร',
    'ยะลา',
    'ร้อยเอ็ด',
    'ระนอง',
    'ระยอง',
    'ราชบุรี',
    'ลพบุรี',
    'ลำปาง',
    'ลำพูน',
    'เลย',
    'ศรีสะเกษ',
    'สกลนคร',
    'สงขลา',
    'สตูล',
    'สมุทรปราการ',
    'สมุทรสงคราม',
    'สมุทรสาคร',
    'สระแก้ว',
    'สระบุรี',
    'สิงห์บุรี',
    'สุโขทัย',
    'สุพรรณบุรี',
    'สุราษฎร์ธานี',
    'สุรินทร์',
    'หนองคาย',
    'หนองบัวลำภู',
    'อ่างทอง',
    'อุดรธานี',
    'อุทัยธานี',
    'อุตรดิตถ์',
    'อุบลราชธานี',
    'อำนาจเจริญ'
  ];

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthService>(context, listen: true).isLoading;
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const myCarScreen()),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "เพิ่มรถ",
          style: GoogleFonts.prompt(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(23),
                bottomRight: Radius.circular(23)),
            color: Color.fromARGB(255, 31, 31, 31),
          ),
        ),
      ),
      body: SafeArea(
          child: isLoading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, right: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'ข้อมูลรถยนต์',
                              style: GoogleFonts.prompt(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'ยี่ห้อรถยนต์',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          cursorColor: Colors.green,
                          controller: brandController,
                          decoration: InputDecoration(
                            labelText: 'Brand',
                            labelStyle: GoogleFonts.prompt(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'รุ่นรถยนต์',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          cursorColor: Colors.green,
                          controller: modelController,
                          decoration: InputDecoration(
                            labelText: 'Model',
                            labelStyle: GoogleFonts.prompt(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'ทะเบียนรถ',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: carIdController,
                          cursorColor: Colors.green,
                          decoration: InputDecoration(
                            labelText: 'AB1234',
                            labelStyle: GoogleFonts.prompt(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'จังหวัด',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Province',
                            labelStyle: GoogleFonts.prompt(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          value: _selectedProvince,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedProvince = newValue;
                            });
                            print(_selectedProvince);
                          },
                          items: provinces
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'ปีของยานพาหนะ',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Year',
                            labelStyle: GoogleFonts.prompt(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          value: _selectedYear,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedYear = newValue;
                            });
                            print(_selectedYear);
                          },
                          items: years
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Text(
                              'ข้อมูลการชาร์จ',
                              style: GoogleFonts.prompt(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          thickness: 2,
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'หัวชาร์จ',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Select charge type',
                            labelStyle: GoogleFonts.prompt(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          value: _selectedChargeType,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedChargeType = newValue;
                            });
                            print(_selectedChargeType);
                          },
                          items: chargeType
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              'ขนาดเเบตเตอรี่  (kWh)',
                              style: GoogleFonts.prompt(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: 'Select battery size',
                            labelStyle: GoogleFonts.prompt(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          value: _selectedBattery,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedBattery = newValue;
                            });
                            print(_selectedBattery);
                          },
                          items: batterySizes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            saveToFirebase();
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30),
                                  border:
                                      Border.all(width: 1, color: Colors.grey),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ถัดไป ',
                                      style: GoogleFonts.prompt(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                )),
      floatingActionButton: Container(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () async {},
            child: const Icon(
              Icons.bolt,
              size: 35,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color.fromARGB(255, 31, 31, 31),
        notchMargin: 5,
        child: Container(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.house_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'หน้าหลัก',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.fact_check_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เช็ค',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Charge',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: 17),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.change_circle_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เปลี่ยน',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  print("kuy peng na hee");
                },
                child: Container(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.account_circle_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'โปรไฟล์',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveToFirebase() async {
    User user = FirebaseAuth.instance.currentUser!;

    String carId = carIdController.text.trim();
    String brand = brandController.text.trim();
    String model = modelController.text.trim();
    String provinces = _selectedProvince.toString();
    String chargeType = _selectedChargeType.toString();
    String battery = _selectedBattery.toString();
    String year = _selectedYear.toString();
    String owner = user.uid;

    await FirebaseFirestore.instance.collection('car').doc().get().then((doc) {
      if (doc.exists) {
        // เจอเอกสารที่ค้นหา ทำการอัปเดตข้อมูลได้
        FirebaseFirestore.instance.collection('car').doc().update({
          'owner': owner,
          'carId': carId,
          'brand': brand,
          'model': model,
          'provinces': provinces,
          'chargeType': chargeType,
          'battery': battery,
          'year': year,
        });
      } else {
        // ไม่เจอเอกสารที่ค้นหา สร้างเอกสารใหม่
        FirebaseFirestore.instance.collection('car').doc().set({
          'owner': owner,
          'carId': carId,
          'brand': brand,
          'model': model,
          'provinces': provinces,
          'chargeType': chargeType,
          'battery': battery,
          'year': year,
        });
      }
    });
  }
}
