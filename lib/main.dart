import 'package:flutter/material.dart';
import 'package:konverter_suhu2/widget/inputSuhu.dart';
import 'package:konverter_suhu2/widget/konversi.dart';
import 'package:konverter_suhu2/widget/perhitunganTerakhir.dart';
import 'package:konverter_suhu2/widget/riwayatPerhitungan.dart';
import 'package:konverter_suhu2/widget/targetPerhitungan.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Konverter Suhu',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Konverter Suhu'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  TextEditingController etInput = TextEditingController();
  List<String> listSatuanSuhu = ["Kelvin", "Reamur", "Fahrenheit"];
  String selectedDropDown = "Kelvin";
  double hasilPerhitungan = 0;
  List<String> listHasil = [];

  void onDropdownChanged(Object? value) {
    setState(() {
      selectedDropDown = value.toString();
    });
  }

  void konversiSuhu() {
    setState(() {
      if (etInput.text.isNotEmpty){
      switch (selectedDropDown) {
        case "Kelvin":
          hasilPerhitungan = int.parse(etInput.text) + 273.15;
        break;
        case "Reamur":
          hasilPerhitungan = int.parse(etInput.text) * 4 / 5;
        break;
        case "Fahrenheit":
          hasilPerhitungan = (int.parse(etInput.text) * 9 / 5) + 32;
        break;
      }
      listHasil.add(selectedDropDown + " : " + hasilPerhitungan.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: [
            inputSuhu(etInput: etInput),
            SizedBox(height: 8),
            targetPerhitungan(
              selectedDropDown: selectedDropDown, 
              listSatuanSuhu: listSatuanSuhu, onDropdownChanged: onDropdownChanged,
            ),

            SizedBox(height: 10),

            Text("Hasil", style: TextStyle(fontSize: 20)),
            perhitunganTerakhir(hasilPerhitungan: hasilPerhitungan),

            SizedBox(height: 10),
            
            konversi(
              onPressed: konversiSuhu,
            ),

            SizedBox(height: 10),

            Text("Riwayat Konversi", style: TextStyle(fontSize: 20)),

            riwayatPerhitungan(listHasil: listHasil),
          ],
        ),
      ),
    );
  }
}