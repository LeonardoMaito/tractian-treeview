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

## 💻 How to Run and Info

```bash
# Clone repository
$ git clone https://github.com/LeonardoMaito/tractian-treeview.git

# Install the dependencies
$ flutter pub get

# Run build_runner
$ flutter pub run build_runner build

#Run the project
$ flutter run
```
## ℹ️ Additional Info
Flutter: 3.22.2 • channel stable

Tools • Dart 3.4.3 • DevTools 2.34.3

## 📷 Screenshots

<img src="https://github.com/user-attachments/assets/3d676a49-7d0b-42d9-aa7a-910a2540d434" alt="Tractian1" width="300"/>
<img src="https://github.com/user-attachments/assets/96d4fdda-0b54-4be6-b6fd-f177b4682a82" alt="Tractian2" width="300"/>
<img src="https://github.com/user-attachments/assets/f0264622-ff1c-4197-90ab-3f14c0da01df" alt="Tractian3" width="300"/>
<img src="https://github.com/user-attachments/assets/160a5479-0afe-4e25-bb18-1e7398d957f0" alt="Tractian4" width="300"/>
<img src="https://github.com/user-attachments/assets/7d12602e-37f5-4474-9e94-7477810c4a27" alt="Tractian5" width="300"/>
<img src="https://github.com/user-attachments/assets/b3223bc4-cdc3-4be3-a339-051d327da0b4" alt="Tractian6" width="300"/>
