import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:penverse/core/constants/app_colors.dart';
import '../../../../core/store/app_state.dart';
import '../../../../core/utils/responsive_utils.dart';
// import '../../../../core/widgets/custom_button.dart';
import '../ui/widgets/custom_text_field.dart';
import 'forgot_password_screen.dart';
import '../../../features/entrypoint/entrypoint_ui.dart';
import '../ui/viewmodel/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// ---------- LOGIN HANDLER ----------
  Future<void> _onLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
    final store = StoreProvider.of<AppState>(context, listen: false);

      /// Trigger Redux login action
       LoginViewModel.fromStore(store).onLogin(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      /// Wait until Redux finishes loading the login
      await Future.doWhile(() async {
        final vm = LoginViewModel.fromStore(store);

        if (!vm.isLoading) return false; // stop waiting

        await Future.delayed(const Duration(milliseconds: 200));
        return true; // continue waiting
      });

      if (!mounted) return;

      final finalState = LoginViewModel.fromStore(store);

      if (finalState.isLoggedIn) {
        // if (true) {
        /// SUCCESS → navigate
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const EntryPointUI()),
        );
      } else if (finalState.errorMessage != null) {
        /// FAILED → show error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(finalState.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// ---------- UI ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: ResponsiveUtils.getScreenPadding(context),
            child: Container(
              width: ResponsiveUtils.getFormWidth(context),
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Log in',
                        style: Theme.of(context).textTheme.displayLarge),
                    const SizedBox(height: 8),
                    Text('Welcome back!',
                        style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 32),

                    /// Email
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// Password
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white70,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    /// Forgot password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: const Text('Forgot password?'),
                      ),
                    ),
                    const SizedBox(height: 32),

                    /// Login Button with loader
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _onLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.cardBackground,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Log in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account? ',
                            style: Theme.of(context).textTheme.bodyLarge),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/create-account');
                          },
                          child: const Text('Create an account'),
                        ),
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
