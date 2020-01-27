enum University { pwr, uwr, ue, upwr }

extension UniversityExtension on University {
  // ignore: missing_return
  String get name {
    switch (this) {
      case University.pwr:
        return 'Politechnika Wrocławska';
      case University.uwr:
        return 'Uniwersytet Wrocławski';
      case University.ue:
        return 'Uniwersytet Ekonomiczny we Wrocławiu';
      case University.upwr:
        return 'Uniwersytet Przyrodniczy we Wrocławiu';
    }
  }

  // ignore: missing_return
  String get abbreviation {
    switch (this) {
      case University.pwr:
        return 'pwr';
      case University.uwr:
        return 'uwr';
      case University.ue:
        return 'ue';
      case University.upwr:
        return 'upwr';
    }
  }
}
