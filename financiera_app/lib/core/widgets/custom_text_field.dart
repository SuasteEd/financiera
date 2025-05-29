import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final double textFieldHeight, paddingVertical, paddingHorizontal;
  final String? hintText, errorText, initialValue;
  final bool? enabled;
  final bool readOnly, obscureText, autocorrect;
  final Widget? prefixIcon, suffixIcon;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLines, maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? textColor;
  final Color? fillColor;
  final bool border;
  final bool haveHelperText;
  final FocusNode? focusNode;

  const CustomTextFormField({
    super.key,
    this.textFieldHeight = 50,
    this.paddingVertical = 0,
    this.paddingHorizontal = 0,
    this.hintText,
    this.initialValue,
    this.enabled,
    this.readOnly = false,
    this.errorText,
    this.obscureText = false,
    this.autocorrect = true,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines,
    this.maxLength,
    this.inputFormatters,
    this.controller,
    this.onChanged,
    this.validator,
    this.textColor,
    this.fillColor,
    this.border = true,
    this.haveHelperText = true,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: textFieldHeight +
                32), // Ajusta la altura para incluir el espacio del error
        child: TextFormField(
            style: TextStyle(color: textColor),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: initialValue,
            controller: controller,
            focusNode: focusNode,
            onChanged: onChanged,
            validator: validator,
            enabled: enabled,
            readOnly: readOnly,
            obscureText: obscureText,
            autocorrect: autocorrect,
            textCapitalization: textCapitalization,
            keyboardType: keyboardType,
            maxLines: maxLines,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              // focusedBorder: InputBorder.none,
              prefixIconConstraints: const BoxConstraints(
                minWidth: 0,
                minHeight: 0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: border
                    ? const BorderSide(color: Colors.grey, width: 0.5)
                    : BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: border
                    ? const BorderSide(color: Colors.grey, width: 0.5)
                    : BorderSide.none,
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: border
                    ? const BorderSide(color: Colors.grey, width: 0.5)
                    : BorderSide.none,
              ),

              fillColor: fillColor,
              filled: true,
              helperText: haveHelperText ? ' ' : null,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            )),
      ),
    );
  }
}
