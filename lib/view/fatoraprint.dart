import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class printfatora extends StatelessWidget {
  final int table;
  final int totale;
  final List orders;
  printfatora(
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
    final int itemsPerPage = 8; // عدد العناصر في كل صفحة
    final int pageCount = (orders.length / itemsPerPage).ceil();
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: arfont,
        ),
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
    for (var pageIndex = 0; pageIndex < pageCount; pageIndex++) {
      final int startIndex = pageIndex * itemsPerPage;
      final int endIndex = (startIndex + itemsPerPage) <= orders.length
          ? (startIndex + itemsPerPage)
          : orders.length;

      pdf.addPage(
        pw.Page(
          textDirection: pw.TextDirection.rtl,
          theme: pw.ThemeData.withFont(
            base: arfont,
            //fontFallback: [font],
          ),
          pageFormat: PdfPageFormat.a6,
          build: (context) {
            return pw.Container(
              child: pw.ListView.builder(
                  itemCount: endIndex - startIndex,
                  itemBuilder: (context, i) {
                    final int userIndex = i + startIndex;
                    return pw.Container(
                        child: pw.Container(
                            margin: pw.EdgeInsets.all(12),
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              ' ${orders[userIndex].drinks} (${orders[userIndex].number_order})    ${orders[userIndex].price}',
                              style: pw.TextStyle(fontSize: 12),
                            )));
                  }),
            );
          },
        ),
      );
    }

    return pdf.save();
  }
}