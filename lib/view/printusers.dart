import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfUsers extends StatelessWidget {
  final List users;
  PdfUsers({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PdfPreview(
        build: (format) => _generatePdf(format),
      ),
    );
  }

  // Future<Uint8List> _generatePdf(PdfPageFormat format) async {
  //   final pdf = pw.Document();

  //   Future<pw.Font> infont() async {
  //     final ByteData fontData = await rootBundle.load('assets/fonts/hh.ttf');
  //     return pw.Font.ttf(fontData.buffer.asByteData());
  //   }

  //   final arfont = await infont();

  //   pdf.addPage(
  //     pw.Page(
  //       textDirection: pw.TextDirection.rtl,
  //       theme: pw.ThemeData.withFont(
  //         base: arfont,
  //         //fontFallback: [font],
  //       ),
  //       //pageFormat: format,
  //       pageFormat: PdfPageFormat.a5,
  //       build: (context) {
  //         return pw.Container(
  //           child: pw.ListView.builder(
  //               itemCount: users.length,
  //               itemBuilder: (context, i) {
  //                 return pw.Container(
  //                     margin: pw.EdgeInsets.all(12),
  //                     alignment: pw.Alignment.centerLeft,
  //                     child: pw.Text(
  //                       ' ${users[i].name} (${users[i].title})    ${users[i].phone}',
  //                       style: pw.TextStyle(fontSize: 12),
  //                     ));
  //               }),
  //         )
  //         ;
  //       },
  //     ),
  //   );

  //   return pdf.save();
  // }
  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
  final pdf = pw.Document();

  Future<pw.Font> infont() async {
    final ByteData fontData = await rootBundle.load('assets/fonts/hh.ttf');
    return pw.Font.ttf(fontData.buffer.asByteData());
  }

  final arfont = await infont();

  final int itemsPerPage = 11; // عدد العناصر في كل صفحة
  final int pageCount = (users.length / itemsPerPage).ceil(); // عدد الصفحات اللازمة

  for (var pageIndex = 0; pageIndex < pageCount; pageIndex++) {
    final int startIndex = pageIndex * itemsPerPage;
    final int endIndex = (startIndex + itemsPerPage) <= users.length
        ? (startIndex + itemsPerPage)
        : users.length;

    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(
          base: arfont,
          //fontFallback: [font],
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Container(
            child: pw.ListView.builder(
                itemCount: endIndex - startIndex,
                itemBuilder: (context, i) {
                  final int userIndex = i + startIndex;
                  return pw.Container(
                    margin: pw.EdgeInsets.all(12),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      '${users[userIndex].name} (${users[userIndex].title})    ${users[userIndex].phone}',
                      style: pw.TextStyle(fontSize: 12),
                    ),
                  );
                }),
          );
        },
      ),
    );
  }

  return pdf.save();
}
}
