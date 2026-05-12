import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/journal_entry_model.dart';

class JournalLocalDatasource {
  JournalLocalDatasource(this._preferences);

  JournalLocalDatasource.inMemory() : _preferences = null;

  final SharedPreferences? _preferences;

  static const _storageKey = 'journal_entries_v1';
  static String? _memoryStorage;

  String? _readRaw() {
    return _preferences?.getString(_storageKey) ?? _memoryStorage;
  }

  List<JournalEntryModel> readEntries() {
    final raw = _readRaw();
    if (raw == null || raw.isEmpty) {
      return const [];
    }

    final decoded = jsonDecode(raw);
    if (decoded is! List) {
      return const [];
    }

    final entries = decoded
        .whereType<Map<Object?, Object?>>()
        .map((entry) => entry.map(
              (key, value) => MapEntry(
                key.toString(),
                value,
              ),
            ))
        .map(JournalEntryModel.fromJson)
        .toList();

    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  Future<void> saveEntry(JournalEntryModel entry) async {
    final entries = readEntries();
    final next = [entry, ...entries];

    final payload = jsonEncode(next.map((e) => e.toJson()).toList());

    final ok = _preferences == null
        ? (() {
            _memoryStorage = payload;
            return true;
          })()
        : await _preferences!.setString(_storageKey, payload);
    if (!ok) {
      throw const FormatException('Impossible de sauvegarder le journal');
    }
  }
}
