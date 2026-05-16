import 'package:flutter/material.dart';
import 'game_selection_page.dart';

class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF2B0B3F), Color(0xFF0D0614)],
            center: Alignment.bottomCenter,
            radius: 1.5,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/logo/logozarza.jpeg'),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: const Color(0xFFFF7A00), width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFFF7A00).withOpacity(0.6),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Subtitle Top
              const Text(
                'ZARZA ARDIENTE',
                style: TextStyle(
                  color: Color(0xFFFFC400),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),
              const Text(
                '- JUVENTUD -',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 40),

              // Main Title 3D Effect
              const Text(
                'DINÁMICAS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  shadows: [
                    Shadow(offset: Offset(0, 4), color: Colors.grey),
                    Shadow(offset: Offset(0, 0), blurRadius: 20, color: Color(0xFFFF7A00)),
                  ],
                ),
              ),
              const Text(
                'JUVENILES',
                style: TextStyle(
                  color: Color(0xFFFFC400),
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                  shadows: [
                    Shadow(offset: Offset(0, 4), color: Color(0xFFB48B00)),
                    Shadow(offset: Offset(0, 0), blurRadius: 20, color: Color(0xFFFFC400)),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Subtitle Bottom
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFF7A00).withOpacity(0.3)),
                ),
                child: const Text(
                  'Crece • Conecta • Sirve • Arde',
                  style: TextStyle(
                    color: Color(0xFFE0E0E0),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 60),

              // Play Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GameSelectionPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFC400), Color(0xFFFF7A00)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      const BoxShadow(
                        color: Color(0xFFCC6200),
                        offset: Offset(0, 6),
                      ),
                      BoxShadow(
                        color: const Color(0xFFFF7A00).withOpacity(0.6),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white, size: 30),
                      SizedBox(width: 10),
                      Text(
                        'INICIAR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
