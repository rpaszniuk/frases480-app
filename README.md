# Frases 480 - Flutter App
About Frases 480: is a project that aims to create a crowdsourced database of phrases.

Platform repository and extra information: https://github.com/rpaszniuk/frases480.git

## App Demo
* Web: https://app.frases480.com
* Android: https://play.google.com/store/apps/details?id=com.frases480
* iOS: Coming soon

### Main Requirements
* Flutter (with Dart) 1.12+ (https://flutter.dev/docs/get-started/install)

## Instructions

```
git clone https://github.com/rpaszniuk/frases480-app.git
flutter pub get
```

* Create secrets.json file, inside the app root directory:

```
{
  "api_secret": "",
  "base_url": ""
}
```
* Choose an editor: https://flutter.dev/docs/get-started/editor
* Run (https://flutter.dev/docs/get-started/test-drive)

## Optional

Create google-services.json file inside the android and iOS projects, to enable firebase (analytics, crashlytics and messaging)

## TODO

- ~Create web app~
- Sign Up
- Login
- Phrases CRUD
- Create iOS app and upload to the App Store 

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## License

This project is licensed under the terms of the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details
