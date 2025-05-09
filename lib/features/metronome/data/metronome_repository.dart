import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

import 'metronome_repository_interface.dart';
import '../../../constants/mock_metronomeSettingsList.dart';
import '../models/metronome_config.dart';

class MetronomeRepository implements IMetronomeRepository {
  final List<MetronomeConfig> _configs;

  MetronomeRepository(this._configs);

  @override
  Future<void> addMetronomeConfig(MetronomeConfig config) async {
    final newConfig = config.copyWith(id: const Uuid().v4());
    _configs.add(newConfig);
  }

  @override
  Future<void> updateMetronomeConfig(MetronomeConfig config) async {
    final index = _configs.indexWhere((c) => c.id == config.id);
    if (index != -1) {
      _configs[index] = config;
    }
  }

  @override
  Future<void> deleteMetronomeConfig(String id) async {
    _configs.removeWhere((config) => config.id == id);
  }

  @override
  List<MetronomeConfig> getAllMetronomeConfigs() {
    return List.unmodifiable(_configs);
  }

  @override
  MetronomeConfig? getMetronomeConfigById(String id) {
    return _configs.firstWhereOrNull((config) => config.id == id);
  }

  @override
  Future<void> clearAllConfigs() async {
    _configs.clear();
  }
}
