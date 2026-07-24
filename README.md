# 📌 Eventra -- Real-Time Event Management Platform

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/Architecture-MVVM%20%2B%20BLoC-success?style=for-the-badge" alt="Architecture" />
  <img src="https://img.shields.io/badge/Build-passing-brightgreen?style=for-the-badge&logo=github" alt="Build Status" />
</p>

<p align="center">
  <img
    src="https://github.com/user-attachments/assets/43326722-d566-4a7a-ab68-4767af36ed81"
    alt="Eventra Official Poster"
    width="65%"
  />
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=120&section=header&text=Welcome%20To%20Eventra&fontSize=30&animation=fadeIn" alt="Header Animation" />
</p>

---

## 🎥 App Demo

Here is a full visual walkthrough of the platform's core features, user interface components, and dynamic event management workflows.

[![Watch Eventra Demo](poster.png)](https://github.com/user-attachments/assets/86bdca2b-08ac-40d0-a9d6-84d74a99cfd9)

---

## 📐 System Design & Blueprint

An architectural breakdown of the data stream, remote API interfaces, state distribution loops, and system components. This blueprint illustrates the single-directional data flow and component decoupling within the platform.

<p align="center">
  <img src="https://github.com/user-attachments/assets/390c61a6-fc7b-4557-b484-41f4453f1398" alt="Eventra App Modern System Design Diagram" width="55%" />
</p>

### 🎯 Architectural Layout & Design Patterns

- **Presentation Layer (UI):** Built using highly responsive, modular widgets completely isolated from business or network logic.
- **State Management (BLoC/Cubit):** Utilizes predictable reactive state loops ensuring predictable view mutations and thread-safe async data tracking.
- **Data Layer (Infrastructure):** Abstracted data interfaces and schemas separating remote service clients (Firebase API nodes) from the presentation consumption layer.

---

## 🚀 Key Features

- 🔄 **Real-Time Synchronization:** Seamless, live event data syncing across clients powered by Firebase Firestore.
- 📍 **Advanced Location Services:** Google Maps integration with geolocation, event locations, and category filtering.
- ⚙️ **Dynamic Configuration Engine:** Supports Light/Dark themes and bilingual localization (Arabic & English).
- 🔐 **Secure Authentication:** Firebase Authentication with Sign Up, Login, and Forgot Password flows.

---

## 🛠️ Tech Stack & Dependencies

- **Framework:** Flutter & Dart
- **Architecture:** MVVM + BLoC/Cubit
- **Backend:** Firebase Authentication, Cloud Firestore, Cloud Storage
- **Maps & Location:** Google Maps, Geolocator, Geocoding
- **UI:** Responsive Design, ScreenUtil, Localization, Theming, Native Splash
