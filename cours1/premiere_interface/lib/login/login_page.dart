import 'package:cours_01/res/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log in or Sign up',
        style: TextStyle(
          color : AppColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,)
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            EmailField(),
            SizedBox(height: 16),
            ContinueButton(
              onPressed: (){},
            ),
            SizedBox(height: 32),
            ContinuerAvecButton(
              label: "Continue with Apple",
              iconPath: "assets/apple_logo.svg",
              onPressed: (){},
            ),
            SizedBox(height: 16),
            ContinuerAvecButton(
              label: "Continue with Google",
              iconPath: "assets/google_logo.svg",
              onPressed: (){},
            ),
            SizedBox(height: 16),
            ContinuerAvecButton(
              label: "Continue with Facebook",
              iconPath: "assets/facebook_logo.svg",
              onPressed: (){},
            ),
          ],
        ),
      )
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      style : TextStyle(
        color : AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.email_outlined),
        hintText: 'Email address',
        hintStyle: TextStyle(
          color : AppColors.textSecondary,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.inputFieldInactiveBackground),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: AppColors.inputFieldActiveBackground
        ),
      ),
    ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ContinueButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(onPressed: onPressed, child: const Text('Continue'),
    style: FilledButton.styleFrom(
      foregroundColor: AppColors.buttonPrimaryText,
      backgroundColor: AppColors.buttonPrimaryBackground,
      textStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),);
    
  }
}

class OrSeparator extends StatelessWidget {
  const OrSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget> [ 
        Expanded(
          child: Divider(
            color: AppColors.textSecondary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.divider,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}

class ContinuerAvecButton extends StatelessWidget {
  final String label;
  final String iconPath;
  final VoidCallback onPressed;

  const ContinuerAvecButton({
    super.key,
    required this.label,
    required this.iconPath,
    required this.onPressed,});
  
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(onPressed: onPressed, child: Row(
      children: [
        Image.asset(iconPath, width:20),
        SizedBox(width: 12),
        Text(label)
      ],
      )
      );
  }
}
