import 'package:flutter/material.dart';

class LetterReveal extends StatefulWidget {
  final String text;
  final TextStyle style;
  const LetterReveal(this.text, {super.key, required this.style});
  @override
  State<LetterReveal> createState() => _LetterRevealState();
}

class _LetterRevealState extends State<LetterReveal>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration:
        WidgetsBinding
            .instance
            .platformDispatcher
            .accessibilityFeatures
            .disableAnimations
        ? Duration.zero
        : Duration(milliseconds: 1100),
  )..forward();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduced = MediaQuery.disableAnimationsOf(context);
    return Semantics(
      label: widget.text,
      header: true,
      child: ExcludeSemantics(
        child: ClipRect(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(widget.text.length, (i) {
                final start = i / widget.text.length * 0.35;
                final t = reduced
                    ? 1.0
                    : Curves.easeOutCubic.transform(
                        ((_controller.value - start) / 0.65).clamp(0.0, 1.0),
                      );
                return Transform.translate(
                  offset: Offset(
                    0,
                    (1 - t) * (widget.style.fontSize ?? 80) * 1.2,
                  ),
                  child: Opacity(
                    opacity: t,
                    child: Text(
                      widget.text[i],
                      style: widget.style,
                      // Tight headline leading must not crop glyph descenders.
                      textHeightBehavior: const TextHeightBehavior(
                        applyHeightToFirstAscent: false,
                        applyHeightToLastDescent: false,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
