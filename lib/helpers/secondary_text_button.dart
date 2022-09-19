import 'package:flutter/material.dart';

class SecondaryTextButton extends StatefulWidget {
  SecondaryTextButton({
    key,
    required this.onPressed,
    this.onLongPress,
    this.onHover,
    this.onFocusChange,
    this.focusNode,
    this.autofocus = false,
    this.clipBehavior = Clip.none,
    this.statesController,
    required this.child,
  });

  final VoidCallback? onPressed;
  final VoidCallback? onLongPress;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocusChange;
  final Clip clipBehavior;
  final FocusNode? focusNode;
  final bool autofocus;
  final MaterialStatesController? statesController;
  final Widget child;

  @override
  State<SecondaryTextButton> createState() => _SecondaryTextButtonState();
}

class _SecondaryTextButtonState extends State<SecondaryTextButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widget.key,
      onPressed: widget.onPressed,
      onLongPress: widget.onLongPress,
      onHover: widget.onHover,
      onFocusChange: widget.onFocusChange,
      style: TextButton.styleFrom(
          foregroundColor:
              Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black),
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      clipBehavior: widget.clipBehavior,
      statesController: widget.statesController,
      child: widget.child,
    );
  }
}
