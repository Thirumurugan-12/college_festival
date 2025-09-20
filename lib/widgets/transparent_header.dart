import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TransparentHeader extends StatelessWidget implements PreferredSizeWidget {
  const TransparentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return AppBar(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.white.withOpacity(0.9), AppColors.transparent],
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Brand
          Text(
            'Sing College',
            style: TextStyle(
              color: AppColors.white,
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),

          // Navigation buttons
          if (!isMobile) ...[
            // Desktop navigation
            Row(
              children: [
                _HeaderButton(text: 'Home', onPressed: () {}),
                const SizedBox(width: 24),
                _HeaderButton(text: 'About', onPressed: () {}),
                const SizedBox(width: 24),
                _HeaderButton(text: 'Services', onPressed: () {}),
                const SizedBox(width: 24),
                _HeaderButton(text: 'Advisor', onPressed: () {}),
                const SizedBox(width: 32),
                _HeaderButton(
                  text: 'Sign In',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign In clicked')),
                    );
                  },
                ),
                const SizedBox(width: 16),
                _HeaderButton(
                  text: 'Sign Up',
                  isPrimary: true,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Sign Up clicked')),
                    );
                  },
                ),
              ],
            ),
          ] else ...[
            // Mobile menu button
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.white, size: 28),
              onPressed: () {
                _showMobileMenu(context);
              },
            ),
          ],
        ],
      ),
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            _MobileMenuButton(
              text: 'Home',
              onPressed: () => Navigator.pop(context),
            ),
            _MobileMenuButton(
              text: 'About',
              onPressed: () => Navigator.pop(context),
            ),
            _MobileMenuButton(
              text: 'Services',
              onPressed: () => Navigator.pop(context),
            ),
            _MobileMenuButton(
              text: 'Advisor',
              onPressed: () => Navigator.pop(context),
            ),
            _MobileMenuButton(
              text: 'Sign In',
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign In clicked')),
                );
              },
            ),
            _MobileMenuButton(
              text: 'Sign Up',
              isPrimary: true,
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sign Up clicked')),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeaderButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _HeaderButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isPrimary
            ? AppColors.accentGold
            : AppColors.transparent,
        foregroundColor: AppColors.white,
        side: isPrimary
            ? BorderSide.none
            : BorderSide(color: AppColors.white.withOpacity(0.3), width: 1),
        padding: EdgeInsets.symmetric(
          horizontal: isPrimary ? 24 : 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: isPrimary ? 4 : 0,
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;

  const _MobileMenuButton({
    required this.text,
    required this.onPressed,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary
              ? AppColors.accentGold
              : AppColors.transparent,
          foregroundColor: AppColors.white,
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: AppColors.white.withOpacity(0.2), width: 1),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: isPrimary ? FontWeight.w700 : FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
