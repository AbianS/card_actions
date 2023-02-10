import 'package:flutter/material.dart';
import 'card_actions.dart';

class CardProvider with ChangeNotifier {
  late Color splashColor;
  late bool showToolTip;
  late bool whenCallFunctionCloseCard;
  late CardActionAxis hoverDirection;
  late MouseCursor buttonsCursor;

  late double heightCard;
  late double widthCard;

  bool _isHovered = false;
  late double _height = heightCard;
  late double width = widthCard;
  double get height => _height;

  getMatrixTransform() {
    if (hoverDirection == CardActionAxis.bottom) {
      return Matrix4.identity()..setTranslationRaw(0, 50, 0);
    }

    if (hoverDirection == CardActionAxis.right) {
      return Matrix4.identity()..setTranslationRaw(50, 0, 0);
    }
  }

  bool isBottom() {
    if (hoverDirection == CardActionAxis.bottom) return true;

    return false;
  }

  getAligment() {
    if (hoverDirection == CardActionAxis.bottom) {
      return Alignment.topCenter;
    }

    if (hoverDirection == CardActionAxis.right) {
      return Alignment.centerLeft;
    }
  }

  bool get isHovered => _isHovered;
  set isHovered(bool value) {
    if (hoverDirection == CardActionAxis.bottom) {
      _isHovered = value;
      if (value) _height = _height + 50;
      if (!value) _height = _height - 50;
    }

    if (hoverDirection == CardActionAxis.right) {
      _isHovered = value;
      if (value) width = width + 50;
      if (!value) width = width - 50;
    }

    notifyListeners();
  }
}
