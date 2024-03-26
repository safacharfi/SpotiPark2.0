import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'parkinglotLinking.dart';
import 'parkinglotdetail.dart';
import 'parkinglotEdit.dart';
import 'Parking.dart';

class HScreen extends StatefulWidget {
  const HScreen({Key? key});

  @override
  State<HScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HScreen> {
  late ParkingController contactController;
  late List<Parking> parkings;

  @override
  Widget build(BuildContext context) {
    contactController = Provider.of<ParkingController>(context, listen: true);
    parkings = contactController.parkings;
    debugPrint("number of parking lots ${parkings.length}");

    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ParkingsEditScreen(),
            ),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFF80DFEA),
            borderRadius: BorderRadius.circular(200),
          ),
          child: const Center(
            child: Text(
              "+",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFEAEFEF),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: contactController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Your Parking lots",
                           
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          itemCount: parkings.length,
                          itemBuilder: (BuildContext context, int index) {
                            bool isThirdNote = (index + 1) % 3 == 0;
                            Parking parking = parkings[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ParkingDetailScreen(
                                      parking: parking,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                // Added child property for GestureDetector
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                color:
                                    const Color(0xFF91BBD1), // Background color
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name: ${parking.name}',
                                       
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Location: ${parking.location}', // Corrected typo in 'licensePlate'
                                       
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Capacity: ${parking.capacity}',
                                        
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.count(
                                  (index + 1) % 3 == 0 ? 2 : 1, 1),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
