// Copyright 2013 The Flutter Authors
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package io.flutter.plugins.camerax;

import static org.junit.Assert.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.spy;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

import androidx.camera.core.CameraSelector;
import androidx.camera.extensions.ExtensionMode;
import androidx.camera.extensions.ExtensionsManager;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.core.content.ContextCompat;
import com.google.common.util.concurrent.Futures;
import com.google.common.util.concurrent.ListenableFuture;
import java.util.concurrent.Executor;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.ArgumentCaptor;
import org.mockito.MockedStatic;
import org.mockito.Mockito;
import org.mockito.stubbing.Answer;
import org.robolectric.RobolectricTestRunner;

@RunWith(RobolectricTestRunner.class)
public class ExtensionsManagerProxyApiTest {
  @Test
  public void getInstance_returnsExpectedExtensionsManagerInFutureCallback() {
    final PigeonApiExtensionsManager api =
        new TestProxyApiRegistrar().getPigeonApiExtensionsManager();

    final ExtensionsManager instance = mock(ExtensionsManager.class);
    final ListenableFuture<ExtensionsManager> extensionsManagerFuture =
        spy(Futures.immediateFuture(instance));

    final ProcessCameraProvider processCameraProvider = mock(ProcessCameraProvider.class);

    try (MockedStatic<ExtensionsManager> mockedExtensionsManager =
            Mockito.mockStatic(ExtensionsManager.class);
        MockedStatic<ContextCompat> mockedContextCompat = Mockito.mockStatic(ContextCompat.class)) {
      mockedExtensionsManager
          .when(() -> ExtensionsManager.getInstanceAsync(any(), eq(processCameraProvider)))
          .thenAnswer(
              (Answer<ListenableFuture<ExtensionsManager>>) invocation -> extensionsManagerFuture);

      mockedContextCompat
          .when(() -> ContextCompat.getMainExecutor(any()))
          .thenAnswer((Answer<Executor>) invocation -> mock(Executor.class));

      final ArgumentCaptor<Runnable> runnableCaptor = ArgumentCaptor.forClass(Runnable.class);

      final ExtensionsManager[] resultArray = {null};
      api.getInstance(
          processCameraProvider,
          ResultCompat.asCompatCallback(
              reply -> {
                resultArray[0] = reply.getOrNull();
                return null;
              }));

      verify(extensionsManagerFuture).addListener(runnableCaptor.capture(), any());
      runnableCaptor.getValue().run();
      assertEquals(resultArray[0], instance);
    }
  }

  @Test
  public void isExtensionAvailable_returnsExpectedIsExtensionAvailable() {
    final PigeonApiExtensionsManager api =
        new TestProxyApiRegistrar().getPigeonApiExtensionsManager();

    final ExtensionsManager instance = mock(ExtensionsManager.class);
    final CameraSelector cameraSelector = mock(CameraSelector.class);
    final Boolean value = true;
    when(instance.isExtensionAvailable(cameraSelector, ExtensionMode.BOKEH)).thenReturn(value);

    assertEquals(
        value, api.isExtensionAvailable(instance, cameraSelector, CameraXExtensionMode.BOKEH));
  }

  @Test
  public void getExtensionEnabledCameraSelector_returnsExpectedCameraSelector() {
    final PigeonApiExtensionsManager api =
        new TestProxyApiRegistrar().getPigeonApiExtensionsManager();

    final ExtensionsManager instance = mock(ExtensionsManager.class);
    final CameraSelector cameraSelector = mock(CameraSelector.class);
    final CameraSelector value = mock(CameraSelector.class);

    when(instance.getExtensionEnabledCameraSelector(cameraSelector, ExtensionMode.NIGHT))
        .thenReturn(value);

    assertEquals(
        value,
        api.getExtensionEnabledCameraSelector(
            instance, cameraSelector, CameraXExtensionMode.NIGHT));
  }
}
