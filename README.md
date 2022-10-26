# very_good_coffee

A new Flutter project.

## Development Tools

- Flutter 3.3.3
- Editor: [VS Code](https://code.visualstudio.com/)
- Editor Extensions:
  - [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
  - [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- Format Rules:
  - Editor: Detect Indentation: true
  - Editor: Format On Save: true
  - Dart: Line Length: 80

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).


## Localization (abbr. as L10N)

This project is setup to translate all string content and adjust layouts to match expectations for a user's device locale.
This project generates localized messages based on arb files found in the `lib/l10n/arb` directory.

#### Adding new English strings to the project (Same for any other language as the Spanish (`app_es.arb`))

To add new strings to the project, add an entry to the `app_en.arb` file. Each entry requires:

- A _key-value_ pair -- the **key** should be a short camelCase name for the string, and the **value** is the string itself.
- A matching dictionary entry to provide some flavor text in the form of a description comment.

A complete entry in the English file for a new string looks like this:

```
-- app_en.arb --
{
    "sampleKey": "This is a string to show in the app",
    "@sampleKey": {
        "description": "This is an example description"
    }
}
```

**NOTE:** For tips on how best to capture strings with variations based on parameters or plurality,
visit the Intl documentation here:

https://docs.google.com/document/d/10e0saTfAv32OZLRmONy866vnaw0I2jwL8zukykpgWBc/edit#heading=h.yfh1gyd78g7g

#### Adding string translations to the project

To provide a given locale with translations, there needs to be a corresponding `app_<language-code>.arb` file.
These files should mimic the `app_en.arb` file, where the **keys** are exactly the same but populated with
**translated string values** (without the need for the `@` prefixed description entry).

Each additional locale must be added to the `supportedLocales` property when configuring the top level `MaterialApp`
(described in the "How it works" section below) for the translations to be accessible.

#### Retrieving localized strings in code

To retrieve strings in code, we need to import the generated `AppLocalizations` class for compiler-safe references.

```
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

Then, given a `BuildContext context`, localized string values are retrieved in one line using the string key you specified in `app_en.arb`:

```
final localizedString = AppLocalizations.of(context).stringKey
```

