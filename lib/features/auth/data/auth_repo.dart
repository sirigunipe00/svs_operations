
import 'package:svs_operations/core/utils/typedefs.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';


abstract interface class AuthRepo {
  Future<bool> isLoggedIn();
  AsyncValueOf<LoggedInUser> logIn(String username,String pswd);
  AsyncValueOf<LoggedInUser> getPersistedUser();
  AsyncValueOf<bool> signOut();
}
