import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AppInput extends StatefulWidget {
  final String? value;
  final String placeholder;
  final double maxHeight;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;

  const AppInput({
    super.key,
    this.value,
    this.maxHeight = AppSizes.inputHeight,
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
        style: AppTextStyles.inputText,
        decoration: InputDecoration(
          hintText: widget.placeholder,
          hintStyle: AppTextStyles.inputHint,
          filled: true,
          fillColor: AppColors.surfaceLight,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.spacing16,
            vertical: AppSizes.spacing12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
            borderSide: BorderSide(
              color: _focused ? AppColors.primary : AppColors.gray700,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
            borderSide: const BorderSide(color: AppColors.gray700),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.radius12),
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
