// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#ifndef PIGEON_MESSAGES_G_H_
#define PIGEON_MESSAGES_G_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

/**
 * FfsPlatformFileChooserActionType:
 * FILE_SELECTOR_LINUX_PLATFORM_FILE_CHOOSER_ACTION_TYPE_OPEN:
 * FILE_SELECTOR_LINUX_PLATFORM_FILE_CHOOSER_ACTION_TYPE_CHOOSE_DIRECTORY:
 * FILE_SELECTOR_LINUX_PLATFORM_FILE_CHOOSER_ACTION_TYPE_SAVE:
 *
 * A Pigeon representation of the GTK_FILE_CHOOSER_ACTION_* options.
 */
typedef enum {
  FILE_SELECTOR_LINUX_PLATFORM_FILE_CHOOSER_ACTION_TYPE_OPEN = 0,
  FILE_SELECTOR_LINUX_PLATFORM_FILE_CHOOSER_ACTION_TYPE_CHOOSE_DIRECTORY = 1,
  FILE_SELECTOR_LINUX_PLATFORM_FILE_CHOOSER_ACTION_TYPE_SAVE = 2
} FfsPlatformFileChooserActionType;

/**
 * FfsPlatformTypeGroup:
 *
 * A Pigeon representation of the Linux portion of an `XTypeGroup`.
 */

G_DECLARE_FINAL_TYPE(FfsPlatformTypeGroup, ffs_platform_type_group, FFS,
                     PLATFORM_TYPE_GROUP, GObject)

/**
 * ffs_platform_type_group_new:
 * label: field in this object.
 * extensions: field in this object.
 * mime_types: field in this object.
 *
 * Creates a new #PlatformTypeGroup object.
 *
 * Returns: a new #FfsPlatformTypeGroup
 */
FfsPlatformTypeGroup* ffs_platform_type_group_new(const gchar* label,
                                                  FlValue* extensions,
                                                  FlValue* mime_types);

/**
 * ffs_platform_type_group_get_label
 * @object: a #FfsPlatformTypeGroup.
 *
 * Gets the value of the label field of @object.
 *
 * Returns: the field value.
 */
const gchar* ffs_platform_type_group_get_label(FfsPlatformTypeGroup* object);

/**
 * ffs_platform_type_group_get_extensions
 * @object: a #FfsPlatformTypeGroup.
 *
 * Gets the value of the extensions field of @object.
 *
 * Returns: the field value.
 */
FlValue* ffs_platform_type_group_get_extensions(FfsPlatformTypeGroup* object);

/**
 * ffs_platform_type_group_get_mime_types
 * @object: a #FfsPlatformTypeGroup.
 *
 * Gets the value of the mimeTypes field of @object.
 *
 * Returns: the field value.
 */
FlValue* ffs_platform_type_group_get_mime_types(FfsPlatformTypeGroup* object);

/**
 * FfsPlatformFileChooserOptions:
 *
 * Options for GKT file chooser.
 *
 * These correspond to gtk_file_chooser_set_* options.
 */

G_DECLARE_FINAL_TYPE(FfsPlatformFileChooserOptions,
                     ffs_platform_file_chooser_options, FFS,
                     PLATFORM_FILE_CHOOSER_OPTIONS, GObject)

/**
 * ffs_platform_file_chooser_options_new:
 * allowed_file_types: field in this object.
 * current_folder_path: field in this object.
 * current_name: field in this object.
 * accept_button_label: field in this object.
 * select_multiple: field in this object.
 *
 * Creates a new #PlatformFileChooserOptions object.
 *
 * Returns: a new #FfsPlatformFileChooserOptions
 */
FfsPlatformFileChooserOptions* ffs_platform_file_chooser_options_new(
    FlValue* allowed_file_types, const gchar* current_folder_path,
    const gchar* current_name, const gchar* accept_button_label,
    gboolean* select_multiple);

/**
 * ffs_platform_file_chooser_options_get_allowed_file_types
 * @object: a #FfsPlatformFileChooserOptions.
 *
 * Gets the value of the allowedFileTypes field of @object.
 *
 * Returns: the field value.
 */
FlValue* ffs_platform_file_chooser_options_get_allowed_file_types(
    FfsPlatformFileChooserOptions* object);

/**
 * ffs_platform_file_chooser_options_get_current_folder_path
 * @object: a #FfsPlatformFileChooserOptions.
 *
 * Gets the value of the currentFolderPath field of @object.
 *
 * Returns: the field value.
 */
const gchar* ffs_platform_file_chooser_options_get_current_folder_path(
    FfsPlatformFileChooserOptions* object);

/**
 * ffs_platform_file_chooser_options_get_current_name
 * @object: a #FfsPlatformFileChooserOptions.
 *
 * Gets the value of the currentName field of @object.
 *
 * Returns: the field value.
 */
const gchar* ffs_platform_file_chooser_options_get_current_name(
    FfsPlatformFileChooserOptions* object);

/**
 * ffs_platform_file_chooser_options_get_accept_button_label
 * @object: a #FfsPlatformFileChooserOptions.
 *
 * Gets the value of the acceptButtonLabel field of @object.
 *
 * Returns: the field value.
 */
const gchar* ffs_platform_file_chooser_options_get_accept_button_label(
    FfsPlatformFileChooserOptions* object);

/**
 * ffs_platform_file_chooser_options_get_select_multiple
 * @object: a #FfsPlatformFileChooserOptions.
 *
 * Whether to allow multiple file selection.
 *
 * Nullable because it does not apply to the "save" action.
 *
 * Returns: the field value.
 */
gboolean* ffs_platform_file_chooser_options_get_select_multiple(
    FfsPlatformFileChooserOptions* object);

G_DECLARE_FINAL_TYPE(FfsFileSelectorApiShowFileChooserResponse,
                     ffs_file_selector_api_show_file_chooser_response, FFS,
                     FILE_SELECTOR_API_SHOW_FILE_CHOOSER_RESPONSE, GObject)

/**
 * ffs_file_selector_api_show_file_chooser_response_new:
 *
 * Creates a new response to FileSelectorApi.showFileChooser.
 *
 * Returns: a new #FfsFileSelectorApiShowFileChooserResponse
 */
FfsFileSelectorApiShowFileChooserResponse*
ffs_file_selector_api_show_file_chooser_response_new(FlValue* return_value);

/**
 * ffs_file_selector_api_show_file_chooser_response_new_error:
 * @code: error code.
 * @message: error message.
 * @details: (allow-none): error details or %NULL.
 *
 * Creates a new error response to FileSelectorApi.showFileChooser.
 *
 * Returns: a new #FfsFileSelectorApiShowFileChooserResponse
 */
FfsFileSelectorApiShowFileChooserResponse*
ffs_file_selector_api_show_file_chooser_response_new_error(const gchar* code,
                                                           const gchar* message,
                                                           FlValue* details);

/**
 * FfsFileSelectorApiVTable:
 *
 * Table of functions exposed by FileSelectorApi to be implemented by the API
 * provider.
 */
typedef struct {
  FfsFileSelectorApiShowFileChooserResponse* (*show_file_chooser)(
      FfsPlatformFileChooserActionType type,
      FfsPlatformFileChooserOptions* options, gpointer user_data);
} FfsFileSelectorApiVTable;

/**
 * ffs_file_selector_api_set_method_handlers:
 *
 * @messenger: an #FlBinaryMessenger.
 * @suffix: (allow-none): a suffix to add to the API or %NULL for none.
 * @vtable: implementations of the methods in this API.
 * @user_data: (closure): user data to pass to the functions in @vtable.
 * @user_data_free_func: (allow-none): a function which gets called to free
 * @user_data, or %NULL.
 *
 * Connects the method handlers in the FileSelectorApi API.
 */
void ffs_file_selector_api_set_method_handlers(
    FlBinaryMessenger* messenger, const gchar* suffix,
    const FfsFileSelectorApiVTable* vtable, gpointer user_data,
    GDestroyNotify user_data_free_func);

/**
 * ffs_file_selector_api_clear_method_handlers:
 *
 * @messenger: an #FlBinaryMessenger.
 * @suffix: (allow-none): a suffix to add to the API or %NULL for none.
 *
 * Clears the method handlers in the FileSelectorApi API.
 */
void ffs_file_selector_api_clear_method_handlers(FlBinaryMessenger* messenger,
                                                 const gchar* suffix);

G_END_DECLS

#endif  // PIGEON_MESSAGES_G_H_
