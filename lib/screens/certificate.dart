import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show ByteData, Uint8List, rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CertificateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Certificate Printer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Certificate of Achievement',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _printCertificate(),
              child: Text('Print Certificate'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _printCertificate() async {
    final ByteData bytes = await rootBundle.load('assets/text.jpg');
    final Uint8List image = bytes.buffer.asUint8List();

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      final pdf = pw.Document();
      pdf.addPage(
        pw.Page(
          build: (context) {
            return pw.Stack(  
              children: [
             pw.Center(
              child: pw.Image(pw.MemoryImage(image),fit: pw.BoxFit.fill),
            ),
        pw.Positioned(
            top: 0,
            left: 20,
            bottom: 80,
            right: 0,
            child:pw.Center(  
              child: pw.Text(
              "Nilesh Pathak",
              style: pw.TextStyle(
                fontSize: 20,
                color: PdfColors.black,
              ),
            ),
            )
          )
              ]
            );
          },
        ),
      );
      return pdf.save();
    });
  }
}

void main() {
  runApp(MaterialApp( 
    title: 'Certificate Printer',
    home: CertificateScreen(),
  ));
}
