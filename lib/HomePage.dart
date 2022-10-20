import 'package:flutter/material.dart';
import 'package:yemektenevar/data.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/playstore.png",
              height: 180,
            ),
            Container(
              child: Text(
                "Yemekte Ne Var?",
                style: TextStyle(
                    color: Color.fromRGBO(232, 80, 80, 1),
                    fontSize: 26,
                    fontFamily: "comfortaaB",
                    fontWeight: FontWeight.w900),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Ekim",
              style: TextStyle(
                  color: Color.fromRGBO(232, 80, 80, 1),
                  fontSize: 20,
                  fontFamily: "comfortaaB",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tarih(1),
                        Tarih(2),
                        Tarih(3),
                        Tarih(4),
                        Tarih(5),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tarih(6),
                        Tarih(7),
                        Tarih(8),
                        Tarih(9),
                        Tarih(10),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tarih(11),
                        Tarih(12),
                        Tarih(13),
                        Tarih(14),
                        Tarih(15),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tarih(16),
                        Tarih(17),
                        Tarih(18),
                        Tarih(19),
                        Tarih(20),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tarih(21),
                        Tarih(22),
                        Tarih(23),
                        Tarih(24),
                        Tarih(25),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Tarih(26),
                        Tarih(27),
                        Tarih(28),
                        Tarih(29),
                        Tarih(30),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Tarih(int sayi) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => deneme(sayi)));
      },
      child: Container(
        margin: EdgeInsets.all(6),
        height: 48,
        width: 48,
        child: Center(
          child: Text(
            sayi.toString(),
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 18,
                fontFamily: "comfortaaB",
                fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(106, 106, 106, 1), width: 2),
          borderRadius: BorderRadius.circular(8),
          color: Color.fromRGBO(31, 179, 174, 1),
        ),
      ),
    );
  }

  deneme(int sayi) {
    var corba = Strings.Yemek1[sayi - 1];
    var anayemek = Strings.Yemek2[sayi - 1];
    var yan = Strings.Yemek3[sayi - 1];
    var yan2 = Strings.Yemek4[sayi - 1];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/playstore.png",
              height: 180,
            ),
            SizedBox(
              height: 0,
            ),
            Text(
              "Günün Menüsü",
              style: TextStyle(
                  color: Color.fromRGBO(232, 80, 80, 1),
                  fontSize: 26,
                  fontFamily: "comfortaaB",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 35,
            ),
            Text(
              corba,
              style: TextStyle(
                  color: Color.fromRGBO(31, 179, 174, 1),
                  fontSize: 22,
                  fontFamily: "comfortaaB",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              anayemek,
              style: TextStyle(
                  color: Color.fromRGBO(31, 179, 174, 1),
                  fontSize: 22,
                  fontFamily: "comfortaaB",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              yan,
              style: TextStyle(
                  color: Color.fromRGBO(31, 179, 174, 1),
                  fontSize: 22,
                  fontFamily: "comfortaaB",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              yan2,
              style: TextStyle(
                  color: Color.fromRGBO(31, 179, 174, 1),
                  fontSize: 22,
                  fontFamily: "comfortaaB",
                  fontWeight: FontWeight.w900),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Afiyet Olsun!",
              style: TextStyle(
                  color: Color.fromRGBO(31, 179, 174, 1),
                  fontSize: 18,
                  fontFamily: "comfortaaM",
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              "(mümkünse tabi)",
              style: TextStyle(
                  color: Color.fromRGBO(31, 179, 174, 1),
                  fontSize: 18,
                  fontFamily: "comfortaaM",
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
