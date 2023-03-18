import 'package:chat_test/pages/addbank.dart';
import 'package:chat_test/pages/addcard.dart';
import 'package:chat_test/pages/home_page.dart';
import 'package:chat_test/pages/profile_beam.dart';
import 'package:chat_test/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BankPage extends StatefulWidget {
  final String userId;
  const BankPage({super.key, required this.userId});

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final List<Map<String, dynamic>> _cards = [];
  final userId = FirebaseAuth.instance.currentUser!.uid;
  bool _hasData = false;
  String fname = '';
  String lname = '';
  String valid = '';
  String no = '';

  Future<void> gettingCardData() async {
    try {
      // ignore: unnecessary_cast
      DocumentSnapshot documentSnapshot = (await FirebaseFirestore.instance
          .collection('cards')
          .get()) as DocumentSnapshot<Object?>;

      if (documentSnapshot.exists) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Retrieve data from the document
        fname = data['fname'];
        lname = data['lname'];
        valid = data['valid'];
        no = data['cardNum'];
      } else {
        // ignore: avoid_print
        print('Document does not exist');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching data: $e');
    }
  }

  Future<void> _fetchUserCards() async {
    // Get the current user's data
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(widget.userId);
    final userData = await userRef.get();

    // Get the array of card document names from the user's data
    final cardIds = userData.get('cards') as List<dynamic>;

    // Loop through each card ID and fetch the corresponding card document
    for (final cardId in cardIds) {
      final cardRef =
          FirebaseFirestore.instance.collection('cards').doc(cardId);

      // Check if the card document exists before fetching the data
      final cardData = await cardRef.get();
      if (cardData.exists) {
        setState(() {
          _cards.add(cardData.data()!);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    gettingCardData();
    _fetchUserCards();

    // Retrieve data from Firebase collection
    FirebaseFirestore.instance
        .collection('cards')
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size > 0) {
        setState(() {
          _hasData = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              nextScreenReplace(context, const HomePage());
            },
            icon: const Icon(Icons.home)),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
              )),
        ],
        toolbarHeight: 100,
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo white.png',
              fit: BoxFit.contain,
              height: 80,
            ),
          ],
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cards').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SafeArea(
              child: Column(children: [
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    nextScreenReplace(context, ProfileScreen());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.green,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text("บัญชีธนาคาร/บัตรเครดิต/บัตรเดบิต",
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.bold, fontSize: 18)),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                  child: Icon(
                    Icons.credit_card,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("บัตรเครดิต/บัตรเดบิต",
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w400, fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            _cards.isNotEmpty
                ? Column(
                    children: [
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                            itemCount: _cards.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final card = _cards[index];
                              final docUser = FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(userId);
                              return Container(
                                width: 300,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color.fromARGB(255, 31, 31, 31),
                                ),
                                margin:
                                    const EdgeInsets.fromLTRB(50, 10, 10, 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/master.png",
                                            width: 50,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text("Delete!",
                                                        style:
                                                            GoogleFonts.prompt(
                                                                fontSize: 16)),
                                                    content: Text(
                                                        "Are you sure you want to delete this card?",
                                                        style:
                                                            GoogleFonts.prompt(
                                                                fontSize: 16)),
                                                    actions: [
                                                      IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        icon: const Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () async {
                                                          FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'cards')
                                                              .doc(card[
                                                                  'cardId'])
                                                              .delete();
                                                          docUser.update({
                                                            // ignore: prefer_interpolation_to_compose_strings
                                                            'cards': FieldValue
                                                                .arrayRemove([
                                                              '${card['cardId']}'
                                                            ])
                                                          });
                                                          Navigator.of(context)
                                                              .pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              BankPage(
                                                                                userId: userId,
                                                                              )),
                                                                  (route) =>
                                                                      false);
                                                        },
                                                        icon: const Icon(
                                                          Icons.done,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0),
                                              child: Text(
                                                  card['fname'] +
                                                      " " +
                                                      card['lname'],
                                                  style: GoogleFonts.prompt(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 22,
                                                      color: Colors.white)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 2, 0, 0),
                                              child: Text(card['cardNum'],
                                                  style: GoogleFonts.prompt(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      5, 2, 0, 0),
                                              child: Text(card['valid'],
                                                  style: GoogleFonts.prompt(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 16,
                                                      color: Colors.white)),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  )
                : Container(
                    alignment: Alignment.center,
                    height: 180,
                    width: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 217, 217, 217),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("ยังไม่ได้เชื่อมต่อบัญชี\nกรุณาเพิ่มข้อมูลก่อน",
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w600, fontSize: 22)),
                  ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                nextScreenReplace(
                    context,
                    AddCard(
                      userId: userId,
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 217, 217, 217),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Icon(Icons.add),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 0, 0),
                  child: Icon(
                    Icons.wallet,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: Text("บัญชีธนาคาร",
                      style: GoogleFonts.prompt(
                          fontWeight: FontWeight.w400, fontSize: 16)),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(150, 10, 0, 0),
                  child: Icon(
                    Icons.expand_more,
                    size: 30,
                    color: Color.fromARGB(255, 217, 217, 217),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                nextScreenReplace(context, const AddBank());
              },
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(70, 10, 0, 0),
                    child: Icon(
                      Icons.add,
                      size: 30,
                      color: Color.fromARGB(255, 217, 217, 217),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Text("เพิ่มบัญชีธนาคาร",
                        style: GoogleFonts.prompt(
                            fontWeight: FontWeight.w400, fontSize: 16)),
                  ),
                ],
              ),
            ),
          ]));
        },
      ),
    );
  }
}
