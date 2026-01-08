import '../models/models.dart';

final List<Station> mockStations = [
  Station(id: 1, name: 'Минск-Пассажирский', city: 'Минск'),
  Station(id: 2, name: 'Брест-Центральный', city: 'Брест'),
  Station(id: 3, name: 'Гомель', city: 'Гомель'),
  Station(id: 4, name: 'Витебск', city: 'Витебск'),
  Station(id: 5, name: 'Гродно', city: 'Гродно'),
  Station(id: 6, name: 'Могилев', city: 'Могилев'),
];

final List<Train> mockTrains = [
  Train(id: 1, number: '703Б', type: 'Скоростной'),
  Train(id: 2, number: '701Б', type: 'Скоростной'),
  Train(id: 3, number: '105Б', type: 'Региональный'),
  Train(id: 4, number: '107Б', type: 'Региональный'),
];

final List<Carriage> mockCarriages = [
  // Train 1 (703Б)
  Carriage(id: 1, trainId: 1, number: 1, type: 'Плацкарт'),
  Carriage(id: 2, trainId: 1, number: 2, type: 'Купе'),
  Carriage(id: 3, trainId: 1, number: 3, type: 'СВ'),
  // Train 2 (701Б)
  Carriage(id: 4, trainId: 2, number: 1, type: 'Плацкарт'),
  Carriage(id: 5, trainId: 2, number: 2, type: 'Купе'),
  // Train 3 (105Б)
  Carriage(id: 6, trainId: 3, number: 1, type: 'Плацкарт'),
  Carriage(id: 7, trainId: 3, number: 2, type: 'Купе'),
  Carriage(id: 8, trainId: 3, number: 3, type: 'СВ'),
  // Train 4 (107Б)
  Carriage(id: 9, trainId: 4, number: 1, type: 'Плацкарт'),
  Carriage(id: 10, trainId: 4, number: 2, type: 'Купе'),
  Carriage(id: 11, trainId: 4, number: 3, type: 'СВ'),
];

final List<Seat> mockSeats = _generateSeats();

List<Seat> _generateSeats() {
  final List<Seat> seats = [];
  for (final carriage in mockCarriages) {
    final seatsPerCarriage = carriage.type == 'СВ'
        ? 18
        : carriage.type == 'Купе'
            ? 36
            : 54;
    for (int i = 1; i <= seatsPerCarriage; i++) {
      seats.add(Seat(
        id: seats.length + 1,
        carriageId: carriage.id,
        number: i,
        isAvailable: DateTime.now().millisecondsSinceEpoch % 10 > 3, // 70% available
      ));
    }
  }
  return seats;
}

final List<Route> mockRoutes = [
  Route(
    id: 1,
    name: 'Минск - Брест',
    trainId: 1,
    train: mockTrains[0],
    departureStation: mockStations[0],
    arrivalStation: mockStations[1],
    departureTime: '08:00',
    arrivalTime: '12:30',
    duration: '4ч 30м',
    price: 25.50,
    availableSeats: 45,
  ),
  Route(
    id: 2,
    name: 'Минск - Брест',
    trainId: 2,
    train: mockTrains[1],
    departureStation: mockStations[0],
    arrivalStation: mockStations[1],
    departureTime: '14:00',
    arrivalTime: '18:45',
    duration: '4ч 45м',
    price: 22.00,
    availableSeats: 38,
  ),
  Route(
    id: 3,
    name: 'Минск - Гомель',
    trainId: 3,
    train: mockTrains[2],
    departureStation: mockStations[0],
    arrivalStation: mockStations[2],
    departureTime: '09:30',
    arrivalTime: '14:15',
    duration: '4ч 45м',
    price: 18.50,
    availableSeats: 52,
  ),
  Route(
    id: 4,
    name: 'Минск - Витебск',
    trainId: 4,
    train: mockTrains[3],
    departureStation: mockStations[0],
    arrivalStation: mockStations[3],
    departureTime: '10:00',
    arrivalTime: '15:30',
    duration: '5ч 30м',
    price: 20.00,
    availableSeats: 41,
  ),
];

final List<Order> mockOrders = [
  Order(
    id: 1,
    route: mockRoutes[0],
    seat: SelectedSeat(
      routeId: 1,
      seatId: 5,
      carriageId: 1,
      carriageNumber: 1,
      seatNumber: 12,
      price: 25.50,
    ),
    passenger: PassengerInfo(
      firstName: 'Иван',
      lastName: 'Иванов',
      passportData: 'AB1234567',
    ),
    status: 'PAID',
    createdAt: '2024-01-15T10:30:00',
    totalAmount: 25.50,
  ),
  Order(
    id: 2,
    route: mockRoutes[2],
    seat: SelectedSeat(
      routeId: 3,
      seatId: 15,
      carriageId: 1,
      carriageNumber: 1,
      seatNumber: 25,
      price: 18.50,
    ),
    passenger: PassengerInfo(
      firstName: 'Иван',
      lastName: 'Иванов',
      passportData: 'AB1234567',
    ),
    status: 'PAID',
    createdAt: '2024-01-10T08:15:00',
    totalAmount: 18.50,
  ),
];

// Helper functions
List<Seat> getSeatsByCarriage(int carriageId) {
  return mockSeats.where((seat) => seat.carriageId == carriageId).toList();
}

List<Carriage> getCarriagesByTrain(int trainId) {
  return mockCarriages.where((carriage) => carriage.trainId == trainId).toList();
}

List<Route> searchRoutes(String fromCity, String toCity) {
  return mockRoutes
      .where((route) =>
          route.departureStation.city.toLowerCase() == fromCity.toLowerCase() &&
          route.arrivalStation.city.toLowerCase() == toCity.toLowerCase())
      .toList();
}

List<String> getCities() {
  return mockStations.map((s) => s.city).toSet().toList();
}
