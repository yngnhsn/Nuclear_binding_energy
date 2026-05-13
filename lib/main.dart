import 'package:flutter/material.dart';

void main() {
  runApp(const BindingEnergyApp());
}

class BindingEnergyApp extends StatelessWidget {
  const BindingEnergyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bağlanma Enerjisi',
      theme: ThemeData.dark(),
      home: const BindingLab(),
    );
  }
}

class BindingLab extends StatefulWidget {
  const BindingLab({super.key});

  @override
  State<BindingLab> createState() => _BindingLabState();
}

class _BindingLabState extends State<BindingLab> {
  int protonSayisi = 0;
  int notronSayisi = 0;

  final double protonKutlesi = 1.00728;
  final double notronKutlesi = 1.00866;
  final double donusumKatsayisi = 931.5; 

  double teorikKutle = 0.0;
  double gercekKutle = 0.0;
  double kayipKutle = 0.0;
  double baglanmaEnerjisi = 0.0;

  void hesapla() {
    setState(() {
      teorikKutle = (protonSayisi * protonKutlesi) + (notronSayisi * notronKutlesi);
      
      if (protonSayisi == 0 && notronSayisi == 0) {
        gercekKutle = 0.0;
      } else if (protonSayisi == 2 && notronSayisi == 2) {
        gercekKutle = 4.00150; 
      } else if (protonSayisi == 1 && notronSayisi == 0) {
        gercekKutle = 1.00728;
      } else if (protonSayisi == 0 && notronSayisi == 1) {
        gercekKutle = 1.00866;
      } else {
        gercekKutle = teorikKutle * 0.991; 
      }

      kayipKutle = teorikKutle - gercekKutle;
      if (kayipKutle < 0) kayipKutle = 0;

      baglanmaEnerjisi = kayipKutle * donusumKatsayisi;
    });
  }

  void artirProton() {
    protonSayisi++;
    hesapla();
  }

  void azaltProton() {
    if (protonSayisi > 0) {
      protonSayisi--;
      hesapla();
    }
  }

  void artirNotron() {
    notronSayisi++;
    hesapla();
  }

  void azaltNotron() {
    if (notronSayisi > 0) {
      notronSayisi--;
      hesapla();
    }
  }

  void sistemiSifirla() {
    setState(() {
      protonSayisi = 0;
      notronSayisi = 0;
      hesapla();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("E = mc² Laboratuvarı ⚛️"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.redAccent),
                    ),
                    child: Column(
                      children: [
                        const Text("Proton (+)", style: TextStyle(fontSize: 18, color: Colors.redAccent)),
                        Text("$protonSayisi", style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
                        Row(
                          children: [
                            IconButton(onPressed: azaltProton, icon: const Icon(Icons.remove_circle_outline, color: Colors.redAccent)),
                            IconButton(onPressed: artirProton, icon: const Icon(Icons.add_circle_outline, color: Colors.redAccent)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blueAccent),
                    ),
                    child: Column(
                      children: [
                        const Text("Nötron (0)", style: TextStyle(fontSize: 18, color: Colors.blueAccent)),
                        Text("$notronSayisi", style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white)),
                        Row(
                          children: [
                            IconButton(onPressed: azaltNotron, icon: const Icon(Icons.remove_circle_outline, color: Colors.blueAccent)),
                            IconButton(onPressed: artirNotron, icon: const Icon(Icons.add_circle_outline, color: Colors.blueAccent)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
              Card(
                color: Colors.grey.shade900,
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Teorik Kütle:", style: TextStyle(fontSize: 16, color: Colors.grey)),
                          Text("${teorikKutle.toStringAsFixed(5)} u", style: const TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Gerçek Kütle:", style: TextStyle(fontSize: 16, color: Colors.grey)),
                          Text("${gercekKutle.toStringAsFixed(5)} u", style: const TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Kayıp Kütle (Δm):", style: TextStyle(fontSize: 18, color: Colors.orangeAccent)),
                          Text("${kayipKutle.toStringAsFixed(5)} u", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.greenAccent, width: 2),
                  boxShadow: baglanmaEnerjisi > 0 ? [
                    BoxShadow(
                      color: Colors.greenAccent.withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    )
                  ] : [],
                ),
                child: Column(
                  children: [
                    const Text("Açığa Çıkan Bağlanma Enerjisi", style: TextStyle(fontSize: 18, color: Colors.greenAccent)),
                    const SizedBox(height: 10),
                    Text(
                      "${baglanmaEnerjisi.toStringAsFixed(2)} MeV",
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ],
                ),
              ),

              ElevatedButton(
                onPressed: sistemiSifirla,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade800,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("TERAZİYİ SIFIRLA", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}