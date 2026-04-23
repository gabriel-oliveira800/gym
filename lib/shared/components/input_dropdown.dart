import 'package:flutter/material.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'input_label.dart';

class DropdownItem {
  final String label;
  final String value;

  const DropdownItem({required this.label, required this.value});
}

class InputDropdown extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? currentValue;
  final List<DropdownItem> items;
  final ValueChanged<DropdownItem> onChanged;

  const InputDropdown({
    super.key,
    required this.label,
    required this.placeholder,
    required this.items,
    required this.onChanged,
    this.currentValue,
  });

  @override
  State<InputDropdown> createState() => _InputDropdownState();
}

class _InputDropdownState extends State<InputDropdown> {
  bool _isOpen = false;
  String _searchQuery = '';
  final _searchController = TextEditingController();

  List<DropdownItem> get _filteredItems {
    if (_searchQuery.isEmpty) return widget.items;
    return widget.items.where((item) => item.label.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  String? get _selectedLabel {
    if (widget.currentValue == null) return null;
    try {
      return widget.items.firstWhere((item) => item.value == widget.currentValue).label;
    } catch (_) {
      return null;
    }
  }

  void _toggleDropdown() {
    setState(() {
      _isOpen = !_isOpen;
      if (!_isOpen) {
        _searchQuery = '';
        _searchController.clear();
      }
    });
  }

  void _selectItem(DropdownItem item) {
    widget.onChanged(item);
    setState(() {
      _isOpen = false;
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final borderColor = _isOpen ? AppColors.primaryDark : AppColors.gray700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: widget.label),
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            height: AppSizes.dropdownHeight,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedLabel ?? widget.placeholder,
                    style: _selectedLabel != null ? AppTextStyles.inputText : AppTextStyles.inputHint,
                  ),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.white,
                  size: AppSizes.iconLg,
                ),
              ],
            ),
          ),
        ),
        if (_isOpen)
          Container(
            constraints: BoxConstraints(
              maxHeight: size.height * AppSizes.dropdownMaxHeightRatio,
            ),
            margin: const EdgeInsets.only(top: AppSizes.spacing4),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: AppSizes.inputHeight,
                  padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacing12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: borderColor),
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style: AppTextStyles.inputText,
                      decoration: InputDecoration(
                        hintText: AppStrings.dropdownSearchPlaceholder,
                        hintStyle: AppTextStyles.inputHint,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radius12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radius12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSizes.radius12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceLight,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.spacing12,
                          vertical: AppSizes.spacing8,
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      final isSelected = item.value == widget.currentValue;
                      return ListTile(
                        title: Text(item.label, style: AppTextStyles.inputText),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: AppSizes.iconMd,
                              )
                            : null,
                        onTap: () => _selectItem(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: AppSizes.spacing8),
      ],
    );
  }
}
