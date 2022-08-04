abstract class PrefsRepo {
  Future<void> changeCrossAxis();
  Future<void> changeTheme(String theme);
  Future<void> changeLanguage(String language);
}
