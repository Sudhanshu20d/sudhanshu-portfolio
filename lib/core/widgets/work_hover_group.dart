import 'dart:math' as math;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Coordinates sibling dimming and an overlay that never intercepts project links.
class WorkHoverGroup extends StatefulWidget {
  final List<Widget> children;
  final List<String?> previews;
  const WorkHoverGroup({
    super.key,
    required this.children,
    this.previews = const [],
  });
  @override
  State<WorkHoverGroup> createState() => _WorkHoverGroupState();
}

class _WorkHoverGroupState extends State<WorkHoverGroup> {
  int? _hovered;
  OverlayEntry? _preview;
  Offset _position = Offset.zero;

  void _hide() {
    _preview?.remove();
    _preview = null;
  }

  void _move(PointerEvent event, int index) {
    if (MediaQuery.disableAnimationsOf(context)) return;
    if (event.kind != PointerDeviceKind.mouse ||
        MediaQuery.sizeOf(context).width < 960)
      return;
    _position = event.position;
    if (_hovered != index) setState(() => _hovered = index);
    final image = index < widget.previews.length
        ? widget.previews[index]
        : null;
    if (image == null) {
      _hide();
      return;
    }
    if (_preview == null) {
      _preview = OverlayEntry(
        builder: (context) {
          final size = MediaQuery.sizeOf(context);
          return Positioned(
            left: math
                .min(_position.dx + 24, size.width - 232)
                .clamp(8.0, size.width),
            top: math
                .min(_position.dy + 24, size.height - 332)
                .clamp(8.0, size.height),
            child: IgnorePointer(
              child: ExcludeSemantics(
                child: Container(
                  width: 216,
                  height: 312,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.accent),
                    boxShadow: [
                      BoxShadow(color: Colors.black38, blurRadius: 32),
                    ],
                  ),
                  child: Image.asset(
                    widget.previews[_hovered!]!,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      );
      Overlay.of(context).insert(_preview!);
    }
    _preview?.markNeedsBuild();
  }

  @override
  void dispose() {
    _hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duration = MediaQuery.disableAnimationsOf(context)
        ? Duration.zero
        : Duration(milliseconds: 180);
    return Column(
      children: List.generate(
        widget.children.length,
        (i) => MouseRegion(
          onHover: (event) => _move(event, i),
          onExit: (_) {
            _hide();
            setState(() => _hovered = null);
          },
          child: AnimatedOpacity(
            duration: duration,
            opacity: _hovered != null && _hovered != i ? 0.4 : 1,
            child: AnimatedContainer(
              duration: duration,
              transform: Matrix4.translationValues(
                _hovered == i && duration != Duration.zero ? 8 : 0,
                0,
                0,
              ),
              child: widget.children[i],
            ),
          ),
        ),
      ),
    );
  }
}
