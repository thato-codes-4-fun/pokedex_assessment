# Pokedex Assessment

A Flutter-based Pokedex application that allows users to browse Pokemon, view detailed information, search through all Pokemon, and manage favorites locally.

## 📱 Features

- **Pokemon List**: Browse through Pokemon with infinite scroll pagination
- **Search**: Real-time search across all ~1000 Pokemon from PokeAPI
- **Details View**: View comprehensive Pokemon information including:
  - Types with color-coded badges
  - Base stats with visual progress bars
  - Height and weight information
  - Abilities
  - High-quality sprites
- **Favorites**: Save favorite Pokemon locally with persistent storage
- **Authentication**: Firebase Authentication integration
- **Theme Support**: Light and dark mode with persistent preferences
- **Offline Favorites**: View saved favorites without internet connection

## 🛠️ Tech Stack

### Core

- **Flutter 3.9.2** - Cross-platform mobile framework
- **Dart** - Programming language

### State Management

- **Provider 6.1.5** - Reactive state management following MVVM pattern

### Backend & API

- **Firebase Core 4.2.0** - Firebase integration
- **Firebase Auth 6.1.1** - User authentication
- **PokeAPI** - RESTful Pokemon data (https://pokeapi.co)
- **HTTP 1.5.0** - API requests

### Local Storage

- **Hive 2.2.3 & Hive Flutter 1.1.0** - Fast, lightweight NoSQL database for:
  - Theme preferences
  - Favorite Pokemon IDs
- **Shared Preferences 2.5.3** - Additional local storage

### UI & Assets

- **Cached Network Image 3.4.1** - Efficient image loading and caching
- **Material Design 3** - Modern UI components

## 🏗️ Architecture

### MVVM (Model-View-ViewModel) Pattern

The application follows a clean MVVM architecture for separation of concerns:

```
lib/
├── models/              # Data models
│   ├── pokemon.dart
│   ├── pokemon_details.dart
│   └── pokemonResponse.dart
├── views/               # UI layer
│   ├── auth/            # Login & registration screens
│   ├── home/            # Main navigation
│   ├── pokemon/         # Pokemon list
│   ├── pokemon_details/ # Detail view
│   ├── favorites/       # Favorites list
│   ├── profile/         # User profile
│   └── widgets/         # Reusable components
├── viewmodels/          # Business logic & state
│   ├── auth_viewmodel.dart
│   ├── pokemon_viewmodel.dart
│   ├── favourite_viewmodel.dart
│   └── theme_viewmodel.dart
├── services/            # Data layer
│   ├── api/             # API calls
│   └── local/           # Local storage
└── core/                # App-wide utilities
    ├── routes/          # Navigation
    ├── theme/           # Theme configuration
    └── constants/       # App constants
```

### Key Architectural Decisions

#### 1. **MVVM Over BLoC**

- Chose Provider + MVVM for simplicity and readability
- ViewModels extend `ChangeNotifier` for reactive UI updates
- Clear separation between business logic and presentation

#### 2. **Caching Strategy**

- **Two-tier caching**:
  - Memory cache in ViewModels for Pokemon details
  - Disk cache (Hive) for favorites and preferences
- **Smart loading**:
  - Only loads Pokemon details on demand
  - Infinite scroll fetches 20 Pokemon at a time
  - Search loads all Pokemon names once, then filters locally

#### 3. **State Management**

- **Global state**: Authentication, Pokemon list, favorites
- **Local state**: Search queries, scroll positions, form inputs
- **MultiProvider** at app root for dependency injection

#### 4. **API Integration**

- RESTful approach with PokeAPI v2
- Error handling with try-catch blocks
- HTTP status code validation
- Graceful fallbacks for missing data

#### 5. **Data Flow**

```
User Action → View → ViewModel → Service → API/Storage
                ↑                    ↓
                └────── notifyListeners() ──────┘
```

#### 6. **Authentication Flow**

- `AuthWrapper` widget guards routes
- Firebase Auth for user management
- Persistent session across app restarts
- Automatic navigation based on auth state

#### 7. **Local Storage Design**

- **Hive** for structured data (favorites, theme)
- Type-safe with explicit conversions (`List<int>.from()`)
- Async operations with proper error handling
- Separate boxes for different concerns

## 🚀 Setup Instructions

### Prerequisites

- Flutter SDK 3.9.2 or higher
- Dart SDK
- Android Studio / Xcode (for emulators)
- Firebase project (for authentication)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd pokedex_assessment
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   - Create a Firebase project at https://console.firebase.google.com
   - Enable Email/Password authentication
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place in respective platform folders:
     - Android: `android/app/google-services.json`
     - iOS: `ios/Runner/GoogleService-Info.plist`
   - Run Flutter Firebase configuration:
     ```bash
     flutterfire configure
     ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Build for Production

**Android:**

```bash
flutter build apk --release
```

**iOS:**

```bash
flutter build ios --release
```

## 📂 Project Structure Details

### Models

- **Pokemon**: Lightweight model for list items (name, url, id)
- **PokemonDetails**: Comprehensive model with stats, types, abilities
- **PokemonResponse**: Pagination wrapper from PokeAPI

### ViewModels

- **PokemonViewModel**: Manages Pokemon list, pagination, search, details cache
- **FavouriteViewModel**: Handles favorite Pokemon state and persistence
- **AuthViewModel**: User authentication state and operations
- **ThemeViewModel**: Theme preferences (light/dark mode)

### Services

- **PokemonService**: API calls to PokeAPI with error handling
- **FavoriteService**: Hive-based local storage for favorites

### Views

- **Material Design 3** components
- Responsive layouts with SafeArea
- Custom widgets for reusability
- Consumer widgets for reactive updates

## 🎨 UI/UX Features

- **Type-based color coding**: Each Pokemon type has a unique color
- **Gradient backgrounds**: Dynamic colors based on primary type
- **Smooth animations**: Hero transitions, loading indicators
- **Pull-to-refresh**: Update favorites list
- **Infinite scroll**: Seamless Pokemon browsing
- **Search with results count**: Clear feedback on search
- **Empty states**: Helpful messages when no data
- **Error handling**: User-friendly error messages

## 🔒 Security Considerations

- Firebase Authentication for secure user management
- No sensitive data in version control
- API keys managed through Firebase configuration
- Local data encrypted by Hive

## 🧪 Testing Approach

The application is structured for easy testing:

- Separation of concerns (MVVM)
- Service layer abstraction
- Mockable dependencies via Provider
- Pure functions in models

## 🤝 Contributing

This is an assessment project. For educational purposes only.

## 📄 License

This project is created for assessment purposes.

## 🙏 Acknowledgments

- [PokeAPI](https://pokeapi.co) for the comprehensive Pokemon database
- [Flutter](https://flutter.dev) for the amazing framework
- [Firebase](https://firebase.google.com) for authentication services
