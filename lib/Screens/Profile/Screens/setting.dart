// settings.dart
import 'package:flutter/material.dart';
import 'package:sadqahzakat/Screens/Profile/Screens/Settings/currency_converter.dart';
// import 'package:zakat_app/Screens/Profile/Screens/Settings/currency_converter.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Arabic', 'Urdu'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF33A248), // First color (#33A248)
                Color(0xFFB2EA50), // Second color (#B2EA50)
              ],
              begin: Alignment.topRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'General Settings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Dark Mode Switch
            SwitchListTile(
              title: const Text('Dark Mode'),
              value: _darkMode,
              activeColor: const Color(0xFF7fc23a),
              onChanged: (bool value) {
                setState(() {
                  _darkMode = value;
                });
              },
              secondary: const Icon(Icons.dark_mode),
            ),
            const Divider(),

            // Notifications Switch
            SwitchListTile(
              activeColor: const Color(0xFF7fc23a),
              title: const Text('Enable Notifications'),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              secondary: const Icon(Icons.notifications),
            ),
            const Divider(),

            // Language Dropdown
            const Text(
              'Language',
              style: TextStyle(fontSize: 16),
            ),
            DropdownButton<String>(
              value: _selectedLanguage,
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: _languages.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Currency Converter Button
            const Text(
              'Currency Converter',
              style: TextStyle(fontSize: 16),
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on, color: Color(0xFF7fc23a)),
              title: const Text('Open Currency Converter'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigate to currency converter screen
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CurrencyConverterScreen()),
                );
              },
            ),
            const SizedBox(height: 30),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Logic to save settings
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Settings saved!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7fc23a),
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


