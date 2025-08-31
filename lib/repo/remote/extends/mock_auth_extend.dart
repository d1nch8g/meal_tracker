import 'package:meal_tracker/domain/user.dart';
import 'package:meal_tracker/repo/remote/rest_repository.dart';

extension MockAuthExtend on RestRepository {
  // Future<User> authorizeByQR({
  //   required String qr,
  // }) async {
  //   await Future.delayed(const Duration(milliseconds: 1800));

  //   return User(login: 'login', token: 'token', email: 'email', firstName: 'firstName', lastName: 'lastName', phone: 'phone', timeZone: 3);
  // }

  Future<User> authorizeByLogin({required String login, required String password}) async {
    await Future.delayed(const Duration(milliseconds: 800));

    return User(id: 'userId', login: login, name: 'Steve Johns');
  }

  Future<void> validateToken({required String token, String? mobileVersion}) async {
    if (token != 'token') {
      throw Exception();
    }
  }
}
