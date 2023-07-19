import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../Utils/colors.dart';

class AppButton extends StatefulWidget {
  final String text;
  final Function onClicked;
  const AppButton({key, this.text, this.onClicked});

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isLoading = false;

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 14,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(ColorSet.primaryColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)))),
        onPressed: _isLoading
            ? null
            : () async {
                _toggleLoading();
                await widget.onClicked();
                _toggleLoading();
              },
        child: _isLoading
            ? LoadingAnimationWidget.inkDrop(
                color: ColorSet.whiteColor, size: 25)
            : Text(
                widget.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
