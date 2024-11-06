// Mocks generated by Mockito 5.4.4 from annotations
// in interactive_media_ads/test/android/content_progress_provider_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:interactive_media_ads/src/android/interactive_media_ads.g.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakePigeonInstanceManager_0 extends _i1.SmartFake
    implements _i2.PigeonInstanceManager {
  _FakePigeonInstanceManager_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeContentProgressProvider_1 extends _i1.SmartFake
    implements _i2.ContentProgressProvider {
  _FakeContentProgressProvider_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ContentProgressProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockContentProgressProvider extends _i1.Mock
    implements _i2.ContentProgressProvider {
  @override
  _i2.PigeonInstanceManager get pigeon_instanceManager => (super.noSuchMethod(
        Invocation.getter(#pigeon_instanceManager),
        returnValue: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
        returnValueForMissingStub: _FakePigeonInstanceManager_0(
          this,
          Invocation.getter(#pigeon_instanceManager),
        ),
      ) as _i2.PigeonInstanceManager);

  @override
  _i3.Future<void> setContentProgress(_i2.VideoProgressUpdate? update) =>
      (super.noSuchMethod(
        Invocation.method(
          #setContentProgress,
          [update],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i2.ContentProgressProvider pigeon_copy() => (super.noSuchMethod(
        Invocation.method(
          #pigeon_copy,
          [],
        ),
        returnValue: _FakeContentProgressProvider_1(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
        returnValueForMissingStub: _FakeContentProgressProvider_1(
          this,
          Invocation.method(
            #pigeon_copy,
            [],
          ),
        ),
      ) as _i2.ContentProgressProvider);
}
