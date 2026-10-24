
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_in_numbers/controllers/language_controller.dart';
import 'package:life_in_numbers/l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  static const Color _navy = Color(0xFF18344B);
  static const Color _cream = Color(0xFFFFFCF6);
  bool _isSaving = false;

  Future<void> _changeLanguage(String language) async {
    if (_isSaving) return;
    setState(() => _isSaving = true);
    try {
      await LanguageController.instance.setLanguage(language);
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to save language preference.')),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selected = LanguageController.instance.selectedLanguage;

    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(
        title: Text(l10n.settingsTitle, style: GoogleFonts.nunito(fontWeight: FontWeight.w800, color: _navy)),
        backgroundColor: _cream,
        foregroundColor: _navy,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.settingsLanguage, style: GoogleFonts.nunito(fontSize: 24, fontWeight: FontWeight.w900, color: _navy)),
          const SizedBox(height: 8),
          Text(l10n.settingsLanguageDescription, style: GoogleFonts.nunito(fontSize: 15, color: Colors.blueGrey)),
          const SizedBox(height: 22),
          _languageTile('', l10n.settingsSystemDefault, selected),
          _languageTile('en', 'English', selected),
          _languageTile('de', 'Deutsch', selected),
          _languageTile('pt_PT', 'Português (Portugal)', selected),
          _languageTile('es', 'Español', selected),
          _languageTile('fr', 'Français', selected),
        ],
      ),
    );
  }

  Widget _languageTile(String code, String title, String selected) {
    final isSelected = code == selected;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: isSelected ? const Color(0xFFE7EFEA) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: ListTile(
          enabled: !_isSaving,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          title: Text(title, style: GoogleFonts.nunito(fontSize: 17, fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600, color: _navy)),
          trailing: isSelected ? const Icon(Icons.check_circle_rounded, color: Color(0xFF4D806C)) : null,
          onTap: () => _changeLanguage(code),
        ),
      ),
    );
  }
}
