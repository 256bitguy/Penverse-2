import 'package:flutter/material.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import 'verification_screen.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  final List<bool> _passwordCriteria = List.filled(3, false);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _updatePasswordCriteria(String password) {
    setState(() {
      _passwordCriteria[0] = password.length >= 8; // Min 8 characters
      _passwordCriteria[1] = RegExp(r'[0-9]').hasMatch(password); // Min 2 number
      _passwordCriteria[2] = RegExp(r'[A-Z]').hasMatch(password); // Min 1 uppercase
    });
  }

  Future<void> _onCreateAccount() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
      });

      try {



        if (!mounted) return;

        if (true) {
          // Registration successful, navigate to verification
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                email: _emailController.text,
              ),
            ),
          );
        }
      } catch (e) {
        if (!mounted) return;
        
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
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
                    CustomTextField(
                      label: 'Username',
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a username';
                        }
                        if (value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                      text: _isLoading ? 'Creating account...' : 'Create an account',
                      onPressed: _isLoading ? null : _onCreateAccount,
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
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
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