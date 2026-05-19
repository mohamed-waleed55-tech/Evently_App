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

## 📱 Application Demo & Screenshots

Here is a full visual walkthrough of the platform's core features, user interface components, and dynamic event management workflows.

<div align="center">
  <img src="https://github.com/user-attachments/assets/e65a5063-a46a-43b5-93d3-b0892365bffa" alt="Splash Screen" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/01c27aa6-73fc-472b-987f-2017b576dc90" alt="Login Screen" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/75d6556d-9320-4b53-95a5-abdba459ef8c" alt="Register Screen" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/a08c1790-4c4b-4292-9bd1-607f1d507345" alt="Forget Password" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/c5ab4da0-dcd1-4be3-ac45-d862ce693aa9" alt="Home Dashboard" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
</div>

<br>

<div align="center">
  <img src="https://github.com/user-attachments/assets/3f5f8dfb-c8c6-4c11-93b9-707d9fb87048" alt="Map Feature Filtering" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/6a4e5615-f215-41a9-8337-16f0ed1c6e18" alt="Map View" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/a63444d1-e35a-4d60-a201-0fec1abdd469" alt="Favorites Screen" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/e214a070-4556-4d08-a95b-997e46c59d68" alt="Profile Layout" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
  <img src="https://github.com/user-attachments/assets/1d461fe5-47af-448c-bc78-c575e5659cd7" alt="Profile Settings Light" width="18%" style="margin: 0.5%; border-radius: 12px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);" />
</div>

---

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

---

## 📂 Project Structure

```text
lib/
│
├── core/                  # Shared configurations, network logic, base themes, and localization
│   ├── theme/             # Light & Dark configuration nodes
│   ├── utils/             # Reusable helper extensions and validation logic
│   └── localization/      # Multi-lingual asset configurations
│
└── features/              # Feature-driven modular layout (Clean Architecture style)
    ├── auth/              # Authentication & Session Management
    ├── events/            # Core Event management, creation, and details
    ├── map/               # Google Maps integration & custom pinning logic
    └── profile/           # User configuration nodes & persistent settings
