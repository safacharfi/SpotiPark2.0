import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:land_registration/User/dashboard.dart';
import 'package:provider/provider.dart';
import 'Vehicle.dart';
import 'VehiculeLinking.dart';
import 'screens/home-screen.dart';
import '/User/dashboard.dart';

class VehiclesEditScreen extends StatefulWidget {
  Vehicle? vehicle;
  VehiclesEditScreen({this.vehicle, super.key});

  @override
  State<VehiclesEditScreen> createState() => _VehiclesEditScreenState();
}

class _VehiclesEditScreenState extends State<VehiclesEditScreen> {
  late TextEditingController _brandController;
  late TextEditingController _lisencePlateController;
  late TextEditingController _modelController;
  late VehicleController vehiclesController;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(
        text: widget.vehicle != null ? widget.vehicle?.brand : '');
    _lisencePlateController = TextEditingController(
        text: widget.vehicle != null ? widget.vehicle?.lisencePlate : '');
    _modelController = TextEditingController(
        text: widget.vehicle != null ? widget.vehicle?.model : '');
  }

  handleCreateNote() async {
    Vehicle vehicle = Vehicle(
      '0',
      brand: _brandController.text,
      lisencePlate: _lisencePlateController.text,
      model: _modelController.text,
    );
    await vehiclesController.addVehicle(vehicle);
  }

  handleEditNote() async {
    Vehicle vehicle = Vehicle(
      widget.vehicle!.id,
      brand: _brandController.text,
      lisencePlate: _lisencePlateController.text,
      model: _modelController.text,
    );
    await vehiclesController.editVehicle(vehicle);
  }

  @override
  Widget build(BuildContext context) {
    vehiclesController = Provider.of<VehicleController>(context);
    return Scaffold(
      backgroundColor: Color(0xFFDCE9EF), // Set background color here
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: vehiclesController.isLoading
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
                                if (widget.vehicle == null) {
                                  handleCreateNote();
                                } else {
                                  handleEditNote();
                                }
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Dashboard()),
                                    (route) => false);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  widget.vehicle == null ? "Add" : "Update",
                                 
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _brandController,
                         
                          decoration: InputDecoration(
                            hintText: " Brand",
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
                          controller: _lisencePlateController,
                         
                          decoration: InputDecoration(
                            hintText: " Lisence Plate",
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
                          controller: _modelController,
                         
                          decoration: InputDecoration(
                            hintText: " Model",
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
