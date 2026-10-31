import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Canvas equivalent of CSS mix-blend-mode: difference for the fixed header.
/// Header descendants are deliberately kept free of composited backdrop filters.
class DifferenceHeader extends SingleChildRenderObjectWidget {
  const DifferenceHeader({super.key, required super.child});
  @override
  RenderObject createRenderObject(BuildContext context) =>
      _DifferenceHeaderBox();
}

class _DifferenceHeaderBox extends RenderProxyBox {
  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.saveLayer(
      offset & size,
      Paint()
        ..blendMode = BlendMode.difference
        ..colorFilter = const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
    super.paint(context, offset);
    context.canvas.restore();
  }
}
