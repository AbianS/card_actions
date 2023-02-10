import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_provider.dart';

class CardActionButton extends StatefulWidget {
  const CardActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPress,
    this.closeCardWhenPress = false,
    this.cursor,
  });

  /// Cursor displayed when hovering on the button
  final MouseCursor? cursor;

  /// Button icon
  final Icon icon;

  /// text to be displayed in the Tool Tip
  final String label;

  /// callback to be executed when you press the button
  final VoidCallback onPress;

  /// when you press the button, the card closes
  final bool closeCardWhenPress;

  @override
  State<CardActionButton> createState() => _CardActionButtonState();
}

class _CardActionButtonState extends State<CardActionButton> {
  bool buttonIsHovered = false;
  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context, listen: false);

    MouseCursor getCurrentCursor() {
      if (widget.cursor != null) {
        return widget.cursor!;
      }

      return cardProvider.buttonsCursor;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () {
          widget.onPress();

          if (cardProvider.whenCallFunctionCloseCard ||
              widget.closeCardWhenPress) {
            cardProvider.isHovered = false;
          }
        },
        child: MouseRegion(
          cursor: getCurrentCursor(),
          onEnter: (event) {
            setState(() {
              buttonIsHovered = true;
            });
          },
          onExit: (event) {
            setState(() {
              buttonIsHovered = false;
            });
          },
          child: cardProvider.showToolTip
              ? Tooltip(
                  message: widget.label,
                  textStyle: const TextStyle(fontSize: 18, color: Colors.white),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff242120),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 35,
                  verticalOffset: cardProvider.isBottom() ? -70 : 30,
                  child: _BodyButton(
                    buttonIsHovered: buttonIsHovered,
                    cardProvider: cardProvider,
                    widget: widget,
                  ),
                )
              : _BodyButton(
                  buttonIsHovered: buttonIsHovered,
                  cardProvider: cardProvider,
                  widget: widget,
                ),
        ),
      ),
    );
  }
}

class _BodyButton extends StatelessWidget {
  const _BodyButton({
    required this.buttonIsHovered,
    required this.cardProvider,
    required this.widget,
  });

  final bool buttonIsHovered;
  final CardProvider cardProvider;
  final CardActionButton widget;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: cardProvider.isBottom() ? null : 50,
      height: 60,
      decoration: BoxDecoration(
        color: buttonIsHovered ? cardProvider.splashColor : Colors.transparent,
      ),
      child: widget.icon,
    );
  }
}
