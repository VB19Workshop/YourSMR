import "package:flutter/material.dart";

class SoundButton extends StatelessWidget {
  final String label;
  final bool active;
  final VoidCallback onTap;

  const SoundButton({
    super.key,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeInOut,

        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),

        decoration: BoxDecoration(
          color: active ? const Color.fromARGB(0, 0, 150, 135) : const Color.fromARGB(0, 96, 125, 139),
          borderRadius: BorderRadius.circular(10),
        ),

        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,

          style: TextStyle(
            color: active ? const Color.fromARGB(255, 252, 247, 179) : Colors.white70,
            fontSize: 16,
          ),

          child: Text(label),
        ),
      ),
    );
  }
}