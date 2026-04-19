import 'package:airoster/shared/components/app_icon_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_theme.dart';
import '../../../shared/components/app_button.dart';
import '../../../shared/components/app_checkbox.dart';
import '../../../shared/components/app_text_field.dart';
import '../../../shared/components/app_text_link.dart';
import 'auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    // TODO: hook into auth controller
    // ref.read(authControllerProvider.notifier).signIn(
    //   email: _emailController.text.trim(),
    //   password: _passwordController.text,
    //   rememberMe: _rememberMe,
    // );
  }

  void _forgotPassword(){

  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.pagePadding,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xxxl),

                // ── Logo ──────────────────────────────────
               AppIconBadge(icon: Icons.shield_outlined),

                const SizedBox(height: AppSpacing.xxl),

                // ── Heading ───────────────────────────────
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Welcome back! Please enter your details.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: AppSpacing.xxxl),

                // ── Email ─────────────────────────────────
                AppTextField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: _emailController,
                  focusNode: _emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  onSubmitted: (_) => _passwordFocus.requestFocus(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Password ──────────────────────────────
                AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _passwordController,
                  focusNode: _passwordFocus,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  onSubmitted: (_) => _submit(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Remember me + Forgot password ─────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppCheckbox(
                      value: _rememberMe,
                      label: 'Remember for 30 days',
                      onChanged: (v) => setState(() => _rememberMe = v ?? false),
                    ),
                    AppTextLink(
                      label: 'Forgot password',
                      onTap: _forgotPassword,
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.xxl),

                // ── Sign in button ────────────────────────
                AppButton(
                  label: 'Sign in',
                  onPressed: _submit,
                ),

                const SizedBox(height: AppSpacing.lg),

                // ── Sign up prompt ────────────────────────
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      AppTextLink(
                        label: 'Sign up',
                        onTap: () {
                          // TODO: navigate to sign up
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}