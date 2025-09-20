import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class RulesDialog extends StatelessWidget {
  const RulesDialog({super.key});

  static void show(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Rules',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const RulesDialog();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation.drive(CurveTween(curve: Curves.easeOutCubic)),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppColors.secondaryBg,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Festival Rules',
                  style: GoogleFonts.orbitron(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.accentPink,
                  ),
                ),
                const SizedBox(height: 20),
                _buildRuleItem(Icons.no_drinks, 'No outside food or drinks.'),
                _buildRuleItem(
                  Icons.camera_alt,
                  'Professional cameras require a press pass.',
                ),
                _buildRuleItem(Icons.smoke_free, 'This is a smoke-free event.'),
                _buildRuleItem(
                  Icons.pets,
                  'No pets allowed, service animals welcome.',
                ),
                _buildRuleItem(Icons.person, 'Be respectful to everyone.'),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Got it!',
                      style: TextStyle(
                        color: AppColors.accentCyan,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRuleItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentCyan, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
