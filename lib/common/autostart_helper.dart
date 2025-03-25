import 'dart:ffi';
import 'dart:io';
import 'package:win32/win32.dart';
import 'package:ffi/ffi.dart';

class AutoStartHelper {
  static const String appName = 'e_hujjat';

  static void enableAutoStart() {
    final startupKey = r'Software\Microsoft\Windows\CurrentVersion\Run';
    final executablePath = Platform.resolvedExecutable;

    final keyName = TEXT(appName);
    final valueStr = TEXT('"$executablePath"');

    final hKeyPtr = calloc<HKEY>();
    final openResult = RegOpenKeyEx(
      HKEY_CURRENT_USER,
      TEXT(startupKey),
      0,
      KEY_ALL_ACCESS,
      hKeyPtr,
    );

    if (openResult == ERROR_SUCCESS) {
      final setResult = RegSetValueEx(
        hKeyPtr.value,
        keyName,
        0,
        REG_SZ,
        valueStr.cast<Uint8>(),
        (valueStr.length + 1) * sizeOf<Uint16>(),
      );

      if (setResult == ERROR_SUCCESS) {
        print('🟢 Avto-startga qo‘shildi: $executablePath');
      } else {
        print('🔴 Qiymat yozishda xatolik: $setResult');
      }

      RegCloseKey(hKeyPtr.value);
    } else {
      print('🔴 Kalitni ochishda xatolik: $openResult');
    }

    // Faqat calloc bo'lgan narsani ozod qilamiz:
    calloc.free(hKeyPtr);
  }

 static bool isInAutostart() {
  final startupKey = r'Software\Microsoft\Windows\CurrentVersion\Run';
  final hKeyPtr = calloc<HKEY>();

  final openResult = RegOpenKeyEx(
    HKEY_CURRENT_USER,
    TEXT(startupKey),
    0,
    KEY_READ,
    hKeyPtr,
  );

  if (openResult != ERROR_SUCCESS) {
    calloc.free(hKeyPtr);
    return false;
  }

  final data = calloc<Uint8>(1024);
  final dataSizePtr = calloc<DWORD>();
  dataSizePtr.value = 1024;

  final result = RegQueryValueEx(
    hKeyPtr.value,
    TEXT(appName),
    nullptr,
    nullptr,
    data,
    dataSizePtr,
  );

  calloc.free(hKeyPtr);
  calloc.free(data);
  calloc.free(dataSizePtr);

  return result == ERROR_SUCCESS;
}

}
