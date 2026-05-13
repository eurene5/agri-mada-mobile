import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/local_db/models/diagnostic_local.dart';
import '../../../journal/data/repositories/parcelle_local_repository.dart';
import '../../../scan/data/repositories/diagnostic_local_repository.dart';
import '../../data/services/export_service.dart';

enum ExportFormat { csv, pdf }

class ExportJournalUseCase {
  ExportJournalUseCase({
    required DiagnosticLocalRepository diagnosticRepository,
    required ParcelleLocalRepository parcelleRepository,
    required ExportService exportService,
  })  : _diagnosticRepository = diagnosticRepository,
        _parcelleRepository = parcelleRepository,
        _exportService = exportService;

  final DiagnosticLocalRepository _diagnosticRepository;
  final ParcelleLocalRepository _parcelleRepository;
  final ExportService _exportService;

  Future<Either<Failure, String>> call({
    int? parcelleId,
    required ExportFormat format,
  }) async {
    try {
      final diagnostics = await _loadDiagnostics(parcelleId);
      if (diagnostics.isEmpty) {
        return const Left(CacheFailure('Aucun diagnostic à exporter'));
      }

      final parcelles = await _parcelleRepository.getAllParcelles();
      final parcellesById = {
        for (final parcelle in parcelles) parcelle.id: parcelle,
      };

      final orderedDiagnostics = diagnostics.toList()
        ..sort((a, b) => a.dateDiagnostic.compareTo(b.dateDiagnostic));

      final path = switch (format) {
        ExportFormat.csv => await _exportService.exportCsv(
            diagnostics: orderedDiagnostics,
            parcellesById: parcellesById,
            parcelleId: parcelleId,
          ),
        ExportFormat.pdf => await _exportService.exportPdf(
            diagnostics: orderedDiagnostics,
            parcellesById: parcellesById,
            parcelleId: parcelleId,
          ),
      };

      return Right(path);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  Future<List<DiagnosticLocal>> _loadDiagnostics(int? parcelleId) {
    if (parcelleId == null) {
      return _diagnosticRepository.getAllDiagnostics();
    }
    return _diagnosticRepository.getDiagnosticsByParcelle(parcelleId);
  }
}
