import 'package:farm_easy/utils/localization/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../utils/Constants/color_constants.dart';

class LanguageSelectionDialog extends StatefulWidget {
  const LanguageSelectionDialog({super.key});

  @override
  _LanguageSelectionDialogState createState() =>
      _LanguageSelectionDialogState();
}

class _LanguageSelectionDialogState extends State<LanguageSelectionDialog> {
  String? selectedLanguage;
  var db = Hive.box('appData');
  final localization = Get.put(LocaleController());

  @override
  void initState() {
    super.initState();
    selectedLanguage = db.get('selectedLanguage') ?? 'English';
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(0xFFF9F9DF),
      title: Text(
        'Select Language'.tr,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose your preferred language:'.tr,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          DropdownButtonHideUnderline(
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10)),
              child: DropdownButton<String>(
                value: selectedLanguage,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                items: ['English', 'Hindi', 'Punjabi'].map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text(
            'Cancel'.tr,
            style: const TextStyle(color: Colors.red),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .pop(selectedLanguage); // Return the selected language
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.DARK_GREEN,
          ),
          child: Text(
            'Save'.tr,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
