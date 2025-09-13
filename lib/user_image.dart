import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';

final userImageProvider = StateProvider<Uint8List?>((ref) => null);
// InteractiveViewerの現在のTransformationControllerを保持するProvider
final transformationControllerProvider = Provider.autoDispose(
  (ref) => TransformationController(),
);

// 現在のスケール値を保持するProvider
final currentScaleProvider = StateProvider<double>((ref) => 1.0);
