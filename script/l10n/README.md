# l10n scripts
This directory contains scripts for generating Dart localizations. Currently it
is only used by `material_ui` and `cupertino_ui`.

The Widgets library generates its localizations in a similar fashion to these
scripts, located in flutter/flutter at 
[dev/tools/localization](https://github.com/flutter/flutter/tree/master/dev/tools/localization).

## gen_missing_localizations.dart

The gen_missing_localizations script is used to quickly add placeholder values
to all locale files when adding a new localization string. Add the new
localization string to the English .arb file and run this script, and all other
locale .arb files will be updated with the new string.

## gen_localizations.dart

The gen_localizations generates the Dart localization files, such as
generated_material_localizations.dart and generated_cupertino_localizations.dart
in material_ui and cupertino_ui, respectively. The script must be run by hand
after .arb files have been updated. The script optionally takes parameters

1. The path to this directory,
2. The file name prefix (the file name less the locale
   suffix) for the .arb files in this directory.

## encode_kn_arb_files.dart

The encode_kn_arb_files script is used to rewrite malformed unicode characters
from the Kannada translations due to a problem with that locale crashing Emacs.
There is more information at https://github.com/flutter/flutter/issues/36704.

## Localization Instructions

If you're looking for information about internationalizing Flutter
apps in general, see the
[Internationalizing Flutter Apps](https://flutter.dev/to/internationalization) tutorial.

### Translations for one locale: .arb files

The library uses
[Application Resource Bundle](https://github.com/google/app-resource-bundle/wiki/ApplicationResourceBundleSpecification)
files, which have a `.arb` extension, to store localized translations
of messages, format strings, and other values. This format is also
used by the Dart [intl](https://pub.dev/packages/intl) package.

The library only depends on a small subset of the ARB format. Each .arb
file contains a single JSON table that maps from resource IDs to localized
values.

Filenames contain the locale that the values have been translated
for. For example `<prefix>_de.arb` contains German translations, and
`<prefix>_ar.arb` contains Arabic translations. Files that contain
regional translations have names that include the locale's regional
suffix. For example `<prefix>_en_GB.arb` contains additional English
translations that are specific to Great Britain.

There is one language-specific .arb file for each supported locale. If
an additional file with a regional suffix is present, the regional
localizations are automatically merged with the language-specific ones.

The JSON table's keys, called resource IDs, are valid Dart variable names. They
correspond to methods from the Localizations class. For example:

```dart
Widget build(BuildContext context) {
  return TextButton(
    child: Text(
      MaterialLocalizations.of(context).cancelButtonLabel,
    ),
  );
}
```

This widget build method creates a button whose label is the local
translation of "CANCEL" which is defined for the `cancelButtonLabel`
resource ID.

Each of the language-specific .arb files contains an entry for
`cancelButtonLabel`.

### The _en.arb file defines all of the resource IDs

All of the `<prefix>_*.arb` files whose names do not include a regional
suffix contain translations for the same set of resource IDs as
`<prefix>_en.arb`.

For each resource ID defined for English, there is an additional resource
with an '@' prefix. These '@' resources are not used by the generated
Dart code at run time, they just exist to inform translators about how
the value will be used, and to inform the code generator about what code
to write.

```dart
"cancelButtonLabel": "CANCEL",
"@cancelButtonLabel": {
  "description": "The label for cancel buttons and menu items.",
  "type": "text"
},
```

### Values with Parameters, Plurals

A few translations contain `$variable` tokens. The
library replaces these tokens with values at
run-time. For example:

```dart
"aboutListTileTitle": "About $applicationName",
```

The value for this resource ID is retrieved with a parameterized
method instead of a simple getter:

```dart
MaterialLocalizations.of(context).aboutListTileTitle(yourAppTitle)
```

The names of the `$variable` tokens must match the names of the
method parameters.

Plurals are handled similarly, with a lookup method that includes a
quantity parameter. For example `selectedRowCountTitle` returns a
string like "1 item selected" or "no items selected".

```dart
MaterialLocalizations.of(context).selectedRowCountTitle(yourRowCount)
```

Plural translations can be provided for several quantities: 0, 1, 2,
"few", "many", "other". The variations are identified by a resource ID
suffix which must be one of "Zero", "One", "Two", "Few", "Many",
"Other". The "Other" variation is used when none of the other
quantities apply. All plural resources must include a resource with
the "Other" suffix. For example the English translations
('<prefix>_en.arb') for `selectedRowCountTitle` are:

```dart
"selectedRowCountTitleZero": "No items selected",
"selectedRowCountTitleOne": "1 item selected",
"selectedRowCountTitleOther": "$selectedRowCount items selected",
```

When defining new resources that handle pluralizations, the "One" and
the "Other" forms must, at minimum, always be defined in the source
English ARB files.

### Adding a new string to localizations

If you (someone contributing to the package) want to add a new string to the
Localizations object (e.g. because
you've added a new widget and it has a tooltip), follow these steps:

1. #### For messages without parameters, add new getter
   ```dart
   String get showMenuTooltip;
   ```
   to the localizations class `MaterialLocalizations` (or `CupertinoLocalizations`),
   in `packages/material_ui/lib/src/material_localizations.dart`;

   #### For messages with parameters, add new function
   ```dart
   String aboutListTileTitle(String applicationName);
   ```
   to the same localization class.

2. Implement a default return value in `DefaultMaterialLocalizations` (or `DefaultCupertinoLocalizations`) in
   the same file as in step 1.

   #### Messages without parameters:
   ```dart
   @override
   String get showMenuTooltip => 'Show menu';
   ```
   #### Messages with parameters:
   ```dart
   @override
   String aboutListTileTitle(String applicationName) => 'About $applicationName';
   ```
   For messages with parameters, do also add the function to `GlobalMaterialLocalizations` (or `GlobalCupertinoLocalizations`) in `packages/material_ui/lib/src/global_material_localizations.dart`, and add a raw getter as demonstrated below:

   ```dart
   /// The raw version of [aboutListTileTitle], with `$applicationName` verbatim
   /// in the string.
   @protected
   String get aboutListTileTitleRaw;

   @override
   String aboutListTileTitle(String applicationName) {
     final String text = aboutListTileTitleRaw;
     return text.replaceFirst(r'$applicationName', applicationName);
   }
   ```

3. Add a test to `test/localizations_test.dart` that verifies that
   this new value is implemented.

4. Update the .arb files. To add a new string to the .arb files, you must first
   add it to the English translations (`lib/src/l10n/<prefix>_en.arb`),
   including a description.

   #### Messages without parameters:
   ```dart
   "showMenuTooltip": "Show menu",
   "@showMenuTooltip": {
     "description": "The tooltip for the button that shows a popup menu."
   },
   ```

   #### Messages with parameters:
   ```dart
   "aboutListTileTitle": "About $applicationName",
   "@aboutListTileTitle": {
     "description": "The default title for the drawer item that shows an about page for the application. The value of $applicationName is the name of the application, like GMail or Chrome.",
     "parameters": "applicationName"
   },
   ```

   Then you need to add new entries for the string to all of the other
   language locale files by running the following from the repo root:
   ```bash
   dart script/l10n/bin/gen_missing_localizations.dart
   ```
   Which will copy the English strings into the other locales as placeholders
   until they can be translated.

   Finally you need to re-generate
   `lib/src/l10n/generated_<prefix>_localizations.dart` by running the following
   from the repo root:
   ```bash
   dart script/l10n/bin/gen_localizations.dart --overwrite
   ```

   If you got an error when running this command, [this issue](https://github.com/flutter/flutter/issues/104601) might be helpful.

   TL;DR: If you got the same type of errors as discussed in the issue, run this
   instead from the repo root:
   ```bash
   dart script/l10n/bin/gen_localizations.dart --overwrite --remove-undefined
   ```

5. If you are a Google employee, you should then also follow the instructions
   at `go/flutter-l10n`. If you're not, don't worry about it.

### Updating an existing string

If you or someone contributing to the Flutter framework wants to modify an
existing string in the Localizations objects, follow these steps:

1. Modify the default value of the relevant getter(s) in
   `DefaultMaterialLocalizations` (or `DefaultCupertinoLocalizations`) below.

2. Update the .arb files. Modify the out-of-date English strings in
   `lib/src/l10n/<prefix>_en.arb`.

   You also need to re-generate
   `lib/src/l10n/generated_<prefix>_localizations.dart` by running the following
   from the repo root:
   ```bash
   dart script/l10n/bin/gen_localizations.dart --overwrite
   ```

   This script may result in your updated getters being created in newer
   locales and set to the old value of the strings. This is to be expected.
   Leave them as they were generated, and they will be picked up for
   translation.

3. If you are a Google employee, you should then also follow the instructions
   at `go/flutter-l10n`. If you're not, don't worry about it.

### 'generated\_\*\_localizations.dart': all of the localizations

All of the localizations are combined in a single file per library
using the gen_localizations script.

You can see what that script would generate by running the following from the
repo root:

```bash
dart script/l10n/bin/gen_localizations.dart
```

Actually update the generated files with the following run from the repo root:

```bash
dart script/l10n/bin/gen_localizations.dart --overwrite
```

The gen_localizations script just combines the contents of all of the
.arb files, each into a class which extends `Global<Prefix>Localizations`.
The Localizations class implementation uses these to lookup localized
resource values.

The gen_localizations script must be run by hand after .arb files have
been updated. The script optionally takes parameters

1. The path to this directory,
2. The file name prefix (the file name less the locale
   suffix) for the .arb files in this directory.

### Special handling for the Kannada (kn) translations

Originally, the `<prefix>_kn.arb` file contained unicode characters that can cause
current versions of Emacs on Linux to crash. There is more information here:
https://github.com/flutter/flutter/issues/36704.

Rather than risking developers' editor sessions, the strings in these arb files
(and the code generated for them) have been encoded using the appropriate
escapes for JSON and Dart. The JSON format arb files were rewritten with
script/l10n/bin/encode_kn_arb_files.dart. The localizations code
generator uses generateEncodedString()
from script/l10n/lib/localizations_utils.dart.

### Translations Status, Reporting Errors

The translations (the `.arb` files) are based on the English
translations in `<prefix>_en.arb`. Google contributes translations for all the
languages supported by this package. (Googlers, for more details see
<go/flutter-l10n>.)

If you have feedback about the translations please
[file an issue on the Flutter github repo](https://github.com/flutter/flutter/issues/new?template=02_bug.yml).

### See Also

The [Internationalizing Flutter Apps](https://flutter.dev/to/internationalization)
tutorial describes how to use the internationalization APIs in an
ordinary Flutter app.

[Application Resource Bundle](https://code.google.com/p/arb/wiki/ApplicationResourceBundleSpecification)
covers the `.arb` file format used to store localized translations
of messages, format strings, and other values.

The Dart [intl](https://pub.dev/packages/intl)
package supports internationalization.
