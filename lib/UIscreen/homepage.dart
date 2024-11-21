import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food/UIscreen/speech.dart';
import 'package:page_transition/page_transition.dart';
import '../model/plant.dart';
import '../pages/page1.dart';
import '../widget/plantwidget.dart';
import 'constant.dart';
import 'detailpage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Plant> favoritedPlants = [];
  int selectedIndex = 0;
  int selectedPlantTypeIndex = 0;
  String searchQuery = ''; // State variable for search query
  stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;

  // TextEditingController for the search field
  TextEditingController _searchController = TextEditingController();

  // Method to toggle the favorite status of a plant
  bool toggleIsFavorated(bool isFavorited, Plant plant) {
    setState(() {
      if (isFavorited) {
        favoritedPlants.remove(plant); // Remove from favorites if already favorited
      } else {
        favoritedPlants.add(plant); // Add to favorites if not favorited
      }
    });
    return !isFavorited;
  }

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize();
  }

  Future<void> _startListening() async {
    _isListening = true;
    setState(() {});

    _speech.listen(onResult: (result) {
      setState(() {
        searchQuery = result.recognizedWords; // Update search query with recognized words
        _searchController.text = searchQuery; // Update the TextField as well
      });
    });
  }

  Future<void> _stopListening() async {
    await _speech.stop();
    _isListening = false;
    setState(() {});
  }

  void _showSpeechModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        // Automatically start listening when the modal opens
        _startListening();

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Speak to Search", style: TextStyle(fontSize: 20)),
              SizedBox(height: 20),
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  boxShadow: _isListening
                      ? [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.5),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ]
                      : [],
                ),
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: _isListening ? Colors.blue : Colors.grey,
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(_isListening ? "Listening..." : "Tap the button to start."),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_isListening) {
                    _stopListening(); // Stop listening if already listening
                  } else {
                    _startListening(); // Start listening
                  }
                },
                child: Text(_isListening ? "Start Listening" : "Stop Listening"),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  _stopListening(); // Ensure listening stops when modal is closed
                  Navigator.of(context).pop(); // Close the modal
                },
                child: Text("Close"),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      // Stop listening when the modal is closed
      _stopListening();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Plant> _plantList = Plant.plantList;

    List<String> _plantTypes = [
      'All Plants',
      'Tomato',
      'Chilli',
      'Watermelon',
      'Cauliflower',
      'Cabbage',
      'Papaya',


      'Cucumber',
      'Capsicum',
    ];

    // Filtered plant list based on the selected plant type and search query
    List<Plant> filteredPlantList = _plantList.where((plant) {
      bool matchesType = false;

      switch (selectedPlantTypeIndex) {
        case 0:
          matchesType = true; // All plants
          break;
        case 1:
          matchesType = plant.category == 'Tomato';
          break;
        case 2:
          matchesType = plant.category == 'Chilli';
          break;
        case 3:
          matchesType = plant.category == 'Watermelon';
          break;
        case 4:
          matchesType = plant.category == 'Cauliflower';
          break;
        case 5:
          matchesType = plant.category == 'Cabbage';
          break;
        case 6:
          matchesType = plant.category == 'Papaya';
          break;
        case 7:
          matchesType = plant.category == 'Cucumber';
          break;
        case 8:
          matchesType = plant.category == 'Capsicum';
          break;
        default:
          matchesType = true;
      }

      bool matchesSearch = plant.plantName.toLowerCase().contains(searchQuery.toLowerCase());

      return matchesType && matchesSearch;
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          width: size.width * .9,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search, color: Colors.black54.withOpacity(.6)),
                              Expanded(
                                child: TextField(
                                  controller: _searchController, // Use the controller here
                                  onChanged: (value) {
                                    setState(() {
                                      searchQuery = value; // Update search query
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Search Plant',
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _showSpeechModal(context); // Open modal for speech input
                                },
                                child: Icon(
                                  Icons.mic,
                                  color: Colors.black54.withOpacity(.6),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Constants.primaryColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: 50.0,
              width: size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _plantTypes.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPlantTypeIndex = index; // Update plant type
                        });
                      },
                      child: Text(
                        _plantTypes[index],
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: selectedPlantTypeIndex == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedPlantTypeIndex == index
                              ? Constants.primaryColor
                              : Constants.blackColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: size.height * .3,
              child: ListView.builder(
                itemCount: filteredPlantList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // In HomePage (where you navigate to DetailPage)
                      Navigator.push(
                        context,
                        PageTransition(
                          child: DetailPage(
                            plant: filteredPlantList[index], // Pass the entire plant object
                          ),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );

                    },
                    child: Container(
                      width: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 5,
                            left: 5,
                            right: 5,
                            bottom: 5,
                            child: Container(
                              height: 250,
                              width: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  filteredPlantList[index].imageURL,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 13,
                            right: 20,
                            child: Container(
                              height: 50,
                              width: 50,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    bool isFavorited = toggleIsFavorated(
                                      filteredPlantList[index].isFavorated, // Pass the current favorite status
                                      filteredPlantList[index],             // Pass the plant object
                                    );
                                    filteredPlantList[index].isFavorated = isFavorited;
                                  });
                                },
                                icon: Icon(
                                  filteredPlantList[index].isFavorated
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Constants.primaryColor,
                                ),
                                iconSize: 30,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 60,
                            child: Container(
                              width: 120,
                              padding: const EdgeInsets.all(3.0), // Add padding around the text
                              decoration: BoxDecoration(
                                color: Colors.white, // Set background color to white
                                borderRadius: BorderRadius.circular(10), // Optional: Add rounded corners
                              ),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      filteredPlantList[index].category,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      filteredPlantList[index].plantName,
                                      style: const TextStyle(
                                        color: Colors.black, // Change text color to black for better contrast on white
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ),
                          ),

                          Positioned(
                            bottom: 200,
                            left: 20,
                            // right: 20,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                r'₹' + filteredPlantList[index].price.toString(),
                                style: TextStyle(
                                  color: Constants.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Constants.primaryColor.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 16, bottom: 20, top: 20),
              child: const Text(
                'New Plants',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: size.height * .5,
              child: ListView.builder(
                itemCount: filteredPlantList.length,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // In HomePage (where you navigate to DetailPage)
                      Navigator.push(
                        context,
                        PageTransition(
                          child: DetailPage(
                            plant: filteredPlantList[index], // Pass the entire plant object
                          ),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );

                    },
                    child: PlantWidget(index: index, plantList: filteredPlantList),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Toggle Favorite button logic
  // bool toggleIsFavorated(bool isFavorited) {
  //   return !isFavorited;
  // }
}
