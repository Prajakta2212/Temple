

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
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange, Colors.deepOrange],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Text(
          "Temple App",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setBool("isLoggedIn", false);

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen()),
                (route) => false,
              );
            },
          )
        ],
      ),


body: SingleChildScrollView(
  padding: const EdgeInsets.symmetric(horizontal: 16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    

      const SizedBox(height: 10),

    
      Center(
        child: Image.asset(
          "assets/divine.png",
          width: double.infinity,
          fit: BoxFit.contain,
        ),
      ),

      const SizedBox(height: 20),

   
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/banner scanner.png",
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),

      const SizedBox(height: 25),

  
   

      const SizedBox(height: 16),

  
      Image.asset(
        "assets/services.png",
        width: double.infinity,
        fit: BoxFit.contain,
      ),

      const SizedBox(height: 30),

   
     

      const SizedBox(height: 12),

 
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

