import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'add_button.dart';
import 'app_input.dart';

class InputWithButton extends StatelessWidget {
  final String placeholder;
  final String? value;
  final ValueChanged<String>? onChanged;
  final VoidCallback onSend;
  final TextEditingController? controller;

  const InputWithButton({
    super.key,
    required this.placeholder,
    required this.onSend,
    this.value,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppInput(
            value: value,
            onChanged: onChanged,
            controller: controller,
            placeholder: placeholder,
          ),
        ),
        const SizedBox(width: 8),
        AddButton(icon: LucideIcons.plus, onPressed: onSend),
      ],
    );
  }
}
