import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MySimpleLikeButton extends StatefulWidget {
  const MySimpleLikeButton({super.key});

  @override
  State<MySimpleLikeButton> createState() => _MySimpleLikeButtonState();
}

class _MySimpleLikeButtonState extends State<MySimpleLikeButton>
    with SingleTickerProviderStateMixin {
  IconData _icon = CupertinoIcons.heart;

  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animation = Tween<double>(
      begin: MediaQuery.of(context).size.height * 0.03,
      end: MediaQuery.of(context).size.height * 0.04,
    ).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    return GestureDetector(
      onTap: () {
        if (_icon == CupertinoIcons.heart) {
          setState(() {
            _icon = CupertinoIcons.heart_fill;
          });
          _animationController.forward();
          Future.delayed(
            const Duration(milliseconds: 250),
            () {
              _animationController.reverse();
            },
          );
        } else {
          setState(() {
            _icon = CupertinoIcons.heart;
          });
        }
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 125),
            child: Icon(
              _icon,
              size: _animation.value,
              key: ValueKey<IconData>(_icon),
            ),
          ),
        ),
      ),
    );
  }
}
