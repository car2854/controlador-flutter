import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {

  final String text;
  final bool expanded;
  final bool noBorder;
  final double sizeWidth;
  final double sizeHeight;
  final Color backgroundColor;
  final Color primaryColor;
  final Function() onPressed;
  const ButtonWidget({
    Key? key, 
    required this.text, 
    required this.onPressed,
    this.expanded = false, 
    this.sizeWidth = 0.0, 
    this.sizeHeight = 0.0, 
    this.backgroundColor = Colors.white, 
    this.primaryColor = Colors.black,
    this.noBorder = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: Text(text),
      style: TextButton.styleFrom(
        primary: primaryColor,
        backgroundColor: backgroundColor,
        
        minimumSize: (expanded) ? Size(MediaQuery.of(context).size.width-20,40) : Size(sizeWidth, sizeHeight),
        shape: (noBorder)? RoundedRectangleBorder(side: const BorderSide(
          width: 0,
          style: BorderStyle.solid,
          color: Color.fromARGB(0, 255, 255, 255)
        ), borderRadius: BorderRadius.circular(0)) : null
      ),
    );
  }
}