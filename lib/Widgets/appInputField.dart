import 'package:flutter/material.dart';

import '../Utils/colors.dart';

class AppInputField extends StatefulWidget {
  final String text;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final Function(String) onChanged;

  AppInputField({
    Key key,
    this.text,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    Brightness brightness = Theme.of(context).brightness;
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? _isObscure : false,
        keyboardType: widget.keyboardType,
        decoration: _getInputDecoration(brightness),
        onChanged: widget.onChanged,
      ),
    );
  }

  InputDecoration _getInputDecoration(Brightness brightness) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      hintText: widget.text,
      hintStyle: TextStyle(
          color: brightness == Brightness.light
              ? ColorSet.darkGrayColor
              : ColorSet.darkWhiteColor,
          fontSize: 16),
      filled: true,
      fillColor: brightness == Brightness.light
          ? ColorSet.darkWhiteColor
          : ColorSet.darkGrayColor,
      suffixIcon: widget.isPassword
          ? IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            )
          : null,
    );
  }
}
