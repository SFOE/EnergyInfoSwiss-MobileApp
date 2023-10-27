

class Constants{

  // base urls
  static const String kApiBaseUrlDev = 'https://dev.energiedashboard.ch/api/';
  static const String kApiBaseUrl = 'https://energiedashboard.admin.ch/api/';
  static const String kWebBaseUrlDev = 'https://dev.energiedashboard.ch';
  static const String kWebBaseUrl = 'https://energiedashboard.admin.ch';

  // nav bar ui
  static const double kNavBarHeight = 73.0;

  // information ui
  static const double kInformationTileHeight = 62;

  // shared preferences keys
  static const String kSharedPrefLanguageKey = 'selected_language_code';
  static const String kSharedPrefFirstUseKey = 'is_first_use';

  // external pages (information tiles)
  static const Map<String, String> externalPages = {
    'energiesparen': 'https://www.nicht-verschwenden.ch/',
    'versorgungslage': 'https://www.bwl.admin.ch/bwl/de/home/themen/energie/energie-aktuelle-lage.html',
    'stromversorgung': 'https://www.bfe.admin.ch/bfe/de/home/versorgung/stromversorgung.html',
    'gasversorgung': 'https://www.bfe.admin.ch/bfe/de/home/versorgung/gasversorgung/gasversorgungsgesetz.html',
    'opendata': 'https://opendata.swiss/de/organization/bundesamt-fur-energie-bfe?q=energiedashboard',
    'integration': 'https://energiedashboard.admin.ch/integration-guide',
    'barrierefreiheit': 'https://energiedashboard.admin.ch/ax-statement',
    'kontakt': 'media@bfe.admin.ch',
    'rechtliches': 'https://www.admin.ch/gov/de/start/rechtliches.html'
  };

  // grid view ui
  static const double kGridViewSpacing = 8.0;
  static const double kGridViewRunSpacing = 8.0;

  // details ui
  static const double kStarIconSize = 23;
  static const double kStarIconAnimationSize = 17;


}