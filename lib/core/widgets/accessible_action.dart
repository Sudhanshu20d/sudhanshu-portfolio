import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Keeps the original tap callback while adding keyboard and screen-reader access.
class AccessibleAction extends StatefulWidget {
  final VoidCallback? onTap;
  final HitTestBehavior behavior;
  final Widget child;
  const AccessibleAction({
    super.key,
    this.onTap,
    this.behavior = HitTestBehavior.opaque,
    required this.child,
  });

  @override
  State<AccessibleAction> createState() => _AccessibleActionState();
}

class _AccessibleActionState extends State<AccessibleAction> {
  bool _focused = false;
  @override
  Widget build(BuildContext context) => FocusableActionDetector(
    enabled: widget.onTap != null,
    mouseCursor: SystemMouseCursors.click,
    onShowFocusHighlight: (value) => setState(() => _focused = value),
    actions: <Type, Action<Intent>>{
      ActivateIntent: CallbackAction<ActivateIntent>(
        onInvoke: (_) {
          widget.onTap?.call();
          return null;
        },
      ),
    },
    child: Semantics(
      button: true,
      enabled: widget.onTap != null,
      onTap: widget.onTap,
      child: Container(
        foregroundDecoration: BoxDecoration(
          border: Border.all(
            color: _focused ? AppColors.accent : Colors.transparent,
            width: 2,
          ),
        ),
        child: GestureDetector(
          behavior: widget.behavior,
          onTap: widget.onTap,
          excludeFromSemantics: true,
          child: widget.child,
        ),
      ),
    ),
  );
}
