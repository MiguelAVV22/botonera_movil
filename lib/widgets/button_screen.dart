import 'package:flutter/material.dart';

class ButtonScreen extends StatelessWidget {
  final String message;
  final bool locked;
  final VoidCallback onPressButton;
  final VoidCallback onChangeColor;

  const ButtonScreen({
    super.key,
    required this.message,
    required this.locked,
    required this.onPressButton,
    required this.onChangeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 50),
        GestureDetector(
          onTap: onPressButton,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              color: locked ? Colors.grey : Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              locked ? Icons.lock : Icons.touch_app,
              size: 90,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Text(
          locked ? "Juego bloqueado" : "Presiona primero",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          onPressed: onChangeColor,
          icon: const Icon(Icons.arrow_back),
          label: const Text("Volver a elegir color"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 14,
            ),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
