import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:horizontalcalender/horizontalcalendar.dart';
import 'package:yemektenevar/admin_menu_add_screen.dart';
import 'package:yemektenevar/admin_login_screen.dart';

import 'colors.dart';

class UserMealViewScreen extends StatefulWidget {
  const UserMealViewScreen({Key? key}) : super(key: key);

  @override
  _UserMealViewScreenState createState() => _UserMealViewScreenState();
}

class _UserMealViewScreenState extends State<UserMealViewScreen> {
  int dateIndex = 0;
  FixedExtentScrollController itemController = FixedExtentScrollController();
  final DatePickerController _controller = DatePickerController();
  // Seçilen tarih
  DateTime _selectedDate = DateTime.now();

  // Firestore veritabanı referansı
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Seçilen tarihte yemekleri getirir
  Stream<QuerySnapshot> _getMealsStream() {
    return _firestore
        .collection('meals')
        .where('date', isEqualTo: _selectedDate)
        .snapshots();
  }

  // Tarih seçiciyi açmak için kullanılır
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _checkUserLoggedIn() async {
    if (FirebaseAuth.instance.currentUser != null) {
      // Kullanıcı oturum açmış, menü ekleme ekranına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AdminMealAddScreen()),
      );
    } else {
      // Kullanıcı oturum açmamış, giriş ekranına yönlendir
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yemekleri Görüntüle'),
        actions: [
          IconButton(
            onPressed: () {
              _checkUserLoggedIn();
            },
            icon: const Icon(Icons.admin_panel_settings),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Tarih seçici
            Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                child: HorizontalCalendar(DateTime.now(),
                    width: MediaQuery.of(context).size.width * .25,
                    height: 100,
                    selectionColor: blue.withOpacity(.8),
                    itemController: itemController,
                    dateTextStyle: normalDayStyle(),
                    dayTextStyle: normalTextStyle(),
                    daysCount: 28,
                    monthTextStyle: normalTextStyle(),
                    selectedDateStyle: selectedDayStyle(),
                    selectedDayStyle: selectedTextStyle(),
                    selectedTextColor: Colors.white,
                    onDateChange: (selectedDate, position) {
                  setState(() {
                    dateIndex = position;
                    _selectedDate = selectedDate;
                  });
                }, controller: _controller)),
            Row(
              children: [
                const Text('Tarih:'),
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed: () => _selectDate(context),
                  child: Text(
                    "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                  ),
                ),
              ],
            ),

            // Yemekleri listeleyen StreamBuilder
            StreamBuilder<QuerySnapshot>(
              stream: _getMealsStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Veriler alınırken hata oluştu.');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return const Text('Seçilen tarihte yemek bulunamadı.');
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var meal = snapshot.data!.docs[index].data();
                      return menuWidget(meal);

                      // ListTile(
                      //   title: Text(meal['name']),
                      //   subtitle: Text('${meal['type']} - ${meal['price']} TL'),
                      // );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  menuWidget(var meal) {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.38,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            border: Border.all(color: blue.withOpacity(.8), width: 2),
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: meal["type"] != "vejeteryan"
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        menuText(meal["price"]),
                        menuText(meal["name"]),
                        menuText(meal["price"]),
                        menuText(meal["type"]),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Text(
                            "VEJETERYAN",
                            style: TextStyle(
                                color: blue.withOpacity(.8),
                                fontSize: 26,
                                fontFamily: "yanoneB",
                                letterSpacing: 1.0),
                          ),
                        ),
                        menuText(meal["type"]),
                      ],
                    )
                  ],
                )
              : Center(
                  child: menuText("HAFTA SONU"),
                )),
    );
  }

  menuText(var yemek) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        yemek.toString().toUpperCase(),
        style: TextStyle(
          overflow: TextOverflow.ellipsis,
          color: grey,
          fontSize: 26,
          letterSpacing: 1,
          fontFamily: "yanoneM",
        ),
      ),
    );
  }
}

TextStyle normalTextStyle() => TextStyle(
    fontSize: 22, letterSpacing: 1.0, fontFamily: "yanoneM", color: grey);

TextStyle normalDayStyle() => TextStyle(
    fontSize: 24, letterSpacing: 1.0, fontFamily: "yanoneM", color: grey);

TextStyle selectedDayStyle() {
  return const TextStyle(
    fontSize: 26,
    letterSpacing: 1.0,
    color: Colors.white,
    fontFamily: "yanoneB",
  );
}

TextStyle selectedTextStyle() {
  return const TextStyle(
    fontSize: 22,
    letterSpacing: 1.0,
    color: Colors.white,
    fontFamily: "yanoneB",
  );
}
