import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/glass_card.dart';

class LoginAuthScreen extends StatefulWidget {
  final VoidCallback? onLoginSuccess;

  const LoginAuthScreen({super.key, this.onLoginSuccess});

  @override
  State<LoginAuthScreen> createState() => _LoginAuthScreenState();
}

class _LoginAuthScreenState extends State<LoginAuthScreen> {
  final TextEditingController _emailController = TextEditingController(text: 'info@zenplan.com');
  final TextEditingController _passwordController = TextEditingController(text: '••••••••');

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Header
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryContainer.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.spa_rounded, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 16),
                const Text(
                  'زن‌پلان',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'به فضای تمرکز خود خوش آمدید',
                  style: TextStyle(fontSize: 15, color: AppColors.darkOnSurfaceVariant),
                ),
                const SizedBox(height: 32),

                // Form Card
                GlassCard(
                  backgroundColor: AppColors.darkSurface.withValues(alpha: 0.85),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ایمیل یا شماره موبایل',
                        style: TextStyle(fontSize: 13, color: AppColors.darkOnSurfaceVariant),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person_outline, color: AppColors.darkOnSurfaceVariant),
                          fillColor: AppColors.darkSurfaceContainerLow,
                          hintText: 'نمونه: info@zenplan.com',
                          hintStyle: const TextStyle(color: Colors.white38),
                        ),
                      ),
                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'رمز عبور',
                            style: TextStyle(fontSize: 13, color: AppColors.darkOnSurfaceVariant),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'رمز عبور را فراموش کرده‌اید؟',
                              style: TextStyle(fontSize: 12, color: AppColors.primaryContainer),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.darkOnSurfaceVariant),
                          fillColor: AppColors.darkSurfaceContainerLow,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Login Action Button
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: widget.onLoginSuccess,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ورود به حساب', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_back, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Divider
                      const Row(
                        children: [
                          Expanded(child: Divider(color: Colors.white24)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'یا ادامه دهید با',
                              style: TextStyle(fontSize: 12, color: AppColors.darkOnSurfaceVariant),
                            ),
                          ),
                          Expanded(child: Divider(color: Colors.white24)),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Google OAuth Button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: OutlinedButton(
                          onPressed: widget.onLoginSuccess,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.g_mobiledata_rounded, size: 28, color: Colors.white),
                              SizedBox(width: 8),
                              Text('ورود با گوگل', style: TextStyle(color: Colors.white, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Footer Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'کاربر جدید هستید؟ ',
                      style: TextStyle(color: AppColors.darkOnSurfaceVariant, fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'ثبت‌نام کنید',
                        style: TextStyle(color: AppColors.primaryContainer, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
