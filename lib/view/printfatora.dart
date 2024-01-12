import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class fatora extends StatelessWidget {
  final int table;
  final int totale;
  final List orders;
  fatora(
      {Key? key,
      required this.table,
      required this.totale,
      required this.orders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document();
    Future<pw.Font> infont() async {
      final ByteData fontData = await rootBundle.load('assets/fonts/hh.ttf');
      return pw.Font.ttf(fontData.buffer.asByteData());
    }
    final arfont = await infont();
    // final font = await fontFromAssetBundle(
    //     'assets\fonts\Cairo-VariableFont_slnt,wght.ttf');
    //final font = await PdfGoogleFonts.nunitoExtraLight();
    //final image = await imageFromAssetBundle('images/logo.png');
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: arfont,
          //fontFallback: [font],
        ),
        //pageFormat: format,
        pageFormat: PdfPageFormat.a6,
        build: (context) {
          return pw.Column(
            children: [
              //table
              pw.Container(
                alignment: pw.Alignment.centerLeft,
                width: double.infinity,
                child: pw.Text(
                  "Table Number: $table",
                  style: pw.TextStyle(fontSize: 25),
                ),
              ),
              pw.Container(
                height: 3,
                width: double.infinity,
              ),
              pw.Divider(indent: 2),
              pw.Expanded(
                  child: pw.Container(
                child: pw.ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, i) {
                      return pw.Container(
                          margin: pw.EdgeInsets.all(12),
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            ' ${orders[i].drinks} (${orders[i].number_order})    ${orders[i].price}',
                            style: pw.TextStyle(fontSize: 12),
                          ));
                    }),
              )),

              pw.Divider(indent: 2),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('Total: ${totale}',
                      style: pw.TextStyle(fontSize: 25))),
              pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Text('date: ${orders[0].date}',
                      style: pw.TextStyle(fontSize: 12))),

              //pw.Flexible(child: pw.FlutterLogo())
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
