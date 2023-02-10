import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_action_button.dart';
import 'card_provider.dart';

enum CardActionAxis { right, bottom }

class CardActions extends StatelessWidget {
  const CardActions({
    super.key,
    required this.child,
    required this.width,
    required this.height,
    required this.actions,
    this.cardCursor = SystemMouseCursors.basic,
    this.buttonsCursor = SystemMouseCursors.basic,
    this.borderRadius = 0,
    this.showToolTip = true,
    this.axisDirection = CardActionAxis.bottom,
    this.splashColor = Colors.white24,
    this.closeCardWhenExecuteFunction = false,
    this.backgroundColor = const Color(0xff242120),
  });

  /// the type of cursor displayed when hovering on the card
  final MouseCursor cardCursor;

  /// the type of cursor displayed when hovering over buttons
  final MouseCursor buttonsCursor;

  /// Background color
  final Color backgroundColor;

  /// list of all the buttons that the card is going to have
  final List<CardActionButton> actions;

  /// your card
  final Widget child;

  /// widget width
  final double width;

  /// widget height
  final double height;

  /// the radius of the edge that the card is to have
  final double borderRadius;

  /// Splash color when hovering
  final Color splashColor;

  /// Show/Hide toolTips
  final bool showToolTip;

  /// close the card when you press a button
  final bool closeCardWhenExecuteFunction;

  /// CardActions Axis Direction
  final CardActionAxis axisDirection;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardProvider(),
      child: Builder(
        builder: (BuildContext context) {
          final cardProvider = Provider.of<CardProvider>(context);

          final transform = cardProvider.isHovered
              ? cardProvider.getMatrixTransform()
              : Matrix4.identity();

          cardProvider.splashColor = splashColor;
          cardProvider.buttonsCursor = buttonsCursor;
          cardProvider.showToolTip = showToolTip;
          cardProvider.whenCallFunctionCloseCard = closeCardWhenExecuteFunction;
          cardProvider.hoverDirection = axisDirection;
          cardProvider.heightCard = height;
          cardProvider.widthCard = width;
          return MouseRegion(
            cursor: cardCursor,
            onEnter: (_) {
              cardProvider.isHovered = true;
            },
            onExit: (_) {
              cardProvider.isHovered = false;
            },
            child: AnimatedContainer(
              width: cardProvider.width,
              height: cardProvider.height,
              duration: const Duration(milliseconds: 200),
              child: Stack(
                alignment: cardProvider.getAligment(),
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    transform: transform,
                    child: Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: SizedBox(
                        height: height,
                        width: width,
                        child: cardProvider.isBottom()
                            ? _BottomWidget(
                                borderRadius: borderRadius,
                                width: width,
                                actions: actions,
                              )
                            : _RightWidget(
                                borderRadius: borderRadius,
                                height: height,
                                actions: actions,
                              ),
                      ),
                    ),
                  ),
                  child,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RightWidget extends StatelessWidget {
  const _RightWidget({
    required this.borderRadius,
    required this.height,
    required this.actions,
  });
  final double borderRadius;
  final double height;
  final List<CardActionButton> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
          child: Column(
            mainAxisAlignment: actions.length == 1
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: [
              ...actions,
            ],
          ),
        ),
      ],
    );
  }
}

class _BottomWidget extends StatelessWidget {
  const _BottomWidget({
    required this.borderRadius,
    required this.width,
    required this.actions,
  });

  final double borderRadius;
  final double width;
  final List<CardActionButton> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(borderRadius),
            bottomRight: Radius.circular(borderRadius),
          ),
          child: Row(
            mainAxisAlignment: actions.length == 1
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceAround,
            children: [
              ...actions,
            ],
          ),
        ),
      ],
    );
  }
}
