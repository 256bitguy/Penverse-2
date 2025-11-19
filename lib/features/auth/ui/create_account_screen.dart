import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:penverse/core/constants/app_colors.dart';
import 'package:penverse/core/store/app_state.dart';
import '../../../../core/utils/responsive_utils.dart';
// import '../../../../core/widgets/custom_button.dart';
import '../ui/widgets/custom_text_field.dart';
import 'verification_screen.dart';
import 'login_screen.dart';
import '../ui/viewmodel/register_viewmodel.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isLoading = false;

  final List<bool> _passwordCriteria = List.filled(3, false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // PASSWORD RULE CHECK
  void _updatePasswordCriteria(String password) {
    setState(() {
      _passwordCriteria[0] = password.length >= 8;
      _passwordCriteria[1] = RegExp(r'[0-9]').hasMatch(password);
      _passwordCriteria[2] = RegExp(r'[A-Z]').hasMatch(password);
    });
  }

  // REGISTER API CALL HANDLER
  Future<void> _onCreateAccount() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);

    try {
      final store = StoreProvider.of<AppState>(context, listen: false);

      // Trigger RegisterAction via ViewModel
      RegisterViewModel.fromStore(store).onRegister(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      // Wait until Redux finishes loading
      await Future.doWhile(() async {
        final vm = RegisterViewModel.fromStore(store);

        if (!vm.isLoading) return false; // stop waiting

        await Future.delayed(const Duration(milliseconds: 200));
        return true; // keep waiting
      });

      if (!mounted) return;

      // Get final auth state
      final finalState = RegisterViewModel.fromStore(store);

      if (finalState.isRegistered) {
        // SUCCESS → navigate to OTP screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              email: _emailController.text.trim(),
            ),
          ),
        );
      } else if (finalState.errorMessage != null) {
        // FAILED → show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(finalState.errorMessage!),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildCriteriaItem(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check : Icons.close,
            size: 16,
            color: isMet ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 6),
          Text(text,
              style: TextStyle(
                  fontSize: 13, color: isMet ? Colors.green : Colors.red)),
        ],
      ),
    );
  }

  Widget _buildPasswordCriteria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCriteriaItem('Min 8 characters', _passwordCriteria[0]),
        _buildCriteriaItem('At least 1 number', _passwordCriteria[1]),
        _buildCriteriaItem('At least 1 uppercase letter', _passwordCriteria[2]),
      ],
    );
  }

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
                    Text(
                      'Create an account',
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Excited to have you on board!',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 32),

                    // EMAIL FIELD
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // PASSWORD FIELD
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
                        onPressed: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible),
                      ),
                      onChanged: _updatePasswordCriteria,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter your password';
                        }
                        if (!_passwordCriteria.every((e) => e)) {
                          return 'Password requirements not met';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),
                    _buildPasswordCriteria(),
                    const SizedBox(height: 32),

                    // REGISTER BUTTON WITH LOADER
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _isLoading ? null : _onCreateAccount,
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
                                'Create an account',
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
                        Text(
                          'Already have an account? ',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          ),
                          child: const Text('Log in'),
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
