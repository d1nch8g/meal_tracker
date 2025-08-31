// import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class LocalRepository {
  // static const ivKey1 = '222';
  // static const ivKey2 = '111';
  // static const privateKey = '6666666666';
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  // static String __encrypt(String text) {
  //   final encrypterAES = encrypt.Encrypter(encrypt.AES(encrypt.Key.fromBase64(privateKey), mode: encrypt.AESMode.cbc));
  //   final encryptedAES = encrypterAES.encrypt(text, iv: encrypt.IV.fromBase64('$ivKey1$ivKey2'));
  //   return encryptedAES.base64;
  // }

  // static String __decrypt(String text) {
  //   if (text.isEmpty) return text;

  //   final encrypterAES = encrypt.Encrypter(
  //     encrypt.AES(
  //       encrypt.Key.fromBase64(privateKey),
  //       mode: encrypt.AESMode.cbc,
  //     ),
  //   );
  //   final decryptedAES = encrypterAES.decrypt(
  //     encrypt.Encrypted.fromBase64(text),
  //     iv: encrypt.IV.fromBase64('$ivKey1$ivKey2'),
  //   );
  //   return decryptedAES;
  // }

  Future<void> write({required String key, required String value}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      key,
      value, //  __encrypt(value),
    );
  }

  Future<String?> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final val = prefs.getString(key);
    if (val == null) return null;
    return val //__decrypt(val)
        ;
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
