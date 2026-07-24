# 📌 Evently -- Real-Time Event Management Platform

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase" />
  <img src="https://img.shields.io/badge/Architecture-MVVM%20%2B%20BLoC-success?style=for-the-badge" alt="Architecture" />
  <img src="https://img.shields.io/badge/Build-passing-brightgreen?style=for-the-badge&logo=github" alt="Build Status" />
</p>

<p align="center">
  <img src="https://github.com/user-attachments/assets/bc70ebb9-f5c9-4d91-b6f4-1283e23521f0" alt="Evently App Official Poster" width="65%" style="border-radius: 14px; box-shadow: 0 10px 20px rgba(0,0,0,0.3); transition: transform 0.3s;" />
</p>

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=auto&height=120&section=header&text=Welcome%20To%20Evently&fontSize=30&animation=fadeIn" alt="Header Animation" />
</p>

---

## 🎥 App Demo

Here is a full visual walkthrough of the platform's core features, user interface components, and dynamic event management workflows.

[![Watch Eventra Demo](poster.png)](https://github.com/user-attachments/assets/86bdca2b-08ac-40d0-a9d6-84d74a99cfd9)
## 📐 System Design & Blueprint

An architectural breakdown of the data stream, remote API interfaces, state distribution loops, and system components. This blueprint illustrates the single-directional data flow and component decoupling within the platform.

<p align="center">
  <img src="https://github.com/user-attachments/assets/390c61a6-fc7b-4557-b484-41f4453f1398" alt="Evently App Modern System Design Diagram" width="55%" style="border-radius: 14px; box-shadow: 0 8px 16px rgba(0,0,0,0.25);" />
</p>

### 🎯 Architectural Layout & Design Patterns

* **Presentation Layer (UI):** Built using highly responsive, modular widgets completely isolated from business or network logic.
* **State Management (BLoC/Cubit):** Utilizes predictable reactive state loops ensuring predictable view mutations and thread-safe async data tracking.
* **Data Layer (Infrastructure):** Abstracted data interfaces and schemas separating remote service clients (Firebase API nodes) from the presentation consumption layer.

---

## 🚀 Key Features

* **🔄 Real-Time Synchronization:** Seamless, live event data syncing across clients powered by persistent Firebase Firestore backend schemas.
* **📍 Advanced Location Services:** Deep integration with Google Maps SDK featuring customized map geolocation pins, runtime distance calculations, and category filtering matrices.
* **⚙️ Dynamic Configuration Engine:** Persistent localized state configurations supporting runtime light/dark mode transitions and complete multi-lingual user interfaces (Arabic / English).
* **🔐 Robust Authentication:** Secure user identity structures and session stability managed through Firebase Authentication guards (with Forget Password flows).

---

## 🛠️ Tech Stack & Dependencies

* **Framework:** Flutter & Dart (Type-Safe OOP)
* **State Management:** BLoC / Cubit & Hydrated BLoC (For localized persistence)
* **Backend Ecosystem:** Firebase Authentication, Cloud Firestore, Cloud Storage
* **Location APIs:** Google Maps SDK, Geolocation & Geocoding Packages
* **UI & Core Utils:** Responsive design layout structures, Native Splash, Theming Extensions, Multi-lingual Localization Nodes




