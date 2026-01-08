class Station {
  final int id;
  final String name;
  final String city;

  Station({
    required this.id,
    required this.name,
    required this.city,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] as int,
      name: json['name'] as String,
      city: json['city'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'city': city,
    };
  }
}

class Train {
  final int id;
  final String number;
  final String type;

  Train({
    required this.id,
    required this.number,
    required this.type,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      id: json['id'] as int,
      number: json['number'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'type': type,
    };
  }
}

class Carriage {
  final int id;
  final int trainId;
  final int number;
  final String type;

  Carriage({
    required this.id,
    required this.trainId,
    required this.number,
    required this.type,
  });

  factory Carriage.fromJson(Map<String, dynamic> json) {
    return Carriage(
      id: json['id'] as int,
      trainId: json['trainId'] as int,
      number: json['number'] as int,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'trainId': trainId,
      'number': number,
      'type': type,
    };
  }
}

class Seat {
  final int id;
  final int carriageId;
  final int number;
  final bool isAvailable;

  Seat({
    required this.id,
    required this.carriageId,
    required this.number,
    required this.isAvailable,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      id: json['id'] as int,
      carriageId: json['carriageId'] as int,
      number: json['number'] as int,
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'carriageId': carriageId,
      'number': number,
      'isAvailable': isAvailable,
    };
  }
}

class Route {
  final int id;
  final String name;
  final int trainId;
  final Train? train;
  final Station departureStation;
  final Station arrivalStation;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final double price;
  final int availableSeats;

  Route({
    required this.id,
    required this.name,
    required this.trainId,
    this.train,
    required this.departureStation,
    required this.arrivalStation,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.availableSeats,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'] as int,
      name: json['name'] as String,
      trainId: json['trainId'] as int,
      train: json['train'] != null ? Train.fromJson(json['train']) : null,
      departureStation: Station.fromJson(json['departureStation']),
      arrivalStation: Station.fromJson(json['arrivalStation']),
      departureTime: json['departureTime'] as String,
      arrivalTime: json['arrivalTime'] as String,
      duration: json['duration'] as String,
      price: (json['price'] as num).toDouble(),
      availableSeats: json['availableSeats'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'trainId': trainId,
      'train': train?.toJson(),
      'departureStation': departureStation.toJson(),
      'arrivalStation': arrivalStation.toJson(),
      'departureTime': departureTime,
      'arrivalTime': arrivalTime,
      'duration': duration,
      'price': price,
      'availableSeats': availableSeats,
    };
  }
}

class RouteSearchParams {
  final String fromCity;
  final String toCity;
  final String date;

  RouteSearchParams({
    required this.fromCity,
    required this.toCity,
    required this.date,
  });
}

class SelectedSeat {
  final int routeId;
  final int seatId;
  final int carriageId;
  final int carriageNumber;
  final int seatNumber;
  final double price;

  SelectedSeat({
    required this.routeId,
    required this.seatId,
    required this.carriageId,
    required this.carriageNumber,
    required this.seatNumber,
    required this.price,
  });
}

class PassengerInfo {
  final String firstName;
  final String lastName;
  final String passportData;

  PassengerInfo({
    required this.firstName,
    required this.lastName,
    required this.passportData,
  });
}

class Order {
  final int id;
  final Route route;
  final SelectedSeat seat;
  final PassengerInfo passenger;
  final String status; // 'PENDING' | 'PAID' | 'CANCELLED'
  final String createdAt;
  final double totalAmount;

  Order({
    required this.id,
    required this.route,
    required this.seat,
    required this.passenger,
    required this.status,
    required this.createdAt,
    required this.totalAmount,
  });
}

class BookingState {
  final RouteSearchParams? searchParams;
  final Route? selectedRoute;
  final SelectedSeat? selectedSeat;
  final PassengerInfo? passengerInfo;

  BookingState({
    this.searchParams,
    this.selectedRoute,
    this.selectedSeat,
    this.passengerInfo,
  });

  BookingState copyWith({
    RouteSearchParams? searchParams,
    Route? selectedRoute,
    SelectedSeat? selectedSeat,
    PassengerInfo? passengerInfo,
  }) {
    return BookingState(
      searchParams: searchParams ?? this.searchParams,
      selectedRoute: selectedRoute ?? this.selectedRoute,
      selectedSeat: selectedSeat ?? this.selectedSeat,
      passengerInfo: passengerInfo ?? this.passengerInfo,
    );
  }
}
