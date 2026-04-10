

import 'package:Temple_App/screens/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),

     
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: Icon(Icons.account_circle_outlined, size: 28),
        ),
    actions: [
  Padding(
    padding: const EdgeInsets.only(right: 12),
    child: GestureDetector(
      onTap: () async {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool("isLoggedIn", false);
        await prefs.remove("username");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (route) => false,
        );
      },
      child: Row(
        children: const [
          Icon(Icons.logout, size: 20, color: Colors.orange),
          SizedBox(width: 4),
          Text(
            "Logout",
            style: TextStyle(
              fontSize: 18,
              color: Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  ),
],
  
  
      ),
body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      // ❤️ Subtitle
      // Text(
      //   "Mumbai’s Sacred Heart",
      //   style: GoogleFonts.manrope(
      //     color: Colors.orange,
      //     fontSize: 12,
      //   ),
      // ),

      const SizedBox(height: 10),

      // 📝 Divine Image (Responsive)
      Center(
        child: Image.asset(
          "assets/divine.png",
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),

      const SizedBox(height: 20),

      // 🔶 Scanner Banner
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/banner scanner.png",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),

      const SizedBox(height: 25),

      // 🧩 SERVICES TITLE
   

      const SizedBox(height: 16),

      // 🧩 Services Image (Grid UI)
      Image.asset(
        "assets/services.png",
        width: double.infinity,
        fit: BoxFit.contain,
      ),

      const SizedBox(height: 30),

      // 🎥 LIVE SECTION
     

      const SizedBox(height: 12),

      // 🎥 Live Image
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          "assets/live darshan.png",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),

      const SizedBox(height: 20),
    ],
  ),
),
   
   
   
   
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Timeline"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Bookings"),
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: "E-Prasad"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Feed"),
        ],
      ),
    );
  }

  // 🔘 SERVICE ITEM
  Widget _serviceItem(String icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: const Color(0xFFFDE5DD),
          child: Image.asset(icon, height: 24),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.manrope(fontSize: 10),
        ),
      ],
    );
  }

  // 🎥 LIVE CARD
  Widget _liveCard(String image) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}