<h1 align="center">Tractian Mobile Challenge</h1>

## :iphone: Challenge

  This app is part of the Tractian Mobile Challenge. The main objectives consist of:
  * List the companies assets and locations in a hierarchical tree.
  * Allow the user to filter the tree by name, component status and sensor.

## :hammer: Architecture and Structure

The app was created with Clean Arch and SOLID concepts in mind, following a **feature-first** project structure (layers inside features).

This architecture comprises four layers:
* data
* domain
* application
* presentation.

## :gear: State Management

State management is done by using the [Mobx](https://pub.dev/packages/mobx) package together with [Flutter MobX](https://pub.dev/packages/flutter_mobx).

## 💉 Dependency Injection

Dependency injection is done by using the [GetIt](https://pub.dev/packages/get_it) package.

## 💻 How to Run and Info:

```bash
# Clone repository
$ git clone [https://github.com/LeonardoMaito/tractian-treeview.git](https://github.com/LeonardoMaito/tractian-treeview.git)

# Install the dependencies
$ flutter pub get

# Run build_runner
$ flutter pub run build_runner build

#Run the project
$ flutter run
```
## ℹ️Additional Info:
Flutter: 3.22.2 • channel stable

Tools • Dart 3.4.3 • DevTools 2.34.3


