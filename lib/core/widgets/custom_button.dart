import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isSecondary;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isSecondary = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isSecondary
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: onPressed == null ? Colors.white.withOpacity(0.3) : Colors.white,
                  width: 1,
                ),
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: onPressed == null ? Colors.white.withOpacity(0.3) : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                disabledBackgroundColor: Theme.of(context).primaryColor.withOpacity(0.3),
                disabledForegroundColor: Colors.white.withOpacity(0.3),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}