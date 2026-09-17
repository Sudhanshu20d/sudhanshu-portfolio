import 'package:flutter/material.dart';

class Tilt3DCard extends StatefulWidget {
  final Widget child;
  final double maxTiltAngle;
  final BorderRadius? borderRadius;

  const Tilt3DCard({
    super.key,
    required this.child,
    this.maxTiltAngle = 0.08,
    this.borderRadius,
  });

  @override
  State<Tilt3DCard> createState() => _Tilt3DCardState();
}

class _Tilt3DCardState extends State<Tilt3DCard> {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovered = false;

  void _onHover(PointerEvent event, Size size) {
    if (size.width == 0 || size.height == 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final normalizedX = (event.localPosition.dx - center.dx) / center.dx;
    final normalizedY = (event.localPosition.dy - center.dy) / center.dy;

    setState(() {
      _rotateY = normalizedX * widget.maxTiltAngle;
      _rotateX = -normalizedY * widget.maxTiltAngle;
      _isHovered = true;
    });
  }

  void _onExit(PointerEvent event) {
    setState(() {
      _rotateX = 0.0;
      _rotateY = 0.0;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = Size(constraints.maxWidth, constraints.maxHeight);
        return MouseRegion(
          onHover: (e) => _onHover(e, size),
          onExit: _onExit,
          child: TweenAnimationBuilder<Matrix4>(
            tween: Matrix4Tween(
              begin: Matrix4.identity(),
              end: () {
                final s = _isHovered ? 1.02 : 1.0;
                return Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(_rotateX)
                  ..rotateY(_rotateY)
                  ..scaleByDouble(s, s, 1.0, 1.0);
              }(),
            ),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOutCubic,
            builder: (context, transform, child) {
              return Transform(
                transform: transform,
                alignment: FractionalOffset.center,
                child: widget.child,
              );
            },
          ),
        );
      },
    );
  }
}
