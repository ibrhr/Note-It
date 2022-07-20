import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  CacheController._() {
    init();
  }

  static final CacheController _instance = CacheController._();

  static CacheController get instance => _instance;

  late SharedPreferences _sharedPreferences;

  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future setCookie(String token) async {
    await _sharedPreferences.setString('cookie', token);
  }

  String getCookie() {
    return _sharedPreferences.getString('cookie') ?? '';
  }

  Future setDeviceId(String deviceId) async {
    await _sharedPreferences.setString('deviceId', deviceId);
  }

  String getDeviceId() {
    return _sharedPreferences.getString('deviceId') ?? '';
  }

  Future setUserId(int id) async {
    await _sharedPreferences.setInt('userId', id);
  }

  int getUserId() {
    return _sharedPreferences.getInt('userId') ?? -1;
  }

  Future setLangCode(String langCode) async {
    await _sharedPreferences.setString('langCode', langCode);
  }

  String getLangCode() {
    return _sharedPreferences.getString('langCode') ?? 'en';
  }

  Future setToken(String token) async {
    await _sharedPreferences.setString('token', token);
  }

  String getToken() {
    return _sharedPreferences.getString('token') ?? '';
  }

  Future setUserDisplayName(String userDisplayName) async {
    await _sharedPreferences.setString('userDisplayName', userDisplayName);
  }

  String getuserDisplayName() {
    return _sharedPreferences.getString('userDisplayName') ?? '';
  }

  Future setUserEmail(String email) async {
    await _sharedPreferences.setString('email', email);
  }

  String getUserEmail() {
    return _sharedPreferences.getString('email') ?? '';
  }

  Future setAvatarLink(String avatar) async {
    await _sharedPreferences.setString('avatar', avatar);
  }

  String getAvatarLink() {
    return _sharedPreferences.getString('avatar') ??
        "https://secure.gravatar.com/avatar/?s=96&d=mm&r=g";
  }

  Future setAuthed(bool authed) async {
    await _sharedPreferences.setBool('authed', authed);
  }

  bool authenticated() {
    return _sharedPreferences.getBool('authed') ?? false;
  }

  Future setFirstTimeOpenedApp(bool firstTime) async {
    await _sharedPreferences.setBool('first_time', firstTime);
  }

  bool getFirstTimeOpenedApp() {
    return _sharedPreferences.getBool('first_time') ?? true;
  }

  Future setDarkMode(bool isDark) async {
    await _sharedPreferences.setBool('isDark', isDark);
  }

  bool isDarkMode() {
    return _sharedPreferences.getBool('isDark') ?? false;
  }
}
