import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_metronome/features/metronome/data/metronome_repository_interface.dart';
import 'package:flutter_metronome/features/metronome/models/metronome_config.dart';
import 'package:flutter_metronome/features/metronome/models/cell_config.dart';
import 'mock_metronome_repository.dart';

void main() {
  late IMetronomeRepository repository;
  late MetronomeConfig testConfig;
  String? testConfigId;

  setUp(() {
    repository = MockMetronomeRepository();
    testConfig = MetronomeConfig(
      id: '',
      title: 'Test Config',
      initialBpm: 120.0,
      cellSequence: [
        CellConfig(pulses: 4, isActive: true),
        CellConfig(pulses: 4, isActive: true),
      ],
      strongBeatVolume: 1.0,
      weakBeatVolume: 0.8,
      useCountdownTimer: false,
      countdownDurationSeconds: 0,
      markDownbeat: true,
    );
  });

  group('IMetronomeRepository', () {
    test('initializes with empty list', () {
      expect(repository.getAllMetronomeConfigs(), isEmpty);
    });

    test('addMetronomeConfig adds new config with unique ID', () async {
      await repository.addMetronomeConfig(testConfig);
      final configs = repository.getAllMetronomeConfigs();

      expect(configs, hasLength(1));
      expect(configs.first.id, isNotEmpty);
      expect(configs.first.title, equals(testConfig.title));
    });

    test('updateMetronomeConfig updates existing config', () async {
      // Add config first
      await repository.addMetronomeConfig(testConfig);
      final configs = repository.getAllMetronomeConfigs();
      testConfigId = configs.first.id;

      // Update config while preserving the ID
      final updatedConfig = testConfig.copyWith(
        id: testConfigId!,
        title: 'Updated Config',
        initialBpm: 130.0,
      );
      await repository.updateMetronomeConfig(updatedConfig);

      final updatedConfigs = repository.getAllMetronomeConfigs();
      expect(updatedConfigs, hasLength(1));
      expect(updatedConfigs.first.title, equals('Updated Config'));
      expect(updatedConfigs.first.initialBpm, equals(130.0));
      expect(updatedConfigs.first.id, equals(testConfigId));
    });

    test(
      'updateMetronomeConfig does nothing for non-existent config',
      () async {
        final nonExistentConfig = testConfig.copyWith(id: 'non-existent');
        await repository.updateMetronomeConfig(nonExistentConfig);
        expect(repository.getAllMetronomeConfigs(), isEmpty);
      },
    );

    test('deleteMetronomeConfig removes existing config', () async {
      // Add config first
      await repository.addMetronomeConfig(testConfig);
      final configs = repository.getAllMetronomeConfigs();
      testConfigId = configs.first.id;

      // Delete config
      await repository.deleteMetronomeConfig(testConfigId!);
      expect(repository.getAllMetronomeConfigs(), isEmpty);
    });

    test(
      'deleteMetronomeConfig does nothing for non-existent config',
      () async {
        await repository.deleteMetronomeConfig('non-existent');
        expect(repository.getAllMetronomeConfigs(), isEmpty);
      },
    );

    test('getAllMetronomeConfigs returns unmodifiable list', () {
      final configs = repository.getAllMetronomeConfigs();
      expect(() => configs.add(testConfig), throwsUnsupportedError);
    });

    test('getMetronomeConfigById returns correct config', () async {
      // Add config first
      await repository.addMetronomeConfig(testConfig);
      final configs = repository.getAllMetronomeConfigs();
      testConfigId = configs.first.id;

      final foundConfig = repository.getMetronomeConfigById(testConfigId!);
      expect(foundConfig, isNotNull);
      expect(foundConfig!.id, equals(testConfigId));
    });

    test('getMetronomeConfigById returns null for non-existent config', () {
      final config = repository.getMetronomeConfigById('non-existent');
      expect(config, isNull);
    });

    test('clearAllConfigs removes all configs', () async {
      // Add multiple configs
      await repository.addMetronomeConfig(testConfig);
      await repository.addMetronomeConfig(
        testConfig.copyWith(title: 'Config 2'),
      );

      // Clear all
      await repository.clearAllConfigs();
      expect(repository.getAllMetronomeConfigs(), isEmpty);
    });
  });
}
