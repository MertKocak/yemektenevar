import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminMealAddScreen extends StatefulWidget {
  const AdminMealAddScreen({Key? key}) : super(key: key);

  @override
  _AdminMealAddScreenState createState() => _AdminMealAddScreenState();
}

class _AdminMealAddScreenState extends State<AdminMealAddScreen> {
  // Form'dan alınan yemek bilgilerini saklamak için kontroller
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  // Seçilen tarih
  DateTime _selectedDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  // Firestore veritabanı referansı
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Yemek eklenmiş olan günleri tutan bir liste
  List<dynamic> _mealDates = [];

  @override
  void initState() {
    super.initState();
    // Firestore'dan yemek eklenmiş olan günleri al
    _fetchMealDates();
  }

  // Firestore'dan yemek eklenmiş olan günleri alır
  void _fetchMealDates() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('meals')
          .where('date',
              isGreaterThanOrEqualTo: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day,
              ))
          .get();

      setState(() {
        _mealDates = snapshot.docs.map((doc) => doc['date']).toList();
      });
    } catch (e) {
      print('Firestore sorgusu yapılırken bir hata oluştu: $e');
    }
  }

// Yemek ekleme işlemini gerçekleştirir
  void _addMeal() async {
    String name = _nameController.text;
    String type = _typeController.text;
    String price = _priceController.text;

    // Seçilen tarih için daha önceden yemek eklenmiş mi kontrol et
    if (_mealDates
        .where((element) =>
            element.toDate().day == _selectedDate.day &&
            element.toDate().month == _selectedDate.month &&
            element.toDate().year == _selectedDate.year)
        .isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: const Text('Bu tarihe zaten yemek eklenmiş.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
      return; // Yemek eklemeye izin verme, fonksiyonu sonlandır
    }

    // Firestore veritabanına yemek belgesini ekleyin
    try {
      await _firestore.collection('meals').add({
        'name': name,
        'type': type,
        'price': price,
        'date': _selectedDate, // Yemeğin tarihi
      });

      // İşlem başarılıysa, kullanıcıyı bilgilendirin.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Başarılı'),
          content: const Text('Yemek eklendi.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Alanları temizle
                _nameController.clear();
                _typeController.clear();
                _priceController.clear();

                // Yemek eklenmiş olan günleri güncelle
                _fetchMealDates();
              },
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    } catch (error) {
      // Hata durumunda kullanıcıyı bilgilendirin.
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hata'),
          content: Text('Yemek eklenirken bir hata oluştu: $error'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tamam'),
            ),
          ],
        ),
      );
    }
  }

  // Tarih seçiciyi açmak için kullanılır
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Yemek Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Yemek adı girişi
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Yemek Adı'),
            ),
            // Yemek türü girişi
            TextFormField(
              controller: _typeController,
              decoration: const InputDecoration(labelText: 'Yemek Türü'),
            ),
            // Yemek fiyatı girişi
            TextFormField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Yemek Fiyatı'),
            ),
            // Tarih seçici
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
            // Yemek ekle butonu
            ElevatedButton(
              onPressed: _addMeal,
              child: const Text('Yemek Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
