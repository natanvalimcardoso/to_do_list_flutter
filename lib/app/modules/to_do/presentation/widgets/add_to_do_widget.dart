import 'package:flutter/material.dart';

class AddToDoWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final String label;

  const AddToDoWidget({
    super.key,
    required this.controller,
    required this.onAdd,
    this.label = 'Adicionar tarefa',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.grey.shade200,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: label,
                  border: InputBorder.none,
                ),
                onSubmitted: (_) => onAdd(),
              ),
            ),
            InkWell(
              onTap: onAdd,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}