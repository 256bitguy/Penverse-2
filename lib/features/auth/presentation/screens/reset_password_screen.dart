import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _codeControllers =
      List.generate(4, (index) => TextEditingController());
  final _newPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  final List<bool> _passwordCriteria = List.filled(3, false);
  bool _isVerified = false;

  @override
  void dispose() {
    for (var controller in _codeControllers) {
      controller.dispose();
    }
    _newPasswordController.dispose();
    super.dispose();
  }

  void _updatePasswordCriteria(String password) {
    setState(() {
      _passwordCriteria[0] = password.length >= 8; // Min 8 characters
      _passwordCriteria[1] = RegExp(r'[0-9]').hasMatch(password); // Min 2 number
      _passwordCriteria[2] = RegExp(r'[A-Z]').hasMatch(password); // Min 1 uppercase
    });
  }

  Widget _buildVerificationCode() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => SizedBox(
          width: 50,
          child: TextField(
            controller: _codeControllers[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: Theme.of(context).textTheme.headlineMedium,
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            onChanged: (value) {
              if (value.isNotEmpty && index < 3) {
                FocusScope.of(context).nextFocus();
              }
              if (value.isEmpty && index > 0) {
                FocusScope.of(context).previousFocus();
              }
              if (_codeControllers.every((c) => c.text.isNotEmpty)) {
                // TODO: Verify code
                setState(() {
                  _isVerified = true;
                });
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCriteriaItem(String text, bool isMet) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(
            isMet ? Icons.check : Icons.close,
            size: 16,
            color: isMet ? Theme.of(context).primaryColor : Colors.red,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: isMet ? Theme.of(context).primaryColor : Colors.red,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordCriteria() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCriteriaItem(
          'Min 8 characters length',
          _passwordCriteria[0],
        ),
        _buildCriteriaItem(
          'Min 2 number',
          _passwordCriteria[1],
        ),
        _buildCriteriaItem(
          'Min 1 uppercase letter',
          _passwordCriteria[2],
        ),
      ],
    );
  }

  void _onResetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // TODO: Implement actual password reset logic
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
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
                    if (!_isVerified) ...[
                      Text(
                        'Enter the 4-digit code',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Code sent to ${widget.email}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      _buildVerificationCode(),
                      const SizedBox(height: 24),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // TODO: Implement resend code logic
                          },
                          child: const Text('Resend code'),
                        ),
                      ),
                    ] else ...[
                      Text(
                        'Enter new password',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      const SizedBox(height: 32),
                      CustomTextField(
                        label: 'New password',
                        controller: _newPasswordController,
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
                        onChanged: _updatePasswordCriteria,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          if (!_passwordCriteria.every((element) => element)) {
                            return 'Please meet all password requirements';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildPasswordCriteria(),
                      const SizedBox(height: 32),
                      CustomButton(
                        text: 'Save password',
                        onPressed: _onResetPassword,
                      ),
                    ],
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