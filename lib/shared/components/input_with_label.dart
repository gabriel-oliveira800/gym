import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import 'app_input.dart';
import 'input_label.dart';

class InputWithLabel extends StatelessWidget {
  final String label;
  final String placeholder;
  final String? value;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const InputWithLabel({
    super.key,
    required this.label,
    required this.placeholder,
    this.value,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.inputWithLabelHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputLabel(label: label),
          AppInput(
            placeholder: placeholder,
            value: value,
            onChanged: onChanged,
            controller: controller,
          ),
        ],
      ),
    );
  }
}
