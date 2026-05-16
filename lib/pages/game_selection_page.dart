import 'package:flutter/material.dart';
import 'botonera_page.dart';

class GameSelectionPage extends StatelessWidget {
  const GameSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A0F2E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1A0F2E), Color(0xFF05020A)],
            center: Alignment.topCenter,
            radius: 1.5,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Text(
                'ELIGE UNA DINÁMICA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 20,
                      color: Color(0xFFFF7A00),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // Active Game: Botonera
                    _buildGameCard(
                      context: context,
                      icon: '🔴',
                      title: '100 Cristianos Dijeron',
                      description: 'Botonera interactiva. Los jugadores usan sus celulares para presionar el botón lo más rápido posible.',
                      isActive: true,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BotoneraPage(roomId: 'sala1'),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Coming Soon Game 1
                    _buildGameCard(
                      context: context,
                      icon: '🧩',
                      title: 'Trivia Bíblica',
                      description: 'Preguntas y respuestas sobre personajes y libros de la Biblia.',
                      isActive: false,
                    ),
                    const SizedBox(height: 20),

                    // Coming Soon Game 2
                    _buildGameCard(
                      context: context,
                      icon: '⚔️',
                      title: 'Batalla de Versículos',
                      description: 'Memorización y rapidez buscando versículos en la espada (Biblia).',
                      isActive: false,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameCard({
    required BuildContext context,
    required String icon,
    required String title,
    required String description,
    required bool isActive,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF28143C) : const Color(0xFF141414),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isActive ? const Color(0xFFFF7A00).withOpacity(0.5) : Colors.white12,
                width: 2,
              ),
              boxShadow: isActive ? [
                const BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0, 10),
                  blurRadius: 15,
                ),
              ] : [],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      icon,
                      style: TextStyle(
                        fontSize: 40,
                        color: isActive ? Colors.white : Colors.white38,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          color: isActive ? const Color(0xFFFFC400) : Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  style: TextStyle(
                    color: isActive ? Colors.white70 : Colors.white38,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          
          if (!isActive)
            Positioned(
              top: 10,
              right: -10,
              child: Transform.rotate(
                angle: 0.2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 4)],
                  ),
                  child: const Text(
                    'PRÓXIMAMENTE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
