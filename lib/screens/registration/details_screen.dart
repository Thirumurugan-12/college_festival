import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../constants/app_colors.dart';
import 'song_upload_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                Text(
                  'Your Details',
                  style: GoogleFonts.orbitron(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 32),
                _buildTextField('Name'),
                const SizedBox(height: 20),
                _buildDropdownField('College', [
                  'College A',
                  'College B',
                  'College C',
                ]),
                const SizedBox(height: 20),
                _buildDropdownField('Current Year', [
                  '1st',
                  '2nd',
                  '3rd',
                  '4th',
                ]),
                const SizedBox(height: 20),
                _buildTextField('Course'),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SongUploadScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentPink,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Next',
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

  Widget _buildTextField(String label) {
    return TextField(
      style: const TextStyle(color: AppColors.white, fontSize: 18),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.accentCyan),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentCyan),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentPink, width: 2),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> items) {
    return DropdownButtonFormField(
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: (value) {},
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: AppColors.accentCyan),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentCyan),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentPink, width: 2),
        ),
      ),
      dropdownColor: AppColors.secondaryBg,
      style: const TextStyle(color: AppColors.white, fontSize: 18),
    );
  }
}
