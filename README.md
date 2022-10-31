# Very Good Coffee

A random Coffee images app built with [Flutter][flutter_link] for [VeryGoodVentures][vgv_link]

## Getting Started 🚀

To run the desired project either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
$ flutter run
```
or
```sh
$ flutter -d your_device_id run
```

_\*Very Good Coffee works on iOS and Android devices._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov][lcov_link].

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/
# Open Coverage Report
$ open coverage/index.html
```
**NOTE:** To run all unit and widget tests of a package, use the same command from inside that package or use the Test Explorer of Visual Studio Code to run all test at once

---

## Localization (abbr. as L10N) 🌐

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
    "sampleKey": "Very Good Coffee",
    "@sampleKey": {
        "description": "The title of the application"
    }
}
```
```
-- app_es.arb --
{
    "sampleKey": "Un muy buen café",
    "@sampleKey": {
        "description": "El título de la aplicación"
    }
}
```

Each additional locale must be added to the `supportedLocales` property when configuring the top level `MaterialApp`.

#### Retrieving localized strings in code

To retrieve strings in code, we need to import the generated `AppLocalizations` class for compiler-safe references.

```
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
```

Then, given a `BuildContext context`, localized string values are retrieved in one line using the string key you specified in `app_en.arb` and any other language file:

```
final localizedString = AppLocalizations.of(context).stringKey
```

## Development Tools :checkered_flag:

- Flutter 3.3.3
- Editor: [VS Code][visual_studio_link]
- Editor Extensions:
  - [Flutter][flutter_extension_link]
  - [Dart][dart_extension_link]
- Format Rules:
  - Editor: Detect Indentation: true
  - Editor: Format On Save: true
  - Dart: Line Length: 80

## App Architecture :house:

### BLoC Pattern

The primary UI state management pattern employed within this application is the [BLoC Pattern][why_bloc_link].

### Project Structure

The project is structured by grouping files around specific features.

[flutter_link]: https://flutter.dev
[vgv_link]: https://verygood.ventures/
[lcov_link]: https://github.com/linux-test-project/lcov
[visual_studio_link]: https://code.visualstudio.com/
[flutter_extension_link]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter
[dart_extension_link]: https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code
[why_bloc_link]: https://bloclibrary.dev/#/whybloc

</br>
</br>

*Built by Pablo Tortosa* :shipit:
