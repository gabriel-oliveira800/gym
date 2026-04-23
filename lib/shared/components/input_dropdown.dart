import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
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
    return widget.items
        .where(
            (item) => item.label.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  String? get _selectedLabel {
    if (widget.currentValue == null) return null;
    try {
      return widget.items
          .firstWhere((item) => item.value == widget.currentValue)
          .label;
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
    final borderColor = _isOpen ? AppColors.primaryDark : AppColors.gray700;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(label: widget.label),
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedLabel ?? widget.placeholder,
                    style: TextStyle(
                      color: _selectedLabel != null
                          ? AppColors.white
                          : AppColors.gray500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Icon(
                  _isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.white,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        if (_isOpen)
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5,
            ),
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 64,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: borderColor),
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (v) => setState(() => _searchQuery = v),
                      style:
                          const TextStyle(color: AppColors.white, fontSize: 16),
                      decoration: InputDecoration(
                        hintText: 'Digite para buscar...',
                        hintStyle: const TextStyle(
                            color: AppColors.gray500, fontSize: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: borderColor),
                        ),
                        filled: true,
                        fillColor: AppColors.surfaceLight,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
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
                        title: Text(
                          item.label,
                          style: const TextStyle(
                              color: AppColors.white, fontSize: 16),
                        ),
                        trailing: isSelected
                            ? const Icon(Icons.check,
                                color: AppColors.white, size: 20)
                            : null,
                        onTap: () => _selectItem(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
