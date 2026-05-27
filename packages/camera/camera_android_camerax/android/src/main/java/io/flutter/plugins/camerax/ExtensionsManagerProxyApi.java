// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.camerax;

import androidx.annotation.NonNull;
import androidx.camera.core.CameraSelector;
import androidx.camera.extensions.ExtensionMode;
import androidx.camera.extensions.ExtensionsManager;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.core.content.ContextCompat;
import com.google.common.util.concurrent.ListenableFuture;
import java.util.concurrent.ExecutionException;
import kotlin.Result;
import kotlin.Unit;
import kotlin.jvm.functions.Function1;

/**
 * ProxyApi implementation for {@link ExtensionsManager}. This class may handle instantiating native
 * object instances that are attached to a Dart instance or handle method calls on the associated
 * native class or an instance of that class.
 */
class ExtensionsManagerProxyApi extends PigeonApiExtensionsManager {
  ExtensionsManagerProxyApi(@NonNull ProxyApiRegistrar pigeonRegistrar) {
    super(pigeonRegistrar);
  }

  @NonNull
  @Override
  public ProxyApiRegistrar getPigeonRegistrar() {
    return (ProxyApiRegistrar) super.getPigeonRegistrar();
  }

  @Override
  public void getInstance(
      @NonNull ProcessCameraProvider provider,
      @NonNull Function1<? super Result<ExtensionsManager>, Unit> callback) {
    ListenableFuture<ExtensionsManager> future =
        ExtensionsManager.getInstanceAsync(getPigeonRegistrar().getContext(), provider);
    future.addListener(
        () -> {
          try {
            ResultCompat.success(future.get(), callback);
          } catch (ExecutionException | InterruptedException e) {
            ResultCompat.failure(e, callback);
          }
        },
        ContextCompat.getMainExecutor(getPigeonRegistrar().getContext()));
  }

  @Override
  public boolean isExtensionAvailable(
      @NonNull ExtensionsManager pigeonInstance,
      @NonNull CameraSelector cameraSelector,
      @NonNull CameraXExtensionMode mode) {
    return pigeonInstance.isExtensionAvailable(cameraSelector, toNativeExtensionMode(mode));
  }

  @NonNull
  @Override
  public CameraSelector getExtensionEnabledCameraSelector(
      @NonNull ExtensionsManager pigeonInstance,
      @NonNull CameraSelector cameraSelector,
      @NonNull CameraXExtensionMode mode) {
    return pigeonInstance.getExtensionEnabledCameraSelector(
        cameraSelector, toNativeExtensionMode(mode));
  }

  private int toNativeExtensionMode(@NonNull CameraXExtensionMode mode) {
    switch (mode) {
      case AUTO:
        return ExtensionMode.AUTO;
      case BOKEH:
        return ExtensionMode.BOKEH;
      case HDR:
        return ExtensionMode.HDR;
      case NIGHT:
        return ExtensionMode.NIGHT;
      case FACE_RETOUCH:
        return ExtensionMode.FACE_RETOUCH;
      case NONE:
      default:
        return ExtensionMode.NONE;
    }
  }
}
