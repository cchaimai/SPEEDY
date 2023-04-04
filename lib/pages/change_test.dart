import 'package:chat_test/pages/selectcar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:developer';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../widgets/widgets.dart';
import 'confirm_change.dart';
import 'home_page.dart';

// ignore: camel_case_types
class changeTest extends StatefulWidget {
  final String carId;
  final String car;
  const changeTest({super.key, required this.carId, required this.car});

  @override
  State<changeTest> createState() => _changeTestState();
}

// ignore: camel_case_types
class _changeTestState extends State<changeTest> {
  int num = 0;
  //Color color = const Color.fromARGB(255, 154, 222, 61);
  Color color1 = const Color.fromARGB(255, 154, 222, 61);
  Color color2 = const Color.fromARGB(255, 154, 222, 61);

  final userId = FirebaseAuth.instance.currentUser!.uid;
  AuthService authService = AuthService();
  bool _isLoading = false;

  final formkey = GlobalKey<FormState>();

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference _eventCollection =
      FirebaseFirestore.instance.collection("events");
  final CollectionReference<Map<String, dynamic>> dateCollection =
      FirebaseFirestore.instance.collection('date');

  final DateTime _firstDay =
      DateTime.now().subtract(const Duration(days: 1000));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 1000));
  late DateTime _selectedDay;
  DateTime _focusedDay = DateTime.now();

  String firstName = "";
  String lastName = "";
  String type = "Change";
  bool public = false;
  late DateTime date;

  @override
  initState() {
    super.initState();
    _selectedDay = DateTime.now();
    gettingUserData();
  }

  gettingUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('mUsers').doc(uid);
    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data()!;
      final showfirstName = data['firstName'];
      final showlastName = data['lastName'];
      setState(() {
        firstName = showfirstName;
        lastName = showlastName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const selectCar()),
          icon: const Icon(Icons.arrow_back),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "จองคิวเปลี่ยนแบตเตอรี่",
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
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCalendarSlot('09:00'),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot('10:00'),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot("11:00"),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot("12:00"),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCalendarSlot("13:00"),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot("14:00"),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot("15:00"),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot("16:00"),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildCalendarSlot("17:00"),
                  ],
                )
              ],
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

  Widget _buildCalendarSlot(String time) {
    String selectedDay = DateFormat("yyyy-MM-dd").format(_selectedDay);
    log(selectedDay);
    return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      future: dateCollection.doc(selectedDay).get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final data = snapshot.data?.data() ?? {};
        final arrayData = data[time] ?? [];
        int num = arrayData.length;
        Color color = Colors.green;
        if (num == 0 && num == 1) {
          color = Colors.green;
        } else if (num == 2) {
          color = Colors.yellow;
        } else if (num == 3) {
          color = Colors.red;
        }

        return Column(
          children: [
            GestureDetector(
              onTap: () {
                if (num >= 3) {
                  fullDialog(time);
                } else {
                  popUpDialog(context, time);
                }
              },
              child: CircleAvatar(
                radius: 30,
                backgroundColor: color,
                child: Text(
                  '$num',
                  style: GoogleFonts.prompt(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Text(
              time,
              style: GoogleFonts.prompt(),
            ),
          ],
        );
      },
    );
  }

  fullDialog(String time) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Text(
                "Booking Full",
                textAlign: TextAlign.left,
                style: GoogleFonts.prompt(),
              ),
              const SizedBox(
                width: 90,
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 250,
                child: Text(
                  'ขออภัย, คิวในเวลา $time เต็มแล้ว. กรุณาเลือกเวลาอื่นค่ะ.',
                  style: GoogleFonts.prompt(fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  popUpDialog(BuildContext context, String time) {
    String selectedDay = DateFormat("yyyy-MM-dd").format(_selectedDay);
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 150),
                child: AlertDialog(
                  title: Text(
                    "จองคิวเปลี่ยนแบตเตอรี่",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.prompt(fontWeight: FontWeight.w500),
                  ),
                  content: Column(
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          "รถ ${widget.car}",
                          style:
                              GoogleFonts.prompt(fontWeight: FontWeight.w400),
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'ทะเบียน ${widget.carId}',
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const Divider(),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'วันที่ $selectedDay',
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 250,
                        child: Text(
                          'เวลา $time',
                          style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      if (num < 3)
                        Container()
                      else
                        const Text(
                          "Booking full",
                          style: TextStyle(color: Colors.red),
                        ),
                    ],
                  ),
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
                      onPressed: () {
                        submit(selectedDay, time);
                        //nextScreenReplace(context, const confirmChange());
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      child: Text("ยืนยัน",
                          style:
                              GoogleFonts.prompt(fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  submit(String date, String time) async {
    String eventId =
        await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
            .addDateTime(
      FirebaseAuth.instance.currentUser!.uid,
      type,
      date,
      time,
      widget.car,
      widget.carId,
      firstName,
      lastName,
    )
            .whenComplete(() async {
      setState(() {
        _isLoading = false;
      });
      showSnackbar(context, Colors.green, "Booking successfully.");
    });
    // ignore: use_build_context_synchronously
    nextScreenReplace(
        context,
        confirmChange(
          eventsId: eventId,
        ));
  }
}
