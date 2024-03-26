import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Parking.dart';
import 'parkinglotLinking.dart';
import 'home_screen.dart';

class ParkingsEditScreen extends StatefulWidget {
  final Parking? parking;

  ParkingsEditScreen({this.parking, Key? key}) : super(key: key);

  @override
  State<ParkingsEditScreen> createState() => _ParkingsEditScreenState();
}

class _ParkingsEditScreenState extends State<ParkingsEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _capacityController;
  late ParkingController parkingsController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.parking != null ? widget.parking!.name : '');
    _locationController = TextEditingController(
        text: widget.parking != null ? widget.parking!.location : '');
    _capacityController = TextEditingController(
        text: widget.parking != null
            ? widget.parking!.capacity
            : ''); // Capacity treated as a string
  }

  handleCreateNote() async {
    Parking parking = Parking(
      '0',
      name: _nameController.text,
      location: _locationController.text,
      capacity: _capacityController.text, // Capacity treated as a string
    );
    await parkingsController.addParking(parking);
  }

  handleEditNote() async {
    Parking parking = Parking(
      widget.parking!.id,
      name: _nameController.text,
      location: _locationController.text,
      capacity: _capacityController.text, // Capacity treated as a string
    );
    await parkingsController.editParking(parking);
  }

  @override
  Widget build(BuildContext context) {
    parkingsController = Provider.of<ParkingController>(context);
    return Scaffold(
backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: parkingsController.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.arrow_back_ios_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (widget.parking == null) {
                                  handleCreateNote();
                                } else {
                                  handleEditNote();
                                }
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const HScreen()),
                                    (route) => false);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  widget.parking == null ? "Add" : "Update",
                                
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: " Name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _locationController,
                          decoration: InputDecoration(
                            hintText: " Location",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: _capacityController,
                          decoration: InputDecoration(
                            hintText: " Capacity",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
