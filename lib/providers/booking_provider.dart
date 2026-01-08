import 'package:flutter/foundation.dart';
import '../models/models.dart';

class BookingProvider with ChangeNotifier {
  BookingState _state = BookingState();

  BookingState get state => _state;

  void setSearchParams(RouteSearchParams params) {
    _state = _state.copyWith(searchParams: params);
    notifyListeners();
  }

  void setSelectedRoute(Route? route) {
    _state = _state.copyWith(selectedRoute: route);
    notifyListeners();
  }

  void setSelectedSeat(SelectedSeat? seat) {
    _state = _state.copyWith(selectedSeat: seat);
    notifyListeners();
  }

  void setPassengerInfo(PassengerInfo? info) {
    _state = _state.copyWith(passengerInfo: info);
    notifyListeners();
  }

  void clearBooking() {
    _state = BookingState();
    notifyListeners();
  }
}
