import 'package:flutter/material.dart';

class KesanPage extends StatelessWidget {
  const KesanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kesan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Saran : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            SizedBox(height: 10),
            Text('Semoga kedepannya lebih baik lagi dan semoga bermanfaat untuk orang lain. Terima kasih.', style: TextStyle(fontSize: 16), textAlign: TextAlign.center),
            SizedBox(height: 10),
            Text('Kesan : ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            SizedBox(height: 10),
            Text('Saya merasa sangat senang dan puas dengan mata kuliah ini. Saya mendapatkan banyak ilmu baru dan pengalaman baru. Terima kasih. ', style: TextStyle(fontSize: 16,), textAlign: TextAlign.center,),
          ],
        ),
      ),
    );
  }
}