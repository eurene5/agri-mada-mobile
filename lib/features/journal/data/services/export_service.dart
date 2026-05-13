import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../../core/local_db/models/diagnostic_local.dart';
import '../../../../core/local_db/models/parcelle_local.dart';

class ExportService {
  ExportService();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  Future<String> exportCsv({
    required List<DiagnosticLocal> diagnostics,
    required Map<int, ParcelleLocal> parcellesById,
    int? parcelleId,
  }) async {
    final directory = await _ensureExportDirectory();
    final fileName = _buildFileName('csv', parcelleId);
    final file = File('${directory.path}/$fileName');

    final rows = <List<String>>[
      [
        'Date',
        'Parcelle',
        'Maladie',
        'Gravité',
        'Confiance(%)',
        'Recommandations',
        'Traitement appliqué',
      ],
      ...diagnostics.map(
        (diagnostic) => [
          _dateFormat.format(diagnostic.dateDiagnostic),
          _parcelleLabel(diagnostic.parcelleLocalId, parcellesById),
          diagnostic.maladieDetectee,
          _formatGravite(diagnostic.niveauGravite),
          _confidencePercent(diagnostic.confiance),
          _normalizeText(diagnostic.recommandations),
          _normalizeText(diagnostic.recommandations),
        ],
      ),
    ];

    final csvData = const ListToCsvConverter(
      fieldDelimiter: ';',
      textDelimiter: '"',
      eol: '\r\n',
    ).convert(rows);

    final bomBytes = <int>[0xEF, 0xBB, 0xBF, ...utf8.encode(csvData)];
    await file.writeAsBytes(bomBytes, flush: true);
    return file.path;
  }

  Future<String> exportPdf({
    required List<DiagnosticLocal> diagnostics,
    required Map<int, ParcelleLocal> parcellesById,
    int? parcelleId,
  }) async {
    final directory = await _ensureExportDirectory();
    final fileName = _buildFileName('pdf', parcelleId);
    final file = File('${directory.path}/$fileName');

    final pdf = pw.Document();
    final logo = await _loadLogo();
    final exportDate = _dateFormat.format(DateTime.now());
    final parcelleLabel = parcelleId == null
        ? 'Toutes les parcelles'
        : _parcelleLabel(parcelleId, parcellesById);

    pdf.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(24),
        ),
        footer: (context) => pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Text(
            'Généré par AgriMada - Agriculture intelligente',
            style: pw.TextStyle(fontSize: 9, color: PdfColors.grey600),
          ),
        ),
        build: (context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (logo != null) ...[
                pw.Container(
                  width: 64,
                  height: 64,
                  decoration: pw.BoxDecoration(
                    borderRadius: pw.BorderRadius.circular(12),
                  ),
                  child: pw.Image(logo, fit: pw.BoxFit.cover),
                ),
                pw.SizedBox(width: 16),
              ],
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'AgriMada',
                      style: pw.TextStyle(
                        fontSize: 22,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 4),
                    pw.Text('Export journal agricole',
                        style: const pw.TextStyle(fontSize: 12)),
                    pw.SizedBox(height: 4),
                    pw.Text('Parcelle: $parcelleLabel',
                        style: const pw.TextStyle(fontSize: 11)),
                    pw.Text('Date d\'export: $exportDate',
                        style: const pw.TextStyle(fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.6),
            columnWidths: const {
              0: pw.FlexColumnWidth(1.2),
              1: pw.FlexColumnWidth(1.2),
              2: pw.FlexColumnWidth(1.3),
              3: pw.FlexColumnWidth(0.9),
              4: pw.FlexColumnWidth(0.8),
              5: pw.FlexColumnWidth(1.8),
              6: pw.FlexColumnWidth(1.4),
            },
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.green),
                children: [
                  _PdfHeaderCell('Date'),
                  _PdfHeaderCell('Parcelle'),
                  _PdfHeaderCell('Maladie'),
                  _PdfHeaderCell('Gravité'),
                  _PdfHeaderCell('Confiance(%)'),
                  _PdfHeaderCell('Recommandations'),
                  _PdfHeaderCell('Traitement appliqué'),
                ],
              ),
              ...diagnostics.map(
                (diagnostic) => pw.TableRow(
                  decoration: const pw.BoxDecoration(color: PdfColors.white),
                  children: [
                    _PdfBodyCell(_dateFormat.format(diagnostic.dateDiagnostic)),
                    _PdfBodyCell(
                      _parcelleLabel(diagnostic.parcelleLocalId, parcellesById),
                    ),
                    _PdfBodyCell(diagnostic.maladieDetectee),
                    _PdfBodyCell(
                      _formatGravite(diagnostic.niveauGravite),
                      backgroundColor: _graviteColor(diagnostic.niveauGravite),
                      textColor: PdfColors.white,
                    ),
                    _PdfBodyCell(
                      _confidencePercent(diagnostic.confiance),
                      alignment: pw.Alignment.centerRight,
                    ),
                    _PdfBodyCell(_normalizeText(diagnostic.recommandations)),
                    _PdfBodyCell(_normalizeText(diagnostic.recommandations)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );

    await file.writeAsBytes(await pdf.save(), flush: true);
    return file.path;
  }

  Future<Directory> _ensureExportDirectory() async {
    final base = await getApplicationDocumentsDirectory();
    final directory = Directory('${base.path}/exports');
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  String _buildFileName(String extension, int? parcelleId) {
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    final suffix =
        parcelleId == null ? 'toutes_parcelles' : 'parcelle_$parcelleId';
    return 'agri_mada_journal_${suffix}_$timestamp.$extension';
  }

  String _parcelleLabel(int parcelleId, Map<int, ParcelleLocal> parcellesById) {
    final parcelle = parcellesById[parcelleId];
    return parcelle?.nomParcelle ?? 'Parcelle $parcelleId';
  }

  String _formatGravite(String? gravite) => switch (gravite?.toLowerCase()) {
        'sévère' || 'severe' => 'Sévère',
        'modéré' || 'modere' => 'Modéré',
        'faible' => 'Faible',
        _ => 'Non précisée',
      };

  String _confidencePercent(double? confidence) {
    final value = confidence == null ? 0 : (confidence * 100).round();
    return '$value';
  }

  String _normalizeText(String? value) {
    final text = value?.trim();
    return (text == null || text.isEmpty) ? '—' : text;
  }

  PdfColor _graviteColor(String? value) => switch (value?.toLowerCase()) {
        'faible' => PdfColors.green,
        'modéré' || 'modere' => PdfColors.orange,
        'sévère' || 'severe' => PdfColors.red,
        _ => PdfColors.grey700,
      };

  Future<pw.ImageProvider?> _loadLogo() async {
    try {
      final imageBytes = await rootBundle.load('assets/images/logo.png');
      return pw.MemoryImage(imageBytes.buffer.asUint8List());
    } catch (_) {
      return null;
    }
  }
}

class _PdfHeaderCell extends pw.StatelessWidget {
  _PdfHeaderCell(this.label);

  final String label;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: pw.Text(
        label,
        style: pw.TextStyle(
          fontSize: 10,
          fontWeight: pw.FontWeight.bold,
          color: PdfColors.white,
        ),
      ),
    );
  }
}

class _PdfBodyCell extends pw.StatelessWidget {
  _PdfBodyCell(
    this.label, {
    this.backgroundColor,
    this.textColor,
    this.alignment,
  });

  final String label;
  final PdfColor? backgroundColor;
  final PdfColor? textColor;
  final pw.Alignment? alignment;

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      alignment: alignment ?? pw.Alignment.centerLeft,
      color: backgroundColor,
      padding: const pw.EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      child: pw.Text(
        label,
        style: pw.TextStyle(
          fontSize: 9,
          color: textColor ?? PdfColors.black,
        ),
      ),
    );
  }
}
