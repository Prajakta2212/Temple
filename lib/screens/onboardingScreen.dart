
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Temple_App/screens/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppColors {
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color orangeAction = Color(0xFFF16522);
  static const Color textHeadline = Color(0xFF1F1F1F);
  static const Color textBody = Color(0xFF6B6B6B);
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenHeight = size.height;
    final screenWidth = size.width;

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Stack(
        children: [

          Positioned(
            top: screenHeight * 0.08,
            left: -screenWidth * 0.25,
            right: -screenWidth * 0.25,
            child: Image.asset(
              "assets/cicle.png",
              height: screenWidth * 1.25,
              fit: BoxFit.contain,
              color: const Color(0xFFF16522),
              colorBlendMode: BlendMode.srcIn,
            ),
          ),

          // 🏛 TEMPLE (FULL BOTTOM)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              "assets/temple_bg.png",
              height: screenHeight * 0.70,
                 fit: BoxFit.cover, // 🔥 fills full width
    alignment: Alignment.topCenter,
            ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Access Siddhivinayak\ntemple and services at\nyour fingertips",
                      style: GoogleFonts.manrope(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: AppColors.textHeadline,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "From Darshan bookings to Prasad delivery —\nexperience devotion made simple.",
                      style: GoogleFonts.manrope(
                        fontSize: 13.5,
                        height: 1.5,
                        color: AppColors.textBody,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),


          Positioned(
            top: screenHeight * 0.27,
            left: 24,
            child: GestureDetector(
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool("seenOnboarding", true);

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomeScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.orangeAction,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.orangeAction.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),

          // ⚫ DOTS
        
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    bool isActive = currentPageIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: isActive ? 10 : 8,
      width: isActive ? 10 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.orangeAction
            : const Color(0xFFDADADA),
        shape: BoxShape.circle,
      ),
    );
  }
}