enum University { pwr, uwr, ue, upwr }

extension UniversityExtension on University {
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
      default:
        return null;
    }
  }
}
