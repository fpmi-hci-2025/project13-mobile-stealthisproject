# Railway Ticket System - Mobile Application

Flutter mobile application for the Railway Ticket System.

## Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart 3.x
- **State Management**: Provider
- **Routing**: go_router
- **HTTP Client**: http
- **Code Quality**: flutter_lints

## Features

- ✅ **Home/Search Screen**: Search form for routes with city selection
- ✅ **Search Results Screen**: List of available trains with mock data
- ✅ **Seat Selection Screen**: Visual representation of carriage/seats
- ✅ **Booking Screen**: Passenger details input form
- ✅ **Dashboard Screen**: List of orders/tickets with mock data
- ✅ **State Management**: Provider for booking flow
- ✅ **Responsive Design**: Mobile-optimized UI

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0 or higher
- Dart SDK 3.0.0 or higher
- Android Studio / Xcode (for mobile development)

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Run the app**
   ```bash
   flutter run
   ```

### Available Commands

- `flutter pub get` - Install dependencies
- `flutter run` - Run the app
- `flutter analyze` - Run static analysis
- `flutter test` - Run tests
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app

## Project Structure

```
lib/
├── main.dart                 # Entry point
├── models/                   # Data models
│   └── models.dart
├── providers/               # State management
│   ├── booking_provider.dart
│   ├── orders_provider.dart
│   └── auth_provider.dart
├── data/                    # Mock data
│   └── mock_data.dart
├── screens/                 # Screen widgets
│   ├── home_screen.dart
│   ├── search_results_screen.dart
│   ├── seat_selection_screen.dart
│   ├── booking_screen.dart
│   └── dashboard_screen.dart
├── widgets/                  # Reusable widgets
│   └── ...
├── config/                  # Configuration
│   └── api_config.dart
└── router/                  # Navigation
    └── app_router.dart
```

## Screens

### Home Screen (`/`)
- Search form for routes
- City selection dropdowns
- Date picker
- Popular destinations section

### Search Results (`/search-results`)
- List of available routes based on search criteria
- Route details (departure/arrival times, duration, price)
- Select route to proceed to seat selection

### Seat Selection (`/seat-selection`)
- Carriage selection
- Visual seat map
- Seat availability indicators
- Select seat to proceed to booking

### Booking Form (`/booking`)
- Passenger information form
- Order summary sidebar
- Submit to create order

### Dashboard (`/dashboard`)
- List of user's orders/tickets
- Order status indicators
- Order details and history

## State Management

The application uses Provider for state management:

- **BookingProvider**: Manages the booking flow state (search params, selected route, seat, passenger info)
- **OrdersProvider**: Manages user orders/tickets
- **AuthProvider**: Manages authentication state

## Mock Data

All data is currently mocked and stored in `lib/data/mock_data.dart`:
- Stations
- Trains
- Carriages
- Seats
- Routes
- Orders

## Routing

Routes are defined in `lib/router/app_router.dart`:
- `/` - Home screen
- `/search-results` - Search results
- `/seat-selection` - Seat selection
- `/booking` - Booking form
- `/dashboard` - User dashboard

## CI/CD

GitHub Actions workflow (`.github/workflows/ci.yml`) includes:
- Static analysis with `flutter analyze`
- Tests with `flutter test`
- Runs on push/PR to main/develop branches

## Development Notes

- All data is currently mocked (no API integration yet)
- The booking flow is fully functional with local state
- Orders are stored in Provider (not persisted)
- Mobile-optimized design

## Future Enhancements

- API integration with backend
- User authentication
- Payment processing
- Real-time seat availability
- Ticket QR code generation
- Push notifications
- Saved passenger profiles
