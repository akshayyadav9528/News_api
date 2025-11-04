# Full-Stack News App (Node.js & Flutter)

This repository contains the code for a complete full-stack news application. It includes a **Node.js/Express REST API** for the backend and a **Flutter mobile application** for the frontend.

## ✨ Features

### 📦 Backend (Node.js)

* **REST API:** Provides endpoints for creating and fetching news articles.
* **Pagination & Filtering:** The main `/api/news` endpoint supports pagination (`page`, `limit`), category filtering, and keyword search.
* **Category Endpoint:** A dedicated `/api/categories` endpoint serves a (currently) hardcoded list of news categories.
* **Database:** Connects to MongoDB to store and retrieve news data.
* **CORS Enabled:** Configured with `cors` to allow cross-origin requests from the Flutter app.

### 📱 Frontend (Flutter)

* **State Management:** Uses the `Provider` package (`NewsProviders`) to manage application state (loading, news lists, categories).
* **Dynamic Home Screen:** The main screen fetches and displays a list of categories, the latest news, and a horizontal "Around The World" news list.
* **Category Filtering:** Users can tap a category to filter the news list.
* **Navigation:** Tapping a news card navigates to a detailed screen to read the full article.
* **Data Models:** Includes clear Dart models (`News`, `Category`) with `fromJson` factories to parse API responses.
* **UI Components:** Features a `NewsDetail` screen showing the article's image, title, source, content, and published date.

## 🛠️ Technology Stack

* **Backend:** Node.js, Express.js, MongoDB (with Mongoose), `dotenv`, `cors`
* **Frontend:** Flutter, Provider (state management), `http` (inferred)

---

## 🚀 Getting Started

To run this project, you will need to set up both the backend server and the frontend application.

### 1. Backend Setup

1.  **Navigate to the backend directory:**
    ```sh
    cd /path/to/your/backend-folder
    ```

2.  **Install dependencies:**
    ```sh
    npm install
    ```

3.  **Create an environment file:**
    Create a `.env` file in the root of your backend folder and add your configuration. (Based on your provided files):
    ```env
    # The port your server will run on
    PORT=4502

    # Your MongoDB connection string
    MONGO_URL=mongodb://localhost:27017/news
    ```

4.  **Run the server:**
    ```sh
    npm start
    ```
    The server should now be running at `http://localhost:4502`.

### 2. Frontend (Flutter) Setup

1.  **Navigate to the frontend directory:**
    ```sh
    cd /path/to/your/flutter-folder
    ```

2.  **Get packages:**
    ```sh
    flutter pub get
    ```

3.  **Update `main.dart`:**
    Your `main.dart` file currently contains a "Text Storage App". You will need to **replace its content** with the commented-out code block (also in the file) to run the News App:
    ```dart
    import 'package:flutter/material.dart';
    import 'package:news/providers/News_providers.dart';
    import 'package:news/screens/News_screen.dart';
    import 'package:provider/provider.dart';

    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MultiProvider(
          providers: [ChangeNotifierProvider(create: (_) => NewsProviders())],
          child: MaterialApp(home: News_Screen()),
        );
      }
    }
    ```

4.  **Update API URL:**
    You must find where your API calls are
