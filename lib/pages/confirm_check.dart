import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/widgets.dart';
import 'home_page.dart';

class confirmCheck extends StatefulWidget {
  const confirmCheck({super.key});

  @override
  State<confirmCheck> createState() => _confirmCheckState();
}

class _confirmCheckState extends State<confirmCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => nextScreenReplace(context, const HomePage()),
          icon: const Icon(
            Icons.home_outlined,
            size: 35,
          ),
        ),
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "คิว",
          style: GoogleFonts.prompt(fontSize: 26, fontWeight: FontWeight.bold),
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
      backgroundColor: const Color.fromARGB(255, 31, 31, 31),
      body: Column(children: [
        SizedBox(
          width: 500,
          height: 200,
          child: Center(
            child: Text(
              "CHECK",
              style: GoogleFonts.prompt(
                  color: const Color.fromARGB(255, 41, 41, 41),
                  fontSize: 100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10),
            ),
          ),
        ),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 340,
                  height: 70,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 187, 186, 186),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/logo white.png',
                        fit: BoxFit.contain,
                        height: 60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 340,
              height: 310,
              decoration: const BoxDecoration(
                color: Color(0xffD9D9D9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Icon(
                    Icons.battery_saver_rounded,
                    color: Colors.green,
                    size: 45,
                  ),
                ),
                Text(
                  "ดำเนินการเสร็จสิ้น",
                  style: GoogleFonts.prompt(
                      color: const Color.fromARGB(255, 41, 41, 41),
                      fontSize: 22,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "?? \n??",
                  style: GoogleFonts.prompt(
                      color: const Color.fromARGB(255, 41, 41, 41),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 30,
                      width: 15,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          color: Color.fromARGB(255, 41, 41, 41),
                        ),
                      ),
                    ),
                    Expanded(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            (constraints.constrainWidth() / 10).floor(),
                            (index) => const SizedBox(
                              height: 1,
                              width: 5,
                              child: DecoratedBox(
                                decoration: BoxDecoration(color: Colors.grey),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 30,
                      width: 15,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15)),
                          color: Color(0xff292929),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 41, 41, 41),
                              size: 40,
                            ),
                            Text(
                              "??/??/??",
                              style: GoogleFonts.prompt(),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.schedule,
                              color: Color.fromARGB(255, 41, 41, 41),
                              size: 40,
                            ),
                            Text("??:??", style: GoogleFonts.prompt())
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Color.fromARGB(255, 41, 41, 41),
                              size: 40,
                            ),
                            Text(
                              "?????",
                              style: GoogleFonts.prompt(),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "*หมายเหตุ สามารถยกเลิกได้ก่อน 1 วันทำการ*",
                              style: GoogleFonts.prompt(
                                  color: Colors.red, fontSize: 12),
                            ),
                            Container(
                              height: 40,
                              width: 80,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ]),
              // Container(
              //   width: 340,
              //   height: 180,
              //   decoration: const BoxDecoration(
              //     color: Color(0xffD9D9D9),
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(25),
              //       bottomRight: Radius.circular(25),
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       const SizedBox(
              //         height: 30,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: const [
              //           Icon(
              //             Icons.calendar_month,
              //             color: const Color.fromARGB(255, 41, 41, 41),
              //             size: 40,
              //           ),
              //           Icon(
              //             Icons.schedule,
              //             color: const Color.fromARGB(255, 41, 41, 41),
              //             size: 40,
              //           ),
              //           Icon(
              //             Icons.location_on_rounded,
              //             color: const Color.fromARGB(255, 41, 41, 41),
              //             size: 40,
              //           ),
              //         ],
              //       ),
              //       const SizedBox(
              //         height: 20,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: [
              //           Column(
              //             children: [
              //               Text(
              //                 "*หมายเหตุ สามารถยกเลิกได้ก่อน 1 วันทำการ*",
              //                 style: GoogleFonts.prompt(color: Colors.red),
              //               ),
              //               Container(
              //                 height: 50,
              //                 width: 100,
              //                 decoration: const BoxDecoration(
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(10)),
              //                     color: Colors.red),
              //               )
              //             ],
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // )
            )
          ],
        )
      ]),
    );
  }
}
