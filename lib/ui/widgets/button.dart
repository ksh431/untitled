import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untilted/ui/theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function() onTap;

  MyButton({
    this.onTap,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: primaryClr
        ) ,
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white)
          ),
        ),
      ),
    );
  }
}
