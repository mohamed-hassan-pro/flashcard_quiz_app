# 🧠 Flashcard Quiz App

A modern, scalable, and responsive Flashcard application built with Flutter. This project demonstrates high-quality software engineering principles, serving as Task 1 for the **CodeAlpha Internship**.

## ✨ Features
- **Flashcard Management:** Add, edit, and delete custom flashcards.
- **Interactive Quiz Mode:** Tap to flip cards and reveal the answers with smooth micro-animations.
- **Local Persistence:** Data is securely stored locally using SQLite.
- **Modern UI/UX:** Responsive design, beautiful color palettes, and glassmorphism elements.

## 🏗️ Architecture & Engineering Standards
This project strictly adheres to **Clean Architecture** and **SOLID Principles**:
- **Presentation Layer:** Contains UI components and Bloc/Cubit for state management. Widgets are modularized (under 100 lines) following the Single Responsibility Principle.
- **Domain Layer:** Business logic, Entities (Flashcard), and abstract Repository interfaces.
- **Data Layer:** Local Data Source (sqflite), Data Models, and Repository implementations.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.44.0 or latest)
- Dart SDK

### Installation
1. Clone the repository:
   `ash
   git clone https://github.com/mohamed-hassan-pro/flashcard_quiz_app.git
   `
2. Navigate to the project directory:
   `ash
   cd flashcard_quiz_app
   `
3. Install dependencies:
   `ash
   flutter pub get
   `
4. Run the app:
   `ash
   flutter run
   `

## 📸 Media & Screenshots
*(Add screenshots or GIFs of the app here)*

---
*Built with passion by [mohamed-hassan-pro] during the CodeAlpha Internship.*
