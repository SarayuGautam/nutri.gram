import 'package:flutter/material.dart';
import 'package:nutrigram_app/constants/constants.dart';

class DTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool password;
  final TextInputType textInputType;
  final int lines;
  final bool enabled;
  final FocusNode focusNode;
  final VoidCallback onEditingComplete;
  final String Function(String) validator;
  final Function(String) onChanged;
  final String hintText;
  final Widget prefixIcon;
  final Widget suffixIcon;
  final TextCapitalization textCapitalization;
  const DTextField({
    this.controller,
    this.password = false,
    this.textInputType = TextInputType.text,
    this.lines = 1,
    this.enabled = true,
    this.focusNode,
    this.onEditingComplete,
    this.validator,
    this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
      validator: validator,
      onChanged: onChanged,
      controller: controller,
      style: Theme.of(context).textTheme.caption,
      obscureText: password,
      keyboardType: textInputType,
      enabled: enabled,
      maxLines: lines,
      minLines: lines,
      decoration: InputDecoration(
        hintStyle: Theme.of(context)
            .textTheme
            .caption
            .apply(color: kDisabledLightThemeColor),
        prefixIcon: prefixIcon,
        hintText: hintText,
        enabled: enabled,
        suffixIcon: suffixIcon,
      ),
    );
  }
}
