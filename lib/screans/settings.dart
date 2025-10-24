import 'package:flutter/material.dart';

// Define a consistent color scheme
const Color _kBrownColor = Color(0xFF6BC015);
const Color _kAccentColor = Color(0xFF6BC015); // A complementary accent color

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Function to show a generic information dialog
  void _showInfoDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close', style: TextStyle(color: _kAccentColor)),
          ),
        ],
      ),
    );
  }

  // A helper widget for the common list tile structure
  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    Color iconColor = _kBrownColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle) : null,
      // Default trailing icon
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(color: _kBrownColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: _kBrownColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          // --- App Information Section Header ---
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Text(
              'App Information',
              style: TextStyle(
                color: _kBrownColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(color: Color(0xFF6BC015)),

          // 1. Data Processor Tile (Gemini)
          _buildSettingsTile(
            icon: Icons.psychology_outlined,
            title: 'Data Processor',
            subtitle:
                'All calculation and data processing is powered by **Gemini**.',
            trailing: const Icon(Icons.info_outline, color: _kAccentColor),
            iconColor: _kAccentColor,
            onTap: () {
              // Re-using the original Gemini dialog logic
              _showInfoDialog(
                context: context,
                title: 'Gemini Processor',
                content:
                    'This application uses the Google **Gemini API** for intelligent data processing, such as calorie calculation and information retrieval.',
              );
            },
          ),

          const Divider(color: Color(0xFF6BC015)),

          // 2. About Tile (Now shows a dialog)
          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'About',
            iconColor: Colors.grey,
            onTap: () {
              _showInfoDialog(
                context: context,
                title: 'About This App',
                content:
                    'This application is designed to help you track your data efficiently using intelligent processing from the Gemini API. We are committed to providing a seamless and powerful user experience.',
              );
            },
          ),

          // 3. Privacy Policy Tile (Now shows a dialog)
          _buildSettingsTile(
            icon: Icons.policy_outlined,
            title: 'Privacy Policy',
            iconColor: Colors.grey,
            onTap: () {
              _showInfoDialog(
                context: context,
                title: 'Privacy Policy Summary',
                content:
                    'We do not collect any personally identifiable information. All data processing handled by the Gemini API is done in accordance with Google\'s security and privacy standards. Your data stays private on your device.',
              );
            },
          ),

          const Divider(color: Color(0xFF6BC015)),

          // --- App Version and Developer Info ---
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Color(0xFF6BC015), fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Developed by Hazem Al-Sujaee (Age 14)',
                  style: TextStyle(
                    color: Color(0xFF6BC015),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
