import 'dart:convert';

import 'package:flutter/services.dart';

class ModelVersionInfo {
  const ModelVersionInfo({
    required this.version,
    required this.date,
    required this.maladiesSupportees,
  });

  final String version;
  final String date;
  final List<String> maladiesSupportees;
}

class ModelVersionService {
  ModelVersionService._();

  static final ModelVersionService instance = ModelVersionService._();

  Future<ModelVersionInfo> load() async {
    final rawJson =
        await rootBundle.loadString('assets/model/model_version.json');
    final json = jsonDecode(rawJson) as Map<String, dynamic>;

    final maladies =
        (json['maladies_supportees'] as List<dynamic>? ?? const <dynamic>[])
            .map((item) => item.toString())
            .toList();

    return ModelVersionInfo(
      version: json['version']?.toString() ?? 'inconnue',
      date: json['date']?.toString() ?? 'inconnue',
      maladiesSupportees: maladies,
    );
  }
}
