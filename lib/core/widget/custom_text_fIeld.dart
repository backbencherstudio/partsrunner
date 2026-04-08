import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final String? label;
  final Widget? suffix;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.readOnly = false,
    this.controller,
    this.validator,
    this.prefix,
    this.label,
    this.suffix,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Text(
              widget.label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
          ],
          TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controller,
            obscureText: widget.isPassword ? _obscureText : false,
            style: const TextStyle(color: Colors.black),
            validator: widget.validator,
            decoration: InputDecoration(
              prefixIcon: widget.prefix,
              filled: true,
              fillColor: const Color(0xff80e1e05).withOpacity(0.02),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffix,
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
              disabledBorder: OutlineInputBorder(
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
        ],
      ),
    );
  }
}
