import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import '../voting/voting_screen.dart';

class MyEntryScreen extends StatelessWidget {
  const MyEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('My Entry'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.backgroundGradient),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStatCard('Votes', '1,234', Icons.how_to_vote),
                const SizedBox(height: 20),
                _buildStatCard('Views', '5,678', Icons.visibility),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const VotingScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentCyan,
                    foregroundColor: AppColors.primaryBg,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'View & Vote',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.secondaryBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.accentCyan.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accentCyan, size: 40),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(color: AppColors.white, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: GoogleFonts.orbitron(
                  color: AppColors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
