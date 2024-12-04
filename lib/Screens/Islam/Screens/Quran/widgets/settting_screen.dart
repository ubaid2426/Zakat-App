import 'package:flutter/material.dart';

class QuranSetting extends StatefulWidget {
  const QuranSetting({super.key});

  @override
  State<QuranSetting> createState() => _QuranSettingState();
}

class _QuranSettingState extends State<QuranSetting> {
  // State variables
  bool showArabic = true;
  bool showBengaliTranslation = false;
  bool showEnglishTranslation = true;

  double quranFontSize = 21.0;
  double translationFontSize = 17.0;

  String quranFontFamily = "Uthman";
  String translationFontFamily = "Jameel";

  // Dropdown items
  final List<String> fontFamilies = ["Uthman", "Noorehuda", "KFGQPC"];
  final List<String> translationFontFamilies = ["Jameel", "Roboto", "Sans"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quran Styling Option',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Handle back navigation
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Toggle for Arabic text
            SwitchListTile(
              title: const Text("With Arabs"),
              value: showArabic,
              onChanged: (bool value) {
                setState(() {
                  showArabic = value;
                });
              },
            ),

            // Toggle for Bengali Translation
            SwitchListTile(
              title: const Text("Show Bengali Translation"),
              value: showBengaliTranslation,
              onChanged: (bool value) {
                setState(() {
                  showBengaliTranslation = value;
                });
              },
            ),

            // Toggle for English Translation
            SwitchListTile(
              title: const Text("Show English Translation"),
              value: showEnglishTranslation,
              onChanged: (bool value) {
                setState(() {
                  showEnglishTranslation = value;
                });
              },
            ),

            const SizedBox(height: 20),

            // Quran Font Size
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Quran font size"),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (quranFontSize > 10) quranFontSize--;
                        });
                      },
                    ),
                    Text(quranFontSize.toStringAsFixed(1)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (quranFontSize < 40) quranFontSize++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Quran Font Family
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Quran font family"),
                DropdownButton<String>(
                  value: quranFontFamily,
                  items: fontFamilies
                      .map((font) => DropdownMenuItem(
                            value: font,
                            child: Text(font),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      quranFontFamily = value!;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Translation Font Size
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Translation font size"),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          if (translationFontSize > 10) translationFontSize--;
                        });
                      },
                    ),
                    Text(translationFontSize.toStringAsFixed(1)),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          if (translationFontSize < 40) translationFontSize++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),

            // Translation Font Family
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Translation font family"),
                DropdownButton<String>(
                  value: translationFontFamily,
                  items: translationFontFamilies
                      .map((font) => DropdownMenuItem(
                            value: font,
                            child: Text(font),
                          ))
                      .toList(),
                  onChanged: (String? value) {
                    setState(() {
                      translationFontFamily = value!;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
