import 'package:flutter/material.dart';
import 'package:yemektenevar/data.dart';
import 'package:horizontalcalender/horizontalcalendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color blue = const Color.fromRGBO(1, 208, 201, 1);
  Color grey = const Color.fromRGBO(50, 50, 50, 1);
  Color orange = Color.fromARGB(255, 255, 88, 88);
  FixedExtentScrollController itemController = FixedExtentScrollController();
  int tarih = 0;

  @override
  void initState() {
    itemController.initialItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            "YEMEKTE NE VAR?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              letterSpacing: 2,
              fontFamily: "yanoneB",
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: blue.withOpacity(.5),
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 243, 243, 243),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
              ),
              Image.asset(
                "assets/images/playstore.png",
                height: 66,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(16.0),
                  child: HorizontalCalendar(
                    DateTime.utc(2023, 2, 1),
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
                        tarih = position;
                      });
                    },
                  )),
              menuWidget(tarih),
              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Text(
                  "AFİYET OLSUN !",
                  style: TextStyle(
                    letterSpacing: 4,
                    color: blue.withOpacity(.8),
                    fontSize: 32,
                    fontFamily: "yanoneM",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  menuWidget(int sayi) {
    var corba = Strings.Yemek1[sayi];
    var anayemek = Strings.Yemek2[sayi];
    var yan = Strings.Yemek3[sayi];
    var yan2 = Strings.Yemek4[sayi];
    var vejeteryan = Strings.vejeteryan[sayi];
    return Center(
      child: Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.38,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: corba != ""
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        menuText(corba),
                        menuText(anayemek),
                        menuText(yan),
                        menuText(yan2),
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
                        menuText(vejeteryan),
                      ],
                    )
                  ],
                )
              : Center(
                  child: menuText("HAFTA SONU"),
                )),
    );
  }

  menuText(String yemek) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        yemek.toUpperCase(),
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
}
