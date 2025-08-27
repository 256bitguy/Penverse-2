import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/utils/responsive_utils.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../providers/auth_provider.dart';

class SuccessScreen extends StatelessWidget {
  final String? email;
  final String? password;

  const SuccessScreen({
    super.key,
    this.email,
    this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: ResponsiveUtils.getScreenPadding(context),
            child: Container(
              width: ResponsiveUtils.getFormWidth(context),
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/success.png', // TODO: Add success image
                    height: ResponsiveUtils.isMobile(context) ? 200 : 250,
                    width: ResponsiveUtils.isMobile(context) ? 200 : 250,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Successfully verified',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Start a journey of writing, events, competitions and explore a role of event team member',
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 48),
                  CustomButton(
                    text: 'Start',
                    onPressed: () async {
                      if (email != null && password != null) {
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        final success = await authProvider.register(email!, password!);
                        
                        if (success && context.mounted) {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                            (route) => false, // Remove all previous routes
                          );
                        }
                      } else {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false, // Remove all previous routes
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}