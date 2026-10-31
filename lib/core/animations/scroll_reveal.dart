import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// VisibilityDetector observes Flutter render objects, including canvas web builds.
class ScrollReveal extends StatefulWidget {
  final Widget child;
  const ScrollReveal({super.key, required this.child});
  @override
  State<ScrollReveal> createState() => _ScrollRevealState();
}

class _ScrollRevealState extends State<ScrollReveal> {
  bool _visible = false;
  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    return VisibilityDetector(
      key: ValueKey(this),
      onVisibilityChanged: (info) {
        if (!_visible && info.visibleFraction > 0 && mounted)
          setState(() => _visible = true);
      },
      child: AnimatedOpacity(
        opacity: _visible || reduced ? 1 : 0,
        duration: reduced ? Duration.zero : Duration(milliseconds: 650),
        child: AnimatedSlide(
          offset: _visible || reduced ? Offset.zero : Offset(0, 0.025),
          duration: reduced ? Duration.zero : Duration(milliseconds: 650),
          curve: Curves.easeOutCubic,
          child: widget.child,
        ),
      ),
    );
  }
}
