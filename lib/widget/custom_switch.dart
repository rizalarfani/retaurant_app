import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/colors_theme.dart';

class CustomSwith extends StatefulWidget {
  final bool? value;
  final Widget? thumChild;
  final ValueChanged<bool> onChanged;

  const CustomSwith(
      {Key? key, this.value, required this.onChanged, this.thumChild})
      : super(key: key);

  @override
  State<CustomSwith> createState() => _CustomSwithState();
}

class _CustomSwithState extends State<CustomSwith>
    with SingleTickerProviderStateMixin {
  Animation? circleAnimation;
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(microseconds: 100));
    circleAnimation = AlignmentTween(
            begin: widget.value! ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value! ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: animationController!, curve: Curves.linear));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            animationController!.isCompleted
                ? animationController!.reverse()
                : animationController!.forward();
            widget.value! == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 60,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: !widget.value! ? Colors.grey : ColorsTheme.primaryColor,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, bottom: 2.0, right: 2.0, left: 2.0),
              child: Container(
                alignment: widget.value!
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Center(child: widget.thumChild),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
