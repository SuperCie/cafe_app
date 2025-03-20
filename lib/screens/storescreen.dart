import 'package:coffee_app/data/store.dart';
import 'package:coffee_app/data/storeprovider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class Storescreen extends StatefulWidget {
  const Storescreen({super.key});

  @override
  State<Storescreen> createState() => _StorescreenState();
}

class _StorescreenState extends State<Storescreen> {
  late Future<List<Store>> _storesFuture;
  List<Store>? _stores;
  List<Store>? _filteredStores;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _storesFuture = getStoresFromFirestore();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final storeProvider = Provider.of<Storeprovider>(context, listen: false);
      if (storeProvider.selectedStore != null) {
        _mapController.move(
          LatLng(
            storeProvider.selectedStore!.latitude,
            storeProvider.selectedStore!.longitude,
          ),
          15, // Zoom level
        );
      }
    });
  }

  void confirmSelectedStore(BuildContext context, Store store) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Confirm Pickup Store',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            content: ListTile(
              title: Text(
                store.name,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                store.address,
                style: GoogleFonts.montserrat(fontSize: 16),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.0),
                  ),
                  child: Text(
                    "Change Store",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Provider.of<Storeprovider>(
                    context,
                    listen: false,
                  ).setStore(store);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.green.shade800,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 1.0),
                  ),
                  child: Text(
                    "Confirm",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    setState(() {
      isSearching = false; // Menghentikan mode pencarian
      _searchController.clear();
      _filteredStores = _stores;
    });
  }

  void _filterStores(String query) {
    if (_stores == null) return; // Pastikan _stores tidak null sebelum filter

    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredStores =
          _stores!
              .where((store) => store.name.toLowerCase().contains(_searchQuery))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final storeProvider = Provider.of<Storeprovider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title:
            isSearching
                ? TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search store...',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    _filterStores(value);
                  },

                  autofocus: true,
                )
                : Text(
                  'Choose Store',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        actions:
            isSearching
                ? [
                  IconButton(
                    onPressed: stopSearch,
                    icon: Icon(Icons.search_off_rounded),
                  ),
                ]
                : [
                  IconButton(onPressed: startSearch, icon: Icon(Icons.search)),
                ],
      ),
      body: FutureBuilder(
        future: _storesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada toko yang tersedia"));
          }
          final stores = snapshot.data!;
          _stores ??= stores; // Set data hanya jika _stores masih null
          _filteredStores ??= stores; // Set data untuk list yang ditampilkan
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // map
              Expanded(
                flex: 1,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    interactionOptions: InteractionOptions(
                      flags: InteractiveFlag.all,
                    ),
                    initialCenter:
                        stores.isNotEmpty
                            ? LatLng(stores[0].latitude, stores[0].longitude)
                            : const LatLng(-6.200000, 106.816666),
                    initialZoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayer(
                      markers:
                          stores.map((store) {
                            return Marker(
                              height: 40,
                              width: 40,
                              point: LatLng(store.latitude, store.longitude),
                              child: GestureDetector(
                                onTap: () {
                                  storeProvider.setStore(store);
                                  _mapController.move(
                                    LatLng(store.latitude, store.longitude),
                                    15, // Zoom level lebih dekat
                                  );
                                },
                                child: Icon(
                                  Icons.location_pin,
                                  color:
                                      storeProvider.selectedStore?.id ==
                                              store.id
                                          ? Colors.green.shade800
                                          : Colors.red.shade800,
                                  size: 40,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 20,
                ),
                child: Text(
                  'Choose a store for pickup',
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _filteredStores!.length,
                  itemBuilder: (context, index) {
                    final store = _filteredStores![index];
                    return Column(
                      children: [
                        CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          checkboxShape: CircleBorder(),
                          activeColor: Colors.green.shade800,
                          title: Text(
                            store.name,
                            style: GoogleFonts.montserrat(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            store.address,
                            style: GoogleFonts.montserrat(fontSize: 14),
                          ),
                          value: storeProvider.selectedStore?.id == store.id,
                          onChanged: (bool? value) {
                            setState(() {
                              if (value == true) {
                                storeProvider.setStore(store);
                                _mapController.move(
                                  LatLng(store.latitude, store.longitude),
                                  15, // Zoom level lebih dekat
                                );
                              } else {
                                storeProvider.clearStore();
                              }
                            });
                          },
                        ),
                        Divider(thickness: 1.0),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            if (storeProvider.selectedStore == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red.shade800,
                  content: Text(
                    'Store not selected',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  padding: EdgeInsets.all(10),
                ),
              );
            } else {
              confirmSelectedStore(context, storeProvider.selectedStore!);
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 1.5,
                color: Theme.of(context).colorScheme.secondary,
              ),
              color: Colors.green.shade800,
            ),
            child: Text(
              'Confirm Store',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
