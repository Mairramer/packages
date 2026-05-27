// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';

/// Group of camera effects and hardware vendor extensions that are comparable
/// across Android and iOS platforms.
enum CameraEffectType {
  /// Depth-of-field background blur effect (Portrait Mode).
  ///
  /// On Android, this represents the CameraX Bokeh extension (`ExtensionMode.BOKEH`).
  /// See https://developer.android.com/reference/androidx/camera/extensions/ExtensionMode#BOKEH()
  ///
  /// On iOS, this represents the AVFoundation portrait video effect.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturedevice/isportraiteffectenabled
  portraitBlur,

  /// High Dynamic Range (HDR) photography or video capture.
  ///
  /// On Android, this represents the CameraX HDR extension (`ExtensionMode.HDR`).
  /// See https://developer.android.com/reference/androidx/camera/extensions/ExtensionMode#HDR()
  hdr,

  /// Enhanced quality image capture under low-light conditions.
  ///
  /// On Android, this represents the CameraX Night extension (`ExtensionMode.NIGHT`).
  /// See https://developer.android.com/reference/androidx/camera/extensions/ExtensionMode#NIGHT()
  night,

  /// Facial cosmetic edits and skin-toning adjustments.
  ///
  /// On Android, this represents the CameraX Face Retouch extension (`ExtensionMode.FACE_RETOUCH`).
  /// See https://developer.android.com/reference/androidx/camera/extensions/ExtensionMode#FACE_RETOUCH()
  faceRetouch,

  /// Intelligent camera frame cropping and zooming to keep subjects in shot.
  ///
  /// On iOS, this represents the AVFoundation Center Stage effect.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturedevice/iscenterstageenabled
  centerStage,

  /// Studio lighting simulation by subtly darkening the background and illuminating the subject.
  ///
  /// On iOS, this represents the AVFoundation Studio Light effect.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturedevice/isstudiolightenabled
  studioLight,

  /// Multi-layered animations triggered by hand gestures.
  ///
  /// On iOS, this represents the AVFoundation Reaction Effects.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturedevice/reactioneffectsenabled
  reactions,
}

/// Represents the real-time state of a camera effect on the device.
@immutable
class CameraEffectState {
  /// Constructs a [CameraEffectState].
  const CameraEffectState({
    required this.type,
    required this.isSupported,
    required this.isActive,
    required this.isSystemManaged,
  });

  /// The camera effect type.
  final CameraEffectType type;

  /// Indicates whether the hardware/OS on the current device supports this effect.
  final bool isSupported;

  /// Indicates whether the effect is actively processing the preview or capture.
  final bool isActive;

  /// If `true`, the effect control is managed globally by the system OS (e.g., iOS Control Center).
  /// If `false`, the effect can be toggled programmatically via the application (e.g., Android CameraX Vendor Extensions).
  final bool isSystemManaged;
}
