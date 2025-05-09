import 'package:collection/collection.dart';
import 'package:flutter_metronome/features/metronome/data/metronome_repository_interface.dart';
import 'package:flutter_metronome/features/metronome/models/metronome_config.dart';

class MockMetronomeRepository implements IMetronomeRepository {
  final List<MetronomeConfig> _configs = [];

  @override
  Future<void> addMetronomeConfig(MetronomeConfig config) async {
    final newConfig = config.copyWith(id: 'test-${_configs.length}');
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
    try {
      return _configs.firstWhere((config) => config.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearAllConfigs() async {
    _configs.clear();
  }
}
