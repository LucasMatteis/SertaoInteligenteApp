import 'package:flutter/material.dart';

void main() {
  runApp(SertaoInteligenteApp());
}

class SertaoInteligenteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sertão Inteligente',
      theme: ThemeData(
        primaryColor: Colors.brown,
        scaffoldBackgroundColor: Color(0xFFF5EBD0), // fundo bege
        fontFamily: 'Arial',
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  final Color cardColor = Color(0xFFF9E3C8); // cor base dos cards

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sertão Inteligente'),
        backgroundColor: Colors.brown,
        centerTitle: true,
        leading: Icon(Icons.menu),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // Alerta de seca prolongada
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.white, size: 30),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Seca Prolongada",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        Text("Risco de seca extrema!",
                            style: TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            // Cards principais
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  buildCard(
                    context,
                    icon: Icons.opacity,
                    title: 'Nível da Cisterna',
                    content: '30%',
                    color: cardColor,
                    gauge: true,
                  ),
                  buildCard(
                    context,
                    icon: Icons.wb_sunny,
                    title: 'Previsão do Tempo',
                    content: '35°',
                    color: cardColor,
                  ),
                  buildCard(
                    context,
                    icon: Icons.lightbulb,
                    title: 'Dicas',
                    content: 'VER',
                    color: cardColor,
                    button: true,
                  ),
                  buildCard(
                    context,
                    icon: Icons.place,
                    title: 'Fontes de Água',
                    content: '',
                    color: cardColor,
                    map: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String content,
    required Color color,
    bool button = false,
    bool map = false,
    bool gauge = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 28, color: Colors.brown),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          if (button)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DicasPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.brown,
              ),
              child: Text('VER'),
            )
          else if (map)
            Expanded(
              child: Center(
                child: Icon(Icons.map, size: 48, color: Colors.green),
              ),
            )
          else if (gauge)
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(
                        value: 0.3,
                        strokeWidth: 6,
                        backgroundColor: Colors.grey.shade300,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      ),
                    ),
                    Text(content,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              ),
            )
          else
            Text(content,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class DicasPage extends StatelessWidget {
  final List<Map<String, String>> dicas = [
    {
      'titulo': 'Use Água de Reuso',
      'descricao': 'Aproveite a água da chuva ou da máquina de lavar para regar plantas ou lavar o chão.'
    },
    {
      'titulo': 'Evite Vazamentos',
      'descricao': 'Verifique torneiras, descargas e canos regularmente para evitar desperdício silencioso.'
    },
    {
      'titulo': 'Banhos Rápidos',
      'descricao': 'Reduza o tempo no banho para economizar dezenas de litros de água diariamente.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicas de Economia de Água'),
        backgroundColor: Colors.brown,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: dicas.length,
        itemBuilder: (context, index) {
          final dica = dicas[index];
          return Card(
            color: Color(0xFFF9E3C8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dica['titulo'] ?? '',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    dica['descricao'] ?? '',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
