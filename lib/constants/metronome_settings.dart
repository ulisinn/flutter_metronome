class MetronomeVolume {
  static const double strongBeatVolume = 1.0;
  static const double weakBeatVolume = 0.6;
}

class MetronomeDuration {
  static const double min = 30.0;
  static const double max = 600.0;
}

class MetronomeMarkings {
  static double lowerBorder = MetronomeMarkings.mmList[0];
  static double upperBorder =
      MetronomeMarkings.mmList[MetronomeMarkings.mmList.length - 1];
  static const mmList = <double>[
    40,
    42,
    44,
    46,
    48,
    50,
    52,
    54,
    56,
    58,
    60,
    63,
    66,
    69,
    72,
    76,
    80,
    84,
    88,
    92,
    96,
    100,
    104,
    108,
    112,
    116,
    120,
    126,
    126,
    132,
    138,
    144,
    152,
    160,
    168,
    176,
    184,
    200,
    208,
    216,
    224,
    232,
    240,
  ];

  static String tempoName(int tempo) {
    String? tempoName = '';
    if (tempo < 40) {
      tempoName = 'Grave';
    } else if (tempo < 50) {
      tempoName = 'Largo';
    } else if (tempo < 66) {
      tempoName = 'Larghetto';
    } else if (tempo < 73) {
      tempoName = 'Adagio';
    } else if (tempo < 77) {
      tempoName = 'Andante';
    } else if (tempo < 83) {
      tempoName = 'Andantino';
    } else if (tempo < 97) {
      tempoName = 'Moderato';
    } else if (tempo < 109) {
      tempoName = 'Allegretto';
    } else if (tempo < 132) {
      tempoName = 'Allegro';
    } else if (tempo < 140) {
      tempoName = 'Vivace';
    } else if (tempo < 177) {
      tempoName = 'Presto';
    } else {
      tempoName = 'Prestissimo';
    }

    return tempoName.isEmpty ? 'Moderato' : tempoName;
  }
}
