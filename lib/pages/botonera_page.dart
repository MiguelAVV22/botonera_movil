import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../utils/app_colors.dart';
import '../widgets/color_selector.dart';
import '../widgets/button_screen.dart';

class BotoneraPage extends StatefulWidget {
  final String roomId;
  
  const BotoneraPage({super.key, required this.roomId});

  @override
  State<BotoneraPage> createState() => _BotoneraPageState();
}

class _BotoneraPageState extends State<BotoneraPage> {
  late IO.Socket socket;

  final String deviceName = "Celular Flutter";

  String? selectedTeam;
  String? selectedColor;
  bool connected = false;
  bool locked = false;
  String message = "Conectando...";
  
  // Track team availability
  bool teamATaken = false;
  bool teamBTaken = false;

  final List<String> colors = [
    "red",
    "blue",
    "green",
    "yellow",
    "purple",
    "orange",
    "pink",
    "cyan",
  ];

  @override
  void initState() {
    super.initState();
    connectSocket();
  }

  void connectSocket() {
    socket = IO.io(
      "http://192.168.0.6:3001",
      <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
        "forceNew": true,
        "reconnection": true,
        "timeout": 20000,
      },
    );

    socket.onConnect((_) {
      print("CONECTADO AL BACKEND: ${socket.id}");
      if (mounted) {
        setState(() {
          connected = true;
          message = "Elige tu equipo";
        });
      }

      socket.emit("join_room", {
        "roomId": widget.roomId,
        "deviceName": deviceName,
      });
    });

    socket.on("room_state", (data) {
      if (mounted) {
        setState(() {
          // Check which teams are taken
          final teams = data["teams"];
          if (teams != null) {
            teamATaken = teams["A"]["socketId"] != null && teams["A"]["socketId"] != socket.id;
            teamBTaken = teams["B"]["socketId"] != null && teams["B"]["socketId"] != socket.id;
          }
        });
      }
    });

    socket.on("team_confirmed", (data) {
      if (mounted) {
        setState(() {
          selectedTeam = data["team"];
          message = "Elige tu color";
        });
      }
    });

    socket.on("color_confirmed", (data) {
      if (mounted) {
        setState(() {
          selectedColor = data["color"];
          message = "Color seleccionado";
        });
      }
    });

    socket.on("winner_selected", (data) {
      if (mounted) {
        setState(() {
          locked = true;
          message = data["socketId"] == socket.id
              ? "¡Ganaste!"
              : "Otro equipo ganó";
        });
      }
    });

    socket.on("game_reset", (_) {
      if (mounted) {
        setState(() {
          locked = false;
          if (selectedColor != null) {
            message = "Presiona primero";
          } else if (selectedTeam != null) {
            message = "Elige tu color";
          } else {
            message = "Elige tu equipo";
          }
        });
      }
    });

    socket.on("color_released", (_) {
      if (mounted) {
        setState(() {
          selectedColor = null;
          locked = false;
          message = "Elige tu color";
        });
      }
    });

    socket.on("team_released", (_) {
      if (mounted) {
        setState(() {
          selectedTeam = null;
          selectedColor = null;
          locked = false;
          message = "Elige tu equipo";
        });
      }
    });

    socket.on("error_message", (data) {
      if (mounted) {
        setState(() {
          message = data.toString();
        });
      }
    });

    socket.connect();
  }

  void selectTeam(String team) {
    socket.emit("select_team", {
      "roomId": widget.roomId,
      "team": team,
    });
  }

  void selectColor(String color) {
    if (locked) return;

    socket.emit("select_color", {
      "roomId": widget.roomId,
      "color": color,
    });
  }

  void pressButton() {
    if (selectedColor == null || locked) return;

    socket.emit("press_button", {
      "roomId": widget.roomId,
    });
  }

  void changeColor() {
    socket.emit("change_color", {
      "roomId": widget.roomId,
    });
  }

  void changeTeam() {
    socket.emit("change_team", {
      "roomId": widget.roomId,
    });
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final background = AppColors.getColor(selectedColor);

    return Scaffold(
      backgroundColor: selectedTeam == null ? const Color(0xFF1A0F2E) : background,
      body: SafeArea(
        child: Center(
          child: _buildCurrentScreen(),
        ),
      ),
    );
  }

  Widget _buildCurrentScreen() {
    if (selectedTeam == null) {
      return teamSelector();
    } else if (selectedColor == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: changeTeam,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white24,
              foregroundColor: Colors.white,
            ),
            child: const Text("← Cambiar Equipo"),
          ),
          const SizedBox(height: 20),
          ColorSelector(
            message: message,
            colors: colors,
            onColorSelected: selectColor,
          ),
        ],
      );
    } else {
      return ButtonScreen(
        message: message,
        locked: locked,
        onPressButton: pressButton,
        onChangeColor: changeColor,
      );
    }
  }

  Widget teamSelector() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 40),
        _buildTeamButton(
          title: "EQUIPO A",
          icon: Icons.group,
          isTaken: teamATaken,
          onTap: () => selectTeam("A"),
        ),
        const SizedBox(height: 20),
        _buildTeamButton(
          title: "EQUIPO B",
          icon: Icons.group_work,
          isTaken: teamBTaken,
          onTap: () => selectTeam("B"),
        ),
      ],
    );
  }

  Widget _buildTeamButton({
    required String title,
    required IconData icon,
    required bool isTaken,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isTaken ? null : onTap,
      child: Container(
        width: 250,
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: isTaken ? Colors.grey.withOpacity(0.3) : const Color(0xFFFF7A00),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isTaken ? Colors.transparent : const Color(0xFFFFC400),
            width: 2,
          ),
          boxShadow: isTaken ? [] : [
            const BoxShadow(
              color: Color(0xFFCC6200),
              offset: Offset(0, 5),
            ),
            BoxShadow(
              color: const Color(0xFFFF7A00).withOpacity(0.5),
              blurRadius: 15,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isTaken ? Colors.white54 : Colors.white, size: 30),
            const SizedBox(width: 15),
            Text(
              isTaken ? "Ocupado" : title,
              style: TextStyle(
                color: isTaken ? Colors.white54 : Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
