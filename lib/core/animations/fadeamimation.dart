import 'package:flutter/material.dart';

class FadeAnimation extends StatefulWidget {
  const FadeAnimation({super.key,required this.child});
  final Widget child;

  @override
  State<FadeAnimation> createState() => _FadeAnimationState();
}

class _FadeAnimationState extends State<FadeAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 600));
    fade = Tween<double>(begin: 0,end: 1).animate(_controller);
    _controller.forward();
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: fade,child: widget.child,);
  }
}