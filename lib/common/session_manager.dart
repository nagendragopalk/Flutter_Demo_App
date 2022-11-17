import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  // login authentication
  static Future setRememberMe(bool rememberMe) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', rememberMe);
  }

  static Future getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberMe = prefs.getBool('rememberMe');
    if (rememberMe == null) {
      return false;
    } else {
      return rememberMe;
    }
  }
// // Faceid or Figerprinth authentication
//   static Future setFaceID(String faceID) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('faceID', faceID);
//   }

//   static Future getFaceID() async {
//     final prefs = await SharedPreferences.getInstance();
//     final faceID = prefs.getString('faceID');
//     if (faceID == null) {
//       return false;
//     }
//     return faceID;
//   }

//   static Future setLoggedInUser(bool isLoggedInUser) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isLoggedInUser', isLoggedInUser);
//   }

//   static Future getLoggedInUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     final loggedInUser = prefs.getBool('isLoggedInUser');
//     if (loggedInUser == null) {
//       return false;
//     }
//     return loggedInUser;
//   }

//   static Future setUserID(String userID) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userID', userID);
//   }

//   static Future getUserID() async {
//     final prefs = await SharedPreferences.getInstance();
//     final user = prefs.getString('userID');
//     if (user == null) {
//       return ' ';
//     }
//     return user;
//   }

  static Future setAccessToken(String? accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken!);
  }

  static Future getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accessToken');
    if (accessToken == null) {
      return '';
    } else {
      return accessToken;
    }
  }

  static Future setRefreshToken(String? refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('refreshToken', refreshToken!);
  }

  static Future getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    if (refreshToken == null) {
      return '';
    } else {
      return refreshToken;
    }
  }

  static Future setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }

  static Future getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username == null) {
      return '';
    } else {
      return username;
    }
  }

  static Future setUserProfile(String userProfile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userProfile', userProfile);
  }

  static Future getUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userProfile = prefs.getString('userProfile');
    if (userProfile == null) {
      return '';
    } else {
      return userProfile;
    }
  }

  static Future setCounter(int? counter) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', counter!);
  }

  static Future getCounter() async {
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getInt('counter');
    if (counter == null) {
      return 0;
    } else {
      return counter;
    }
  }

  static Future setPermissions(List<String> permissions) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('permissions', permissions);
  }

  static Future getPermissions() async {
    final prefs = await SharedPreferences.getInstance();
    print("Printing Prefs: ${prefs.getStringList('permissions')}");
    if (prefs.getStringList('permissions') != null) {
      final permissions = prefs.getStringList('permissions');
      return permissions;
    } else {
      final permissions = [''];
      return permissions;
    }
  }
}
