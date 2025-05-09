import '../models/metronome_config.dart';

abstract class IMetronomeRepository {
  Future<void> addMetronomeConfig(MetronomeConfig config);
  Future<void> updateMetronomeConfig(MetronomeConfig config);
  Future<void> deleteMetronomeConfig(String id);
  List<MetronomeConfig> getAllMetronomeConfigs();
  MetronomeConfig? getMetronomeConfigById(String id);
  Future<void> clearAllConfigs();
}
