import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_color.dart';
import '../../../routes/app_routes.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_text_field.dart';
import '../../widgets/common/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _fullnameCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController();
  final _phonenumberCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Create Account 🏠',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Register to get started',
                style: TextStyle(color: Colors.grey[500]),
              ),
              const SizedBox(height: 40),

              CustomTextField(
                hint: 'Full Name',
                icon: Icons.person_outline,
                controller: _fullnameCtrl,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: 'User Name',
                icon: Icons.alternate_email_rounded,
                controller: _usernameCtrl,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: 'Phone Number',
                icon: Icons.phone_outlined,
                controller: _phonenumberCtrl,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: 'Email',
                icon: Icons.email_outlined,
                controller: _emailCtrl,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: 'Password',
                icon: Icons.lock_outline,
                controller: _passwordCtrl,
                isPassword: true,
              ),
              const SizedBox(height: 12),

              if (auth.errorMessage != null)
                Text(
                  auth.errorMessage!,
                  style: const TextStyle(color: AppColors.error),
                ),

              const SizedBox(height: 24),

              CustomButton(
                label: 'Register',
                isLoading: auth.isLoading,
                onTap: () async {
                  final success = await auth.register(
                    _fullnameCtrl.text,
                    _usernameCtrl.text,
                    _phonenumberCtrl.text,
                    _emailCtrl.text,
                    _passwordCtrl.text,
                  );
                  if (success && context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRoutes.home);
                  }
                },
              ),
              const SizedBox(height: 20),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.grey[500]),
                      children: const [
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
