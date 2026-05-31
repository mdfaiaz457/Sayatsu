import 'package:flutter/material.dart';

/// Extension methods for BuildContext
extension ContextExtensions on BuildContext {
  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;
  
  /// Get screen width
  double get screenWidth => screenSize.width;
  
  /// Get screen height
  double get screenHeight => screenSize.height;
  
  /// Check if device is in landscape mode
  bool get isLandscape => MediaQuery.of(this).orientation == Orientation.landscape;
  
  /// Check if device is in portrait mode
  bool get isPortrait => MediaQuery.of(this).orientation == Orientation.portrait;
  
  /// Get device padding (for notches/safe areas)
  EdgeInsets get devicePadding => MediaQuery.of(this).padding;
}
