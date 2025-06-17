import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:hotel_crm/domain/entities/transaction_entity.dart';
import 'package:hotel_crm/domain/entities/material_entity.dart';
import 'package:hotel_crm/domain/entities/supplier_entity.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

class PdfService {
  Future<void> generateOperationPdf({
    required TransactionEntity transaction,
    required MaterialEntity material,
    required SupplierEntity supplier,
  }) async {
    // Load the font
    final fontData = await rootBundle.load('fonts/RussoOne-Regular.ttf');
    final ttf = pw.Font.ttf(fontData);

    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text(
                  'Операция №${transaction.id}',
                  style: pw.TextStyle(font: ttf),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Table(
                border: pw.TableBorder.all(),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('Дата операции', style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          DateFormat('dd.MM.yyyy').format(transaction.date),
                          style: pw.TextStyle(font: ttf),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('Тип операции', style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          transaction.type,
                          style: pw.TextStyle(font: ttf),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('Материал', style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          material.name,
                          style: pw.TextStyle(font: ttf),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('Количество', style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          '${transaction.count} ${material.unitMeasurement}',
                          style: pw.TextStyle(font: ttf),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text('Поставщик', style: pw.TextStyle(font: ttf)),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(
                          supplier.name,
                          style: pw.TextStyle(font: ttf),
                        ),
                      ),
                    ],
                  ),
                  if (transaction.comment != null)
                    pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text('Комментарий', style: pw.TextStyle(font: ttf)),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(8),
                          child: pw.Text(
                            transaction.comment!,
                            style: pw.TextStyle(font: ttf),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          );
        },
      ),
    );

    if (Platform.isWindows) {
      // For Windows, save to Documents folder
      final documentsDir = await getApplicationDocumentsDirectory();
      final pdfDir = Directory('${documentsDir.path}/HotelCRM_PDFs');
      
      if (!await pdfDir.exists()) {
        await pdfDir.create(recursive: true);
      }

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final fileName = 'operation_${transaction.id}_$timestamp.pdf';
      final file = File('${pdfDir.path}/$fileName');

      await file.writeAsBytes(await pdf.save());
      
      // Open the file with the default PDF viewer on Windows
      await Process.run('cmd', ['/c', 'start', '', file.path]);
    } else if (Platform.isMacOS) {
      // For macOS, use temporary directory
      final tempDir = await getTemporaryDirectory();
      final pdfDir = Directory('${tempDir.path}/HotelCRM_PDFs');
      
      if (!await pdfDir.exists()) {
        await pdfDir.create(recursive: true);
      }

      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final fileName = 'operation_${transaction.id}_$timestamp.pdf';
      final file = File('${pdfDir.path}/$fileName');

      await file.writeAsBytes(await pdf.save());
      
      // Open the file with Preview on macOS
      await Process.run('open', [file.path]);
    } else {
      // For other platforms (Linux, etc.), use the printing dialog
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save(),
      );
    }
  }
} 