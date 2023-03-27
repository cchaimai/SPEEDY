import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:chat_test/pages/confirm_change.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import '../service/database_service.dart';
import '../widgets/widgets.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'home_page.dart';

class changeQueue extends StatefulWidget {
  const changeQueue({super.key});

  @override
  State<changeQueue> createState() => _changeQueueState();
}

// ignore: camel_case_types
class _changeQueueState extends State<changeQueue> {
  DateTime _focusedDay = DateTime.now();
  final DateTime _firstDay =
      DateTime.now().subtract(const Duration(days: 1000));
  final DateTime _lastDay = DateTime.now().add(const Duration(days: 1000));
  late DateTime _selectedDay;
  DateTime _selectedDateTime = DateTime.now();
  Map<String, List> mySelectedEvents = {};
  final formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  String type = "Change";
  String model = "";
  String carId = "";
  late DateTime date;

  Map<String, List> events = {};

  @override
  initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _fetchEvent().then((value) => log(events.toString()));
  }

  List _listofDayEvents(DateTime dateTime) {
    if (events[DateFormat('yyyy-MM-dd').format(dateTime).toString()] != null) {
      return events[DateFormat('yyyy-MM-dd').format(dateTime).toString()]!;
    } else {
      return [];
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );
    if (time != null) {
      setState(() {
        _selectedDateTime = DateTime(
          _selectedDateTime.year,
          _selectedDateTime.month,
          _selectedDateTime.day,
          time.hour,
          time.minute,
        );
      });
    }
  }

  Future<Map<String, List>> _fetchEvent() async {
    final dateRef = FirebaseFirestore.instance.collection('date');
    final dateSnapshot = await dateRef.get();

    for (var dateDoc in dateSnapshot.docs) {
      final dateStr = dateDoc.id.toString();
      final eventsId = dateDoc.get('time') as List<dynamic>;

      for (var eventId in eventsId) {
        final eventRef =
            FirebaseFirestore.instance.collection('events').doc(eventId);
        final eventData = await eventRef.get();

        if (eventData.exists) {
          final time = eventData['time'] as String;
          events.putIfAbsent(dateStr, () => []).add({'time': time});
        }
      }
    }
    return events;
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
                eventLoader: _listofDayEvents,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "จองเวลา ${DateFormat('HH:mm').format(_selectedDateTime)}",
                  style: GoogleFonts.prompt(fontSize: 20),
                ),
                const SizedBox(height: 20),
                IconButton(
                  onPressed: () => _selectTime(context),
                  color: Colors.grey,
                  icon: const Icon(Icons.schedule, size: 20),
                ),
              ],
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
                      "จองคิว",
                      style: GoogleFonts.prompt(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
              ),
            ),
            ..._listofDayEvents(_selectedDay).map(
              (myEvents) => ListTile(
                leading: const Icon(
                  Icons.event_busy_rounded,
                  color: Colors.red,
                ),
                title: Text('Time:   ${myEvents['time']}'),
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {},
                child: SizedBox(
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
                          // ignore: prefer_const_constructors
                          textStyle: TextStyle(
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
                onTap: () {},
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ignore: prefer_const_constructors
                      Icon(
                        Icons.fact_check_outlined,
                        color: Colors.white,
                      ),
                      Text(
                        'เช็ค',
                        style: GoogleFonts.prompt(
                          // ignore: prefer_const_constructors
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
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
                onTap: () {},
                child: SizedBox(
                  width: 60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.change_circle_outlined,
                        color: Colors.green,
                      ),
                      Text(
                        'เปลี่ยน',
                        style: GoogleFonts.prompt(
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.green,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SizedBox(
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

  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 100),
                  child: AlertDialog(
                    title: Text(
                      "จองคิวเปลี่ยนแบตเตอรี่",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.prompt(),
                    ),
                    content: Column(
                      children: [
                        SizedBox(
                            width: 250,
                            child: TextFormField(
                              onSaved: (val) {
                                model = val!;
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "กรุณากรอกรุ่นรถยนต์";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "รุ่นรถยนต์",
                                hintStyle: GoogleFonts.prompt(
                                    color: Colors.grey.shade400),
                                border: InputBorder.none,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 5), // add padding to adjust icon
                                  child: Icon(
                                    Icons.directions_car,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            )),
                        const Divider(),
                        SizedBox(
                            width: 250,
                            child: TextFormField(
                              onSaved: (val) {
                                carId = val!;
                              },
                              validator: (val) {
                                if (val!.isNotEmpty) {
                                  return null;
                                } else {
                                  return "กรุณากรอกทะเบียนรถยนต์";
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "ทะเบียนรถยนต์",
                                hintStyle: GoogleFonts.prompt(
                                    color: Colors.grey.shade400),
                                border: InputBorder.none,
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(
                                      top: 5), // add padding to adjust icon
                                  child: Icon(
                                    Icons.wysiwyg,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            )),
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
                        const Divider(),
                        FormBuilderDateTimePicker(
                          name: "time",
                          initialValue: _selectedDateTime,
                          initialDate: _selectedDateTime,
                          fieldHintText: "Select Time",
                          inputType: InputType.time,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Icon(
                              Icons.schedule_rounded,
                              color: Colors.green,
                            ),
                          ),
                          onSaved: (val) {
                            _selectedDateTime = val!;
                          },
                        ),
                      ],
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red),
                        child: Text(
                          "ยกเลิก",
                          style:
                              GoogleFonts.prompt(fontWeight: FontWeight.w500),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            submit();
                          }
                          //nextScreenReplace(context, const confirmChange());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        child: Text("ยืนยัน",
                            style: GoogleFonts.prompt(
                                fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  submit() async {
    String selectedTime =
        DateFormat('HH:mm').format(_selectedDateTime).toString();
    String selectedDay =
        DateFormat("yyyy-MM-dd").format(_selectedDay).toString();

    if (formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      formkey.currentState!.save();
      String eventId =
          await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
              .addDateTime(FirebaseAuth.instance.currentUser!.uid, type,
                  selectedDay, selectedTime, model, carId)
              .whenComplete(() async {
        setState(() {
          _isLoading = false;
        });
        // ignore: use_build_context_synchronously
        showSnackbar(context, Colors.green, "Booking successfully.");
        // ignore: use_build_context_synchronously
      });
      // ignore: use_build_context_synchronously
      nextScreenReplace(
          context,
          confirmChange(
            eventsId: eventId,
          ));
    }
    //log("New Event for backend developer ${json.encode(events)}");
    selectedTime = "";
    return;
  }
}
