![Dart CI](https://github.com/RohanKapurDEV/paymint/workflows/Dart%20CI/badge.svg?event=check_suite)

# Paymint
NOTE: Paymint is currently in VERY EARLY alpha stage. Expected release is in q2-q3 2020.

Paymint is a Bitcoin thin client written in Dart. Out of the box, it aims to be an HD wallet with support for Native Segwit addresses, full UTXO selection controls and payment batching.

## Build and run
- Flutter SDK Requirement (>=2.2.0, up until <3.0.0)
- Android/iOS dev setup (Android Studio, xCode and subsequent dependencies)
- Navigate into project root and run the following:
```
flutter doctor
flutter pub get
flutter run --release
```

## Features
- HD Native Segwit Addresses (BIP 84, 173)
- Advanced UTXO selection/filtering
- Payment Batching
- Cloud wallet backups

## Screenshots
<img src="https://imgur.com/ib2IPoP.jpg" width="200" align="left"> <img src="https://imgur.com/hJQmhkw.jpg" width="200">
