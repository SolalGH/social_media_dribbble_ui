import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:link_ui_sandbox/utilities/my_provider.dart';
import 'package:provider/provider.dart';

class MyExpandButton extends StatefulWidget {
  const MyExpandButton({super.key});

  @override
  State<MyExpandButton> createState() => _MyExpandButtonState();
}

class _MyExpandButtonState extends State<MyExpandButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  bool isExpanded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<MyProvider>(context, listen: false).addValue("expand");
        isExpanded
            ? _animationController.reverse()
            : _animationController.forward();
        isExpanded = !isExpanded;
      },
      child: Container(
        width: MediaQuery.of(context).size.height * 0.065,
        height: MediaQuery.of(context).size.height * 0.065,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Colors.white,
        ),
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0250,
        ),
        child: Center(
          child: Transform.rotate(
            angle: _animation.value,
            child: Icon(
              CupertinoIcons.arrow_up,
              size: MediaQuery.of(context).size.height * 0.03,
            ),
          ),
        ),
      ),
    );
  }
}
