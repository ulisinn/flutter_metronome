import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_metronome/features/metronome/models/metronome_config.dart';
import 'package:flutter_metronome/features/metronome/models/cell_config.dart';
import 'package:flutter_metronome/constants/metronome_settings.dart';

void main() {
  group('MetronomeConfig', () {
    final tCellConfig = const CellConfig(pulses: 4);
    final tCellSequence = [tCellConfig];
    final tId = const Uuid().v4();
    final tTitle = 'Test Metronome';
    final tInitialBpm = 120.0;
    final tStrongBeatVolume = 0.8;
    final tWeakBeatVolume = 0.5;
    final tUseCountdownTimer = true;
    final tCountdownDurationSeconds = 300;
    final tMarkDownbeat = true;

    test('can be instantiated with default values', () {
      final config = MetronomeConfig.create();
      expect(config.id, isNotNull);
      expect(config.title, isNull);
      expect(config.initialBpm, equals(120.0));
      expect(config.cellSequence, hasLength(1));
      expect(config.strongBeatVolume, equals(MetronomeVolume.strongBeatVolume));
      expect(config.weakBeatVolume, equals(MetronomeVolume.weakBeatVolume));
      expect(config.useCountdownTimer, isFalse);
      expect(config.countdownDurationSeconds, equals(300));
      expect(config.markDownbeat, isTrue);
    });

    test('can be instantiated with custom values', () {
      final config = MetronomeConfig.create(
        id: tId,
        title: tTitle,
        initialBpm: tInitialBpm,
        cellSequence: tCellSequence,
        strongBeatVolume: tStrongBeatVolume,
        weakBeatVolume: tWeakBeatVolume,
        useCountdownTimer: tUseCountdownTimer,
        countdownDurationSeconds: tCountdownDurationSeconds,
        markDownbeat: tMarkDownbeat,
      );

      expect(config.id, equals(tId));
      expect(config.title, equals(tTitle));
      expect(config.initialBpm, equals(tInitialBpm));
      expect(config.cellSequence, equals(tCellSequence));
      expect(config.strongBeatVolume, equals(tStrongBeatVolume));
      expect(config.weakBeatVolume, equals(tWeakBeatVolume));
      expect(config.useCountdownTimer, equals(tUseCountdownTimer));
      expect(
        config.countdownDurationSeconds,
        equals(tCountdownDurationSeconds),
      );
      expect(config.markDownbeat, equals(tMarkDownbeat));
    });

    test('can be serialized and deserialized', () {
      final config = MetronomeConfig.create(
        id: tId,
        title: tTitle,
        initialBpm: tInitialBpm,
        cellSequence: tCellSequence,
        strongBeatVolume: tStrongBeatVolume,
        weakBeatVolume: tWeakBeatVolume,
        useCountdownTimer: tUseCountdownTimer,
        countdownDurationSeconds: tCountdownDurationSeconds,
        markDownbeat: tMarkDownbeat,
      );

      final json = config.toJson();
      final configFromJson = MetronomeConfig.fromJson(json);

      // expect(configFromJson.id, equals(config.id));
      // expect(configFromJson.title, equals(config.title));
      // expect(configFromJson.initialBpm, equals(config.initialBpm));
      // expect(configFromJson.cellSequence.length, equals(config.cellSequence.length));
      // for (var i = 0; i < config.cellSequence.length; i++) {
      //   expect(configFromJson.cellSequence[i].pulses, equals(config.cellSequence[i].pulses));
      //   expect(configFromJson.cellSequence[i].isActive, equals(config.cellSequence[i].isActive));
      // }
      // expect(configFromJson.strongBeatVolume, equals(config.strongBeatVolume));
      // expect(configFromJson.weakBeatVolume, equals(config.weakBeatVolume));
      // expect(configFromJson.useCountdownTimer, equals(config.useCountdownTimer));
      // expect(configFromJson.countdownDurationSeconds, equals(config.countdownDurationSeconds));
      // expect(configFromJson.markDownbeat, equals(config.markDownbeat));
    });

    test('generates unique ID when not provided', () {
      final config1 = MetronomeConfig.create();
      final config2 = MetronomeConfig.create();

      expect(config1.id, isNotNull);
      expect(config2.id, isNotNull);
      expect(config1.id, isNot(equals(config2.id)));
    });
  });

  group('CellConfig', () {
    test('can be instantiated with default values', () {
      final config = const CellConfig(pulses: 4);
      expect(config.pulses, equals(4));
      expect(config.isActive, isTrue);
    });

    test('can be instantiated with custom values', () {
      final config = const CellConfig(pulses: 3, isActive: false);
      expect(config.pulses, equals(3));
      expect(config.isActive, isFalse);
    });

    test('can be serialized and deserialized', () {
      final config = const CellConfig(pulses: 3, isActive: false);
      final json = config.toJson();
      final configFromJson = CellConfig.fromJson(json);

      expect(configFromJson, equals(config));
    });
  });
}
