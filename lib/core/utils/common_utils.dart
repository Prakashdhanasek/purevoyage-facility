import 'dart:convert';

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:encrypt/encrypt.dart' as crypto;

crypto.IV iv = crypto.IV.fromLength(16);
String formatIndian(double amount) {
  String formattedAmount = NumberFormat('#,###').format(amount);
  return formattedAmount;
}

String formatWithDollarSymbol(double amount, int fractionDigit) {
  return amount < 0
      ? '-\$${amount.abs().toStringAsFixed(fractionDigit)}'
      : '\$${amount.toStringAsFixed(fractionDigit)}';
}

String formatWithCurrencySymbol(
  String symbol,
  double amount,
  int fractionDigit,
) {
  return amount < 0
      ? '-$symbol${amount.abs().toStringAsFixed(fractionDigit)}'
      : '$symbol${amount.toStringAsFixed(fractionDigit)}';
}

String amountConverter(double amount) {
  String investAmount = '0';
  if (amount >= 10000000) {
    investAmount =
        '${((amount / 10000000)).toStringAsFixed(amount % 10000000 == 0 ? 0 : 2)}Cr';
  } else if (amount >= 100000) {
    investAmount =
        '${((amount / 100000)).toStringAsFixed(amount % 100000 == 0 ? 0 : 2)}L';
  } else if (amount >= 1000) {
    investAmount =
        '${((amount / 1000)).toStringAsFixed(amount % 1000 == 0 ? 0 : 2)}K';
  } else {
    investAmount = amount.toStringAsFixed(amount % 1 == 0 ? 0 : 2).toString();
  }
  return investAmount;
}

String encryptStringForUser(String plaintext, String key) {
  final crypto.IV iv = crypto.IV.fromSecureRandom(16);

  final Uint8List keyBytes = utf8.encode(key);

  final crypto.Key aesKey = crypto.Key(keyBytes);

  final crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(aesKey));

  final crypto.Encrypted encrypted = encrypter.encrypt(plaintext, iv: iv);
  final String encodedIv = base64.encode(iv.bytes);
  final String encodedText = base64.encode(encrypted.bytes);
  return '$encodedIv:$encodedText';
}

String decryptStringForUser(String ciphertext, String key) {
  final List<String> parts = ciphertext.split(':');
  final String encodedIv = parts[0];
  final String encodedText = parts[1];

  final crypto.IV iv = crypto.IV.fromBase64(encodedIv);
  final Uint8List encryptedBytes = base64.decode(encodedText);

  final Uint8List keyBytes = utf8.encode(key);

  final crypto.Key aesKey = crypto.Key(keyBytes);

  final crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(aesKey));

  final List<int> decrypted = encrypter.decryptBytes(
    crypto.Encrypted(encryptedBytes),
    iv: iv,
  );

  return utf8.decode(decrypted);
}

String decryptStringPsa(String val, String keyVal) {
  try {
    final crypto.Key key = crypto.Key.fromUtf8(keyVal);
    final crypto.Encrypter encrypter = crypto.Encrypter(crypto.AES(key));
    final String decrypted = encrypter.decrypt(
      crypto.Encrypted.fromBase64(val),
      iv: iv,
    );
    return decrypted;
  } catch (e) {
    return e.toString();
  }
}

String keyVal(String userId) {
  String keyVal = userId;
  if (keyVal.length < 32) {
    keyVal = keyVal.padRight(32, "0");
  } else if (keyVal.length > 32) {
    keyVal = keyVal.substring(0, 32);
  }
  return keyVal;
}

appLog(String message) {
  if (kDebugMode) {
    print('log: ${message.toString()}');
  }
}

showErrorSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: AppColors.danger),
  );
}

showSuccessSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: AppColors.fmGreen500),
  );
}

showWarning(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), backgroundColor: AppColors.fmGrey300),
  );
}
