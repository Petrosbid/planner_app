import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../core/localization/app_localizations.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_scope.dart';

class LockScreen extends StatefulWidget {
  final VoidCallback onUnlocked;

  const LockScreen({super.key, required this.onUnlocked});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  final StringBuffer _pinBuffer = StringBuffer();

  bool _biometricAvailable = false;
  bool _isAuthenticating = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initBiometrics());
  }

  Future<void> _initBiometrics() async {
    final settings = AppScope.of(context).settings;
    if (!settings.biometricLockEnabled) return;

    final canCheck = await _auth.canCheckBiometrics;
    final isSupported = await _auth.isDeviceSupported();

    if (!mounted) return;
    setState(() => _biometricAvailable = canCheck && isSupported);

    if (_biometricAvailable) {
      await _unlockWithBiometrics();
    }
  }

  Future<void> _unlockWithBiometrics() async {
    if (_isAuthenticating) return;
    setState(() {
      _isAuthenticating = true;
      _errorText = null;
    });

    try {
      final ok = await _auth.authenticate(
        localizedReason: 'Unlock ZedPlan',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
          useErrorDialogs: true,
        ),
      );
      if (ok && mounted) widget.onUnlocked();
    } catch (_) {
      if (mounted) {
        setState(() => _errorText =
            AppLocalizations.of(context).translate('biometricFailed'));
      }
    } finally {
      if (mounted) {
        setState(() => _isAuthenticating = false);
      }
    }
  }

  void _onDigitTap(int digit) {
    if (_pinBuffer.length >= 4) return;
    setState(() {
      _pinBuffer.write(digit.toString());
      _errorText = null;
    });
    if (_pinBuffer.length == 4) {
      _verifyPin();
    }
  }

  void _onBackspace() {
    if (_pinBuffer.isEmpty) return;
    final current = _pinBuffer.toString();
    setState(() {
      _pinBuffer
        ..clear()
        ..write(current.substring(0, current.length - 1));
      _errorText = null;
    });
  }

  void _verifyPin() {
    final settings = AppScope.of(context).settings;
    final pin = _pinBuffer.toString();
    final ok = settings.verifyLockPin(pin);

    if (ok) {
      widget.onUnlocked();
      return;
    }

    setState(() {
      _pinBuffer.clear();
      _errorText = AppLocalizations.of(context).translate('pinInvalid');
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_rounded, size: 64, color: AppColors.primary),
                  const SizedBox(height: 12),
                  Text(
                    l10n.translate('appLockedTitle'),
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _biometricAvailable
                        ? l10n.translate('scanToUnlock')
                        : l10n.translate('enterPinToUnlock'),
                    style: TextStyle(
                        fontSize: 14, color: AppColors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  if (_biometricAvailable)
                    FilledButton.icon(
                      onPressed:
                          _isAuthenticating ? null : _unlockWithBiometrics,
                      icon: const Icon(Icons.fingerprint_rounded),
                      label: Text(l10n.translate('unlockWithBiometric')),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (i) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: i < _pinBuffer.length
                              ? AppColors.primary
                              : AppColors.outlineVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _PinPad(onDigit: _onDigitTap, onBackspace: _onBackspace),
                  if (_errorText != null) ...[
                    const SizedBox(height: 12),
                    Text(_errorText!,
                        style: const TextStyle(color: AppColors.error)),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PinPad extends StatelessWidget {
  final ValueChanged<int> onDigit;
  final VoidCallback onBackspace;

  const _PinPad({required this.onDigit, required this.onBackspace});

  @override
  Widget build(BuildContext context) {
    final rows = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
    ];

    return Column(
      children: [
        for (final row in rows)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: row
                  .map(
                    (d) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: _PinButton(
                          label: d.toString(), onTap: () => onDigit(d)),
                    ),
                  )
                  .toList(),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 64, height: 56),
            _PinButton(label: '0', onTap: () => onDigit(0)),
            _PinButton(icon: Icons.backspace_outlined, onTap: onBackspace),
          ],
        ),
      ],
    );
  }
}

class _PinButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  const _PinButton({this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 56,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: OutlinedButton(
          onPressed: onTap,
          child: icon != null
              ? Icon(icon, size: 20)
              : Text(label!, style: const TextStyle(fontSize: 18)),
        ),
      ),
    );
  }
}
