import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../providers/booking_provider.dart';
import '../data/mock_data.dart';
import '../models/models.dart';

class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Carriage? _selectedCarriage;
  List<Seat> _seats = [];
  int? _selectedSeatId;
  List<Carriage> _carriages = [];

  @override
  void initState() {
    super.initState();
    _loadCarriages();
  }

  void _loadCarriages() {
    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final route = bookingProvider.state.selectedRoute;

    if (route != null) {
      _carriages = getCarriagesByTrain(route.trainId);
      if (_carriages.isNotEmpty && _selectedCarriage == null) {
        setState(() {
          _selectedCarriage = _carriages[0];
          _loadSeats();
        });
      }
    }
  }

  void _loadSeats() {
    if (_selectedCarriage != null) {
      setState(() {
        _seats = getSeatsByCarriage(_selectedCarriage!.id);
        _selectedSeatId = null;
      });
    }
  }

  void _handleSeatSelect(Seat seat) {
    if (seat.isAvailable) {
      setState(() {
        _selectedSeatId = seat.id;
      });
    }
  }

  void _handleContinue() {
    if (_selectedSeatId == null || _selectedCarriage == null) return;

    final bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    final route = bookingProvider.state.selectedRoute;

    if (route == null) return;

    final seat = _seats.firstWhere((s) => s.id == _selectedSeatId);

    final selectedSeat = SelectedSeat(
      routeId: route.id,
      seatId: seat.id,
      carriageId: _selectedCarriage!.id,
      carriageNumber: _selectedCarriage!.number,
      seatNumber: seat.number,
      price: route.price,
    );

    bookingProvider.setSelectedSeat(selectedSeat);
    context.go('/booking');
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final route = bookingProvider.state.selectedRoute;

    if (route == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/');
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Выбор места'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/search-results'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${route.departureStation.city} → ${route.arrivalStation.city}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Поезд ${route.train?.number ?? ''} • ${route.departureTime} - ${route.arrivalTime}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${route.price.toStringAsFixed(2)} BYN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Carriage Selection
            const Text(
              'Выберите вагон',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _carriages.length,
                itemBuilder: (context, index) {
                  final carriage = _carriages[index];
                  final isSelected = _selectedCarriage?.id == carriage.id;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _selectedCarriage = carriage;
                          _loadSeats();
                        });
                      },
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue.shade50 : Colors.white,
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue.shade600
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Вагон ${carriage.number}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: isSelected
                                      ? Colors.blue.shade600
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                carriage.type,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Seat Selection
            if (_selectedCarriage != null) ...[
              Text(
                'Вагон ${_selectedCarriage!.number} - ${_selectedCarriage!.type}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Legend
              Row(
                children: [
                  _buildLegendItem(Colors.green.shade100, Colors.green, 'Свободно'),
                  const SizedBox(width: 16),
                  _buildLegendItem(Colors.red.shade100, Colors.red, 'Занято'),
                  const SizedBox(width: 16),
                  _buildLegendItem(Colors.blue.shade100, Colors.blue, 'Выбрано'),
                ],
              ),
              const SizedBox(height: 16),
              // Seat Grid
              _buildSeatGrid(),
            ],

            const SizedBox(height: 32),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selectedSeatId != null ? _handleContinue : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade600,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text(
                  'Продолжить оформление',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color bgColor, Color borderColor, String label) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: bgColor,
            border: Border.all(color: borderColor, width: 2),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSeatGrid() {
    if (_selectedCarriage == null) return const SizedBox.shrink();

    final seatsPerRow = _selectedCarriage!.type == 'СВ'
        ? 2
        : _selectedCarriage!.type == 'Купе'
            ? 4
            : 6;

    final rows = <List<Seat>>[];
    for (int i = 0; i < _seats.length; i += seatsPerRow) {
      rows.add(_seats.sublist(
        i,
        i + seatsPerRow > _seats.length ? _seats.length : i + seatsPerRow,
      ));
    }

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: row.map((seat) {
              final isSelected = _selectedSeatId == seat.id;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: InkWell(
                  onTap: seat.isAvailable
                      ? () => _handleSeatSelect(seat)
                      : null,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade600
                          : seat.isAvailable
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                      border: Border.all(
                        color: isSelected
                            ? Colors.blue.shade800
                            : seat.isAvailable
                                ? Colors.green.shade400
                                : Colors.red.shade400,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        '${seat.number}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : seat.isAvailable
                                  ? Colors.black
                                  : Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
