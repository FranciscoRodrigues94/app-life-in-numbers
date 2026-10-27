
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:life_in_numbers/l10n/app_localizations.dart';
import 'package:life_in_numbers/features/settings/pages/settings_page.dart';
import 'package:life_in_numbers/widgets/mascot_widget.dart';


class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key, required this.onCompleted});
  final VoidCallback onCompleted;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static const Color _navy = Color(0xFF18344B);
  static const Color _muted = Color(0xFF83868A);
  static const Color _cream = Color(0xFFFFFCF6);
  final TextEditingController _nameController = TextEditingController();
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();
  bool _isSaving = false;
  String? _error;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _openSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsPage(),
      ),
    );
  }

  Future<void> _continue() async {
    if (_isSaving) return;
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() => _error = l10n.welcomeNameRequired);
      return;
    }

    FocusScope.of(context).unfocus();
    setState(() {
      _isSaving = true;
      _error = null;
    });

    try {
      await _preferences.setString('life_user_name', name);
      await _preferences.setBool('life_welcome_completed', true);
      if (mounted) widget.onCompleted();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isSaving = false;
        _error = AppLocalizations.of(context)!.welcomeSaveError;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final mascotHeight = (MediaQuery.sizeOf(context).height * 0.32).clamp(180.0, 310.0);

    return Scaffold(
      backgroundColor: _cream,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(25, 22, 25, 26),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight - 48),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        const _WelcomeLogo(),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            key: const Key('welcome_language_button'),
                            tooltip: 'Language',
                            icon: const Icon(
                              Icons.language_rounded,
                              color: _navy,
                              size: 27,
                            ),
                            onPressed: _openSettings,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Spacer(),
                    Center(
                      child: MascotWidget(size: mascotHeight),
                    ),
                    const Spacer(),
                    Text(
                      l10n.welcomeHello,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 53,
                        fontWeight: FontWeight.w900,
                        color: _navy,
                        height: 1,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        l10n.welcomeTitle,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunito(
                          fontSize: 23,
                          fontWeight: FontWeight.w800,
                          color: _navy,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l10n.welcomeDescription,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.nunito(
                        fontSize: 17,
                        height: 1.3,
                        color: _muted,
                      ),
                    ),
                    const SizedBox(height: 26),
                    TextField(
                      key: const Key('welcome_name_field'),
                      controller: _nameController,
                      maxLength: 40,
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.done,
                      onSubmitted: (_) => _continue(),
                      onChanged: (_) {
                        if (_error != null) {
                          setState(() => _error = null);
                        }
                      },
                      style: GoogleFonts.nunito(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: _navy,
                      ),
                      decoration: InputDecoration(
                        counterText: '',
                        hintText: l10n.welcomeNameHint,
                        hintStyle: GoogleFonts.nunito(
                          color: _muted,
                          fontSize: 17,
                        ),
                        prefixIcon: const Icon(
                          Icons.person_outline_rounded,
                          color: _muted,
                          size: 26,
                        ),
                        filled: true,
                        fillColor: _cream,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: const BorderSide(
                            color: Color(0xFFE3E0D8),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21),
                          borderSide: const BorderSide(
                            color: _navy,
                            width: 1.5,
                          ),
                        ),
                        errorText: _error,
                      ),
                    ),
                    const SizedBox(height: 13),
                    SizedBox(
                      width: double.infinity,
                      height: 59,
                      child: FilledButton(
                        key: const Key('welcome_continue_button'),
                        onPressed: _isSaving ? null : _continue,
                        style: FilledButton.styleFrom(
                          backgroundColor: _navy,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                        ),
                        child: _isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Colors.white,
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n.welcomeContinue,
                                    style: GoogleFonts.nunito(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 24,
                                  ),
                                ],
                              ),
                      ),
                    ),
                    const SizedBox(height: 29),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _PageDot(selected: true),
                        SizedBox(width: 13),
                        _PageDot(selected: false),
                        SizedBox(width: 13),
                        _PageDot(selected: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomeLogo extends StatelessWidget {
  const _WelcomeLogo();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 35,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 13,
                height: 17,
                decoration: BoxDecoration(
                  color: const Color(0xFFF7BC7B),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 13,
                height: 25,
                decoration: BoxDecoration(
                  color: const Color(0xFF91AB97),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 4),
              Container(
                width: 13,
                height: 35,
                decoration: BoxDecoration(
                  color: const Color(0xFF355B77),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 9),
        Text(
          'LIFE IN NUMBERS',
          style: GoogleFonts.nunito(
            fontSize: 15,
            fontWeight: FontWeight.w900,
            letterSpacing: 3.4,
            color: const Color(0xFF18344B),
          ),
        ),
      ],
    );
  }
}

class _PageDot extends StatelessWidget {
  const _PageDot({required this.selected});
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? const Color(0xFF355B77)
            : const Color(0xFFDCDCD7),
      ),
    );
  }
}
