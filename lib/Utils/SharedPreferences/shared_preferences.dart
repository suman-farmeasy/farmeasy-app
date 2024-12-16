import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_ACCESS_TOKEN = "PREFS_KEY_ACCESS_TOKEN";
const String PREFS_KEY_REFRESH_TOKEN = "PREFS_KEY_IS_USER_REFRESH_TOKEN";
const String PREFS_KEY_USER_LOGGEDIN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_ROLE_SELECTION = "PREFS_KEY_IS_ROLE_SELECTION";
const String PREFS_KEY_USER_VENUE_ID = "PREFS_KEY_VENUE_ID";
const String PREFS_KEY_USER_NAME = "PREFS_KEY_USER_NAME";
const String PREFS_KEY_USER_TYPE = "PREFS_KEY_USER_TYPE";
const String PREFS_KEY_USER_SELECTION_TYPE = "PREFS_KEY_USER_SELECTION_TYPE";
const String PREFS_KEY_LAND_ID = "PREFS_KEY_LAND_ID";
const String PREFS_KEY_USER_ID = "PREFS_KEY_USER_ID";

class AppPreferences {
  /// FOR TOKEN
  Future<void> setUserRefreshToken(String token) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(PREFS_KEY_REFRESH_TOKEN, token);
  }

  Future<String> getUserRefreshToken() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(PREFS_KEY_REFRESH_TOKEN) ?? "";
  }

  /// FOR USER_ROLE_TYPE
  Future<void> setUserRole(String userRole) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(PREFS_KEY_USER_TYPE, userRole);
  }

  Future<String> getUserRole() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(PREFS_KEY_USER_TYPE) ?? "";
  }

  ///FOR TOKEN
  Future<void> setUserAccessToken(String token) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(PREFS_KEY_ACCESS_TOKEN, token);
  }

  Future<String> getUserAccessToken() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(PREFS_KEY_ACCESS_TOKEN) ?? "";
  }

  ///USER LOGIN
  Future<void> setIsUserLoggedIn() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    print(_sharedPreferences.get(PREFS_KEY_USER_LOGGEDIN));
    _sharedPreferences.setBool(PREFS_KEY_USER_LOGGEDIN, true);
    print(_sharedPreferences.get(PREFS_KEY_USER_LOGGEDIN));
  }

  Future<bool> isUserLoggedIn() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    print(_sharedPreferences.get(PREFS_KEY_USER_LOGGEDIN));
    return _sharedPreferences.getBool(PREFS_KEY_USER_LOGGEDIN) ?? false;
  }

  ///FOR LAND ID
  Future<void> setLandID(int landID) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setInt(PREFS_KEY_LAND_ID, landID);
  }

  Future<int> getLandID() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(PREFS_KEY_LAND_ID) ?? -1;
  }

  Future<void> setUserId(int userId) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setInt(PREFS_KEY_USER_ID, userId);
  }

  Future<int> getUserId() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(PREFS_KEY_USER_ID) ?? -1;
  }

  Future<void> setVenueID(int venueID) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setInt(PREFS_KEY_USER_VENUE_ID, venueID);
  }

  Future<int> getVenueID() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getInt(PREFS_KEY_USER_VENUE_ID) ?? -1;
  }

  Future<void> setUserName(String username) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.setString(PREFS_KEY_USER_NAME, username);
  }

  Future<String> getUserName() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    return _sharedPreferences.getString(PREFS_KEY_USER_NAME) ?? "";
  }

  Future<void> logout() async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    _sharedPreferences.clear();
  }
}
