import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class MCTextField extends StatelessWidget {
  MCTextField({
    super.key,
    this.controller,
    this.hintText,
    this.height = 42,
    this.suffixIcon,
    this.suffixText,
    this.suffix,
    this.clipBehavior = Clip.hardEdge,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.counterText = "",
    this.fillColor,
    this.borderRadius = 20.0,
    this.maxLines = 1,
    this.expands = false,
    this.keyboardType,
    this.error = false,
    this.errorText,
    this.textAlignVertical,
    this.obscureText = false,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
  });
  final TextEditingController? controller;
  final String? hintText;
  final double? height;
  final Widget? suffixIcon;
  final String? suffixText;
  final Widget? suffix;
  final Clip clipBehavior;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final Color? fillColor;
  final double borderRadius;
  final String? counterText;
  final int? maxLines;
  final bool expands;
  final TextInputType? keyboardType;
  final bool error;
  final String? errorText;
  final TextAlignVertical? textAlignVertical;
  final bool obscureText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return TextField(
      maxLength: maxLength,
      textInputAction: textInputAction,
      focusNode: focusNode,
      textAlignVertical: textAlignVertical,
      keyboardType: keyboardType,
      maxLines: maxLines,
      expands: expands,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      obscuringCharacter: "·",
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      clipBehavior: clipBehavior,
      style: Constants.defaultTextStyle.copyWith(color: Colors.black),
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        counterText: counterText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        filled: true,
        fillColor: fillColor ?? const Color(0xFFEEEEEE),
        errorText: error ? errorText : null,
        // errorStyle: Constants.textFieldErrorStyle.copyWith(color: Colors.black),
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        errorBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
        border: InputBorder.none,
        hintText: hintText,
        suffixIcon: suffixIcon,
        suffixText: suffixText,
        suffix: suffix,
        suffixStyle: const TextStyle(
          color: Color(0xFF555555),
          fontSize: 14,
          fontFamily: 'Spoqa Han Sans Neo',
          fontWeight: FontWeight.w400,
        ),
        hintStyle:
            Constants.defaultTextStyle.copyWith(color: Constants.grey100),
      ),
    );
  }
}
