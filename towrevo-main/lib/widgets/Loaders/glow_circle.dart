import 'package:flutter/material.dart';
import 'package:towrevo/utilities/towrevo_appcolor.dart';

class GlowCircle extends StatefulWidget {
  final double glowHeight;
  final double glowWidth;
  final double glowbegin;
  final double glowend;
  final int miliseconds;

  const GlowCircle({
    required this.glowHeight,
    required this.glowWidth,
    required this.glowbegin,
    required this.glowend,
    required this.miliseconds,
    Key? key,
  }) : super(key: key);

  @override
  State<GlowCircle> createState() => _GlowCircleState();
}

class _GlowCircleState extends State<GlowCircle>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation? _animation;

  bool init = true;

  @override
  void didChangeDependencies() {
    if (init) {
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: widget.miliseconds));
      _animationController!.repeat(reverse: true);
      _animation = Tween(
        begin: widget.glowbegin,
        end: widget.glowend,
      ).animate(_animationController!)
        ..addListener(() {
          setState(() {});
        });
    }
    init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _animationController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.glowWidth,
      height: widget.glowHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.5),
            blurRadius: _animation!.value,
            spreadRadius: _animation!.value,
          )
        ],
      ),
    );
  }
}
