import 'dart:math';
import 'package:get/get.dart';
import 'package:sudarshan_creations/shared/firebase.dart';

bool isLoggedIn() => FBAuth.auth.currentUser != null;
const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomId(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

capilatlizeFirstLetter(String text) {
  final splitList = text.trim().split(" ");
  List<String> capilatlizedString = [];
  for (var element in splitList) {
    capilatlizedString.addIf(
        element.capitalizeFirst != null, element.capitalize!);
  }
  return capilatlizedString.join(" ");
}
    
/* import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sudarshan_creations/shared/theme.dart';
import 'firebase.dart';
import 'router.dart';

bool isLoggedIn() => FBAuth.auth.currentUser != null;

List<String> dayList = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomId(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Future<String?> uploadVendorImage(
    SelectedImage imageFile, String? vendorDocId) async {
  try {
    final imageRef = FBStorage.fbstore
        .ref()
        .child(vendorDocId ?? "")
        .child('images')
        .child(
            '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');

    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> uploadPdfFile(
    FilePickerResult? imageFile, String vendorDocId) async {
  final pdfFile = imageFile?.files.first;
  if (pdfFile != null) {
    try {
      final imageRef = FBStorage.fbstore
          .ref()
          .child(vendorDocId)
          .child('pdf')
          .child(
              '${DateTime.now().millisecondsSinceEpoch}.${pdfFile.extension}');
      final task = await imageRef.putData(pdfFile.bytes!);
      return await task.ref.getDownloadURL();
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  } else {
    return null;
  }
}

Future<String?> uploadHighlightImage(
    SelectedImage imageFile, String? vendorDocId) async {
  try {
    final imageRef = FBStorage.fbstore
        .ref()
        .child(vendorDocId ?? "")
        .child('highlightimages')
        .child(
            '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');

    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

showAppSnack(String message,
    {SNACKBARTYPE snackbartype = SNACKBARTYPE.normal, Duration? duration}) {
  try {
    return Flushbar(
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: _getIconColor(snackbartype),
      ),
      backgroundColor: _getColor(snackbartype),
      duration: duration ?? const Duration(seconds: 3),
      leftBarIndicatorColor: _getIconColor(snackbartype),
    ).show(appRouter.configuration.navigatorKey.currentContext!);
  } catch (e) {
    debugPrint(e.toString());
  }
}

Color _getIconColor(SNACKBARTYPE snackbartype) {
  switch (snackbartype) {
    case SNACKBARTYPE.error:
      return Colors.grey.shade200;
    default:
      return themeColor;
  }
}

Color _getColor(SNACKBARTYPE snackbartype) {
  switch (snackbartype) {
    case SNACKBARTYPE.error:
      return Colors.red.shade700;
    default:
      return Colors.black;
  }
}

enum SNACKBARTYPE {
  normal,
  error,
}

Future<String?> uploadFile(SelectedImage imageFile) async {
  try {
    final imageRef = FBStorage.category.child(
        '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');
    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> uploadBannerFile(SelectedImage imageFile) async {
  try {
    final imageRef = FBStorage.banners.child(
        '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');
    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> uploadAmenityFile(SelectedImage imageFile) async {
  try {
    final imageRef = FBStorage.amenity.child(
        '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');
    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> uploadCategoryFile(SelectedImage imageFile) async {
  try {
    final imageRef = FBStorage.category.child(
        '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');
    final task = await imageRef.putData(imageFile.uInt8List);
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

Future<String?> uploadFileFood(SelectedImage imageFile) async {
  try {
    final imageRef = FBStorage.food.child(
        '${DateTime.now().millisecondsSinceEpoch}.${imageFile.extention}');
    final task = await imageRef.putData(
        imageFile.uInt8List,
        SettableMetadata(
          contentType: 'image/${imageFile.extention}',
        ));
    return await task.ref.getDownloadURL();
  } on Exception catch (e) {
    debugPrint(e.toString());
    return null;
  }
}

extension MetaWid on DateTime {
  String goodDate() {
    try {
      return DateFormat.yMMMM().format(this);
    } catch (e) {
      return toString().split(" ").first;
    }
  }

  String goodDayDate() {
    try {
      return DateFormat.yMMMMd().format(this);
    } catch (e) {
      return toString().split(" ").first;
    }
  }

  String convertToDDMMYY() {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(this);
  }

  String goodTime() {
    try {
      return DateFormat('hh:mm a').format(this);
    } catch (e) {
      return toString().split(" ").first;
    }
  }
}

InputDecoration textfieldDecoration() {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(6)),
  );
}

Future<dynamic> showDragableSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
      // showDragHandle: true,
      backgroundColor: Colors.grey[200],
      useRootNavigator: true,
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => DraggableScrollableSheet(
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                controller: scrollController,
                child: child,
              );
            },
          ));
}

InputDecoration textFieldDecoration() {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(6)),
  );
}

InputDecoration settingsTextFieldDecoration() {
  return InputDecoration(
    fillColor: Colors.grey.shade100,
    filled: true,
    border: OutlineInputBorder(
        borderSide: BorderSide.none, borderRadius: BorderRadius.circular(6)),
  );
}

// showAppSnack(String message,
//     {SNACKBARTYPE snackbartype = SNACKBARTYPE.normal, Duration? duration}) {
//   try {
//     return Flushbar(
//       message: message,
//       icon: Icon(
//         Icons.info_outline,
//         size: 28.0,
//         color: _getIconColor(snackbartype),
//       ),
//       backgroundColor: _getColor(snackbartype),
//       duration: duration ?? const Duration(seconds: 3),
//       leftBarIndicatorColor: _getIconColor(snackbartype),
//     ).show(appRouter.configuration.navigatorKey.currentContext!);
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }

InputDecoration inpDecor() {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    filled: true,
    fillColor: Colors.white,
    // fillColor: Colors.white,
  );
}

InputDecoration inpDecorDisabled() {
  return InputDecoration(
    enabled: false,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    // labelStyle: const TextStyle(color: Colors.black)
    labelStyle: const TextStyle(color: Colors.black),
    filled: true,
    fillColor: Colors.white,
  );
}

Row headerTile(String title, [bool button = false, Function? onPressed]) {
  return Row(
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          decoration: BoxDecoration(
            border: const Border(left: BorderSide(color: themeColor, width: 2)),
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4)),
            gradient: LinearGradient(colors: [
              themeColor.withOpacity(.1),
              // Colors.grey.withOpacity(.1),
              Colors.white10,
              // Colors.grey.shade100
            ], stops: const [
              .01,
              .4
            ]),
          ),
          child: Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 12),
              if (button)
                InkWell(
                  onTap: () => onPressed!(),
                  child: const SizedBox(
                      height: 25,
                      width: 25,
                      child: Center(
                        child: Icon(
                          CupertinoIcons.add,
                          size: 23,
                        ),
                      )),
                ),
            ],
          ),
        ),
      ),
    ],
  );
}

Row headerTile2({
  required String title,
  final Widget? trailing,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
          decoration: BoxDecoration(
            border: const Border(left: BorderSide(color: themeColor, width: 2)),
            borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(4)),
            gradient: LinearGradient(colors: [
              themeColor.withOpacity(.1),
              // Colors.grey.withOpacity(.1),
              Colors.white10,
              // Colors.grey.shade100
            ], stops: const [
              .01,
              .4
            ]),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              if (trailing != null) trailing
            ],
          ),
        ),
      ),
    ],
  );
}

List<String> generateCombinations(String text) {
  final combinations = <String>{};
  final splitWords = <String>{};

  // Split the text by space and trim each word
  final words =
      text.toLowerCase().split(' ').map((word) => word.trim()).toList();

  // Add original split words and their first letter/two letters to the output set
  for (final word in words) {
    splitWords.add(word);
    splitWords.add(word[0]); // First letter
    if (word.length > 1) {
      splitWords.add(word.substring(0, 2)); // First two letters
    }
  }

  for (final word in words) {
    final minLength = word.length ~/ 2 + (word.length % 2 == 0 ? 0 : 1);
    for (int i = 0; i < word.length; i++) {
      for (int j = i; j < word.length; j++) {
        final comboLength = j - i + 1;
        if (comboLength > 2 && comboLength >= minLength) {
          combinations.add(word.substring(i, j + 1));

          // Generate combinations with one typo (swapping or missing character)
          if (comboLength > minLength) {
            final swapped = swapChars(word.substring(i, j + 1));
            final missing = removeChar(word.substring(i, j + 1));
            combinations.addAll([swapped, missing]);
          }
        }
      }
    }
  }

  return splitWords.union(combinations).toList();
}

String swapChars(String str) {
  if (str.length < 2) return str;
  final chars = str.split('');
  final temp = chars[0];
  chars[0] = chars[1];
  chars[1] = temp;
  return chars.join('');
}

String removeChar(String str) {
  if (str.length < 2) return str;
  final chars = str.split('');
  chars.removeAt(1);
  return chars.join('');
}

String joinStrings(List<String> strings) {
  return strings.join(', ');
}

List<String> splitString(String input) {
  // Remove any extra spaces
  input = input.replaceAll(RegExp(r'\s+'), '');

  // Split the string by commas
  return input.split(',');
}

// List<String> generateCombinations(String word) {
//   List<String> combinations = [];
//   for (int i = 0; i < word.length; i++) {
//     for (int j = i + 3; j <= word.length; j++) {
//       String substring = word.substring(i, j);
//       if (substring.length > 2) {
//         combinations.add(substring);
//       }
//     }
//   }
//   return combinations;
// }

// List<String> splitString(String myString) {
//   List<String> splittedString =
//       myString.split(" ").map((str) => str.trim()).toList();
//   return splittedString;
// }
 */