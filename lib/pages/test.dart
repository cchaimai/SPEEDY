// ignore_for_file: unused_import

import 'package:chat_test/pages/confirm_check.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_core/firebase_core.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../widgets/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'home_page.dart';

class testPage extends StatefulWidget {
  const testPage({Key? key}) : super(key: key);

  @override
  State<testPage> createState() => _testPageState();
}

// ignore: camel_case_types
class _testPageState extends State<testPage> {
  final userId = FirebaseAuth.instance.currentUser!.uid;
  AuthService authService = AuthService();
  bool _isLoading = false;

  final formkey = GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection("events");

  DateTime _focusedDay = DateTime.now();
  final DateTime _firstDay =
      DateTime.now().subtract(const Duration(days: 1000));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 1000));
  late DateTime _selectedDay;

  String model = "";
  String carId = "";
  bool public = false;
  late DateTime date;

  @override
  initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const HomePage()),
          icon: const Icon(Icons.arrow_back),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "จองคิวเช็คสภาพแบตเตอรี่",
          style: GoogleFonts.prompt(fontSize: 20, fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.green,
                  child: Center(
                    child: Text(
                      "ปฎิทิน",
                      style: GoogleFonts.prompt(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
            Card(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 40,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: ((day) => isSameDay(day, _selectedDay)),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                focusedDay: _focusedDay,
                firstDay: _firstDay,
                lastDay: _lastDay,
                weekendDays: const [6, 7],
                calendarStyle: const CalendarStyle(
                    isTodayHighlighted: true,
                    todayDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 31, 31, 31),
                        shape: BoxShape.circle),
                    selectedDecoration: BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    weekendTextStyle: TextStyle(color: Colors.red)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: 150,
                child: GestureDetector(
                  onTap: () {
                    //nextScreenReplace(context, const addEvent());
                    popUpDialog(context);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: Colors.green,
                    child: Center(
                        child: Text(
                      "Press",
                      style: GoogleFonts.prompt(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 70,
        width: 70,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: () {},
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
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 10,
                    onPressed: () {
                      setState(() {
                        // currentScreen = Dashbord();
                        // currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            nextScreenReplace(context, const HomePage());
                          },
                          child: const Icon(
                            Icons.house,
                            color: Colors.green,
                          ),
                        ),
                        Text(
                          'หน้าหลัก',
                          style: GoogleFonts.prompt(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.task,
                          color: Colors.green,
                        ),
                        Text(
                          'เช็ค',
                          style: GoogleFonts.prompt(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.change_circle,
                          color: Colors.green,
                        ),
                        Text(
                          'เปลี่ยน',
                          style: GoogleFonts.prompt(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.account_circle,
                          color: Colors.green,
                        ),
                        Text(
                          'โปรไฟล์',
                          style: GoogleFonts.prompt(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 100),
                child: AlertDialog(
                  title: Text(
                    "book your appointment!",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.prompt(),
                  ),
                  content: FormBuilder(
                      child: Column(
                    children: [
                      FormBuilderTextField(
                        name: "model",
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.directions_car,
                              color: Colors.green),
                          border: InputBorder.none,
                          hintText: "รุ่นรถยนต์",
                          hintStyle: GoogleFonts.prompt(fontSize: 16),
                        ),
                        onSaved: (val) {
                          model = val!;
                        },
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return "กรอกรุ่นรถ";
                          }
                        },
                      ),
                      const Divider(),
                      FormBuilderTextField(
                        name: "carId",
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "ทะเบียนรถ",
                          hintStyle: GoogleFonts.prompt(fontSize: 16),
                          prefixIcon:
                              const Icon(Icons.wysiwyg, color: Colors.green),
                        ),
                        onSaved: (val) {
                          carId = val!;
                        },
                        validator: (val) {
                          if (val!.isNotEmpty) {
                            return null;
                          } else {
                            return "กรอกทะเบียนรถ";
                          }
                        },
                      ),
                      const Divider(),
                      FormBuilderDropdown(
                        name: 'time',
                        // ignore: deprecated_member_use
                        hint: Text(
                          'เลือกเวลา',
                          style: GoogleFonts.prompt(fontSize: 16),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.book,
                            color: Colors.green,
                          ),
                        ),
                        // ignore: deprecated_member_use
                        allowClear: true,
                        items: ['9:00', '11:00', '13:00', '15:00', '17:00']
                            .map((service) => DropdownMenuItem(
                                  value: service,
                                  child: Text(service),
                                ))
                            .toList(),
                        style: GoogleFonts.prompt(color: Colors.black),
                      ),
                      FormBuilderSwitch(
                        name: "public",
                        title: const Text("public"),
                        initialValue: false,
                        controlAffinity: ListTileControlAffinity.leading,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                        onSaved: (val) {
                          public = val!;
                        },
                      ),
                      const Divider(),
                      FormBuilderDateTimePicker(
                        name: "date",
                        initialValue: _selectedDay,
                        initialDate: _selectedDay,
                        fieldHintText: "Add Date",
                        inputType: InputType.date,
                        format: DateFormat("EEEE, MMMM d, yyyy"),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.green,
                          ),
                        ),
                        style: GoogleFonts.prompt(),
                        onSaved: (val) {
                          date = val!;
                        },
                      ),
                    ],
                  )),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        "ยกเลิก",
                        style: GoogleFonts.prompt(fontWeight: FontWeight.w500),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //submit();
                        nextScreenReplace(context, const confirmCheck());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      child: Text("ยืนยัน",
                          style:
                              GoogleFonts.prompt(fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),
            );
          }));
        });
  }

  // submit() async {
  //   if (formkey.currentState!.validate()) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     formkey.currentState!.save();
  //     await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //         .createEvent(carId, model, public, date)
  //         .whenComplete(() {
  //       setState(() {
  //         _isLoading = false;
  //       });
  //       showSnackbar(context, Colors.green, "Booking successfully.");
  //       nextScreenReplace(context, const testPage());
  //     });
  //   }
  // }
}
