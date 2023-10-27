import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final MovieTween tween = MovieTween()
      ..scene(begin: const Duration(milliseconds: 0),
          end: const Duration(milliseconds: 500))
          .tween('width', Tween(begin: 0.0, end: 1.0))
    ..scene(begin: const Duration(milliseconds: 0),
    end: const Duration(milliseconds: 500)) .tween('height', Tween(begin: -30.0, end: 0.0));
          curve: Curves.easeOut;

    return PlayAnimationBuilder(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, value, child) {
        return Container(
           // Get animated values


        );
      },
    );
  }
}