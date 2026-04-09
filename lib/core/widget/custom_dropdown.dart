import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final Widget? prefix;
  final VoidCallback? onReload;
  final bool isLoading;
  final String? error;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    this.value,
    this.onChanged,
    this.validator,
    this.prefix,
    this.onReload,
    this.isLoading = false,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
        if (isLoading) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Loading...',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    if (error != null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade600, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Failed to load',
                  style: TextStyle(color: Colors.red.shade600, fontSize: 14),
                ),
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: Colors.red.shade600, size: 20),
                onPressed: onReload,),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<T>(
        initialValue: value,
        items: items,
        onChanged: onChanged ?? (_) {},
        validator: validator,
        style: const TextStyle(color: Colors.black),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        decoration: InputDecoration(
          prefixIcon: prefix,
          filled: true,
          fillColor: const Color(0xff80e1e05).withOpacity(0.04),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xff80e1e05).withValues(alpha: 0.05),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xff80e1e05).withValues(alpha: 0.05),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xff80e1e05).withValues(alpha: 0.04),
            ),
          ),
        ),
      ),
    );
  }
}
