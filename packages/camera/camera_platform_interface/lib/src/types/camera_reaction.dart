// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Standard camera reaction types supported by the system.
///
/// These values map to the official `AVCaptureReactionType` on iOS.
/// Note: Apps must opt-in by setting the `NSCameraReactionEffectsEnabled` key to `true`
/// in their `Info.plist` file, unless they use the Voice over IP background mode.
/// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype
enum CameraReaction {
  /// A thumbs-up reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/thumbsup
  thumbsUp,

  /// A thumbs-down reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/thumbsdown
  thumbsDown,

  /// A balloons reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/balloons
  balloons,

  /// A heart reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/heart
  heart,

  /// A fireworks reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/fireworks
  fireworks,

  /// A rain reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/rain
  rain,

  /// A confetti reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/confetti
  confetti,

  /// A lasers reaction.
  /// See https://developer.apple.com/documentation/avfoundation/avcapturereactiontype/lasers
  lasers,
}
