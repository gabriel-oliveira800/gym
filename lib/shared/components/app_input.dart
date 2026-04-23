import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AppInput extends StatefulWidget {
  final String? value;
  final String placeholder;
  final double maxHeight;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const AppInput({
    super.key,
    this.value,
    this.maxHeight = 64,
    this.onChanged,
    this.controller,
    required this.placeholder,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _focused = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(AppInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.value != null && widget.value != _controller.text) {
      _controller.text = widget.value!;
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.maxHeight,
      child: TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        controller: _controller,
        onChanged: widget.onChanged,
        style: const TextStyle(color: AppColors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: const TextStyle(color: AppColors.gray500, fontSize: 16),
          filled: true,
          fillColor: AppColors.surfaceLight,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: _focused ? AppColors.primary : AppColors.gray700,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.gray700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
        onTap: () => setState(() => _focused = true),
        onTapOutside: (_) {
          setState(() => _focused = false);
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }
}
