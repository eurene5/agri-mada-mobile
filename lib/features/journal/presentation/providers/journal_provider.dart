// Providers Riverpod pour la gestion du journal agricole (Isar)

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/local_db/models/parcelle_local.dart';
import '../../data/repositories/parcelle_local_repository.dart';

/// Accès au repository des parcelles
final parcelleRepositoryProvider = Provider<ParcelleLocalRepository>(
  (_) => ParcelleLocalRepository(),
);

/// Journal agricole complet avec statut de santé de chaque parcelle
final journalAgricoleProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  return ref.read(parcelleRepositoryProvider).getJournalAgricole();
});

/// Liste simple de toutes les parcelles
final parcellesProvider = FutureProvider<List<ParcelleLocal>>((ref) async {
  return ref.read(parcelleRepositoryProvider).getAllParcelles();
});

/// Notifier pour les actions de création / mise à jour des parcelles
class ParcelleNotifier extends StateNotifier<AsyncValue<void>> {
  ParcelleNotifier(this._repo) : super(const AsyncValue.data(null));

  final ParcelleLocalRepository _repo;

  Future<ParcelleLocal?> createParcelle({
    required String nom,
    String? description,
    double? surface,
    double? latitude,
    double? longitude,
  }) async {
    state = const AsyncValue.loading();
    try {
      final parcelle = await _repo.createParcelle(
        nomParcelle: nom,
        description: description,
        surface: surface,
        latitude: latitude,
        longitude: longitude,
      );
      state = const AsyncValue.data(null);
      return parcelle;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }
}

final parcelleNotifierProvider =
    StateNotifierProvider<ParcelleNotifier, AsyncValue<void>>(
  (ref) => ParcelleNotifier(ref.read(parcelleRepositoryProvider)),
);
