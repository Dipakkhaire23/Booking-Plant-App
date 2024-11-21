class Plant {
  final int plantId;
  final double price;
  final String size;
  final double rating;
  final int Days;
  final String season;
  final String category;
  final String plantName;
  final String imageURL;
  bool isFavorated;
  final String decription;
  bool isSelected;
  int height;

  Plant(
      { required this.height,
        required this.plantId,
        required this.price,
        required this.category,
        required this.plantName,
        required this.size,
        required this.rating,
        required this.Days,
        required this.season,
        required this.imageURL,
        required this.isFavorated,
        required this.decription,
        required this.isSelected});

  //List of Plants data
  static List<Plant> plantList = [

    //  tomato
    Plant(
        height:50,
        plantId: 0,
        price:1.40,
        category: 'Tomato',
        plantName: '2048',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t1.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 1,
        price: 1.4,
        category: 'Chilli',
        plantName: 'Teja-4',
        size: 'Large',
        rating: 4.7,
        Days: 34,
        season: '22 - 25',
        imageURL: 'assets/m1.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 2,
        price:1.40,
        category: 'Tomato',
        plantName: 'Aryaman',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t2.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 3,
        price:1.40,
        category: 'Tomato',
        plantName: 'Yogi',
        size: 'medium',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t3.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 4,
        price:1.40,
        category: 'Tomato',
        plantName: 'kesar',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t4.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 5,
        price:1.40,
        category: 'Tomato',
        plantName: 'Anisha',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t5.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 6,
        price:1.40,
        category: 'Tomato',
        plantName: 'Atharva',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t6.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 7,
        price:1.40,
        category: 'Tomato',
        plantName: 'Virang',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t7.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(
        height:50,
        plantId: 8,
        price:1.40,
        category: 'Tomato',
        plantName: 'Netra',
        size: 'large',
        rating: 4.5,
        Days: 34,
        season: '23 - 34',
        imageURL: 'assets/t4.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),

    // Plant(
    //     height: 30,        plantId: 8,
    //     price: 2.60,
    //     category: 'Paledian',
    //     plantName: 'Shimla Mirchi',
    //     size: 'Medium',
    //     rating: 4.8,
    //     Days: 56,
    //     season: '19 - 22',
    //     imageURL: 'assets/shimal.png',
    //     isFavorated: false,
    //     decription:
    //     'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
    //         'even the harshest weather condition.',
    //     isSelected: false),
    //

    // chiilii
    Plant(height: 30,
        plantId: 9,
        price: 1.4,
        category: 'Chilli',
        plantName: 'Armar',
        size: 'Large',
        rating: 4.7,
        Days: 34,
        season: '22 - 25',
        imageURL: 'assets/m2.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 10,
        price: 1.4,
        category: 'Chilli',
        plantName: 'Jewelry',
        size: 'Large',
        rating: 4.7,
        Days: 34,
        season: '22 - 25',
        imageURL: 'assets/m3.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 11,
        price: 1.4,
        category: 'Chilli',
        plantName: 'Baleram',
        size: 'Large',
        rating: 4.7,
        Days: 34,
        season: '22 - 25',
        imageURL: 'assets/m4.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 12,
        price: 1.4,
        category: 'Chilli',
        plantName: 'Hakuni',
        size: 'Large',
        rating: 4.7,
        Days: 34,
        season: '22 - 25',
        imageURL: 'assets/m5.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 13,
        price: 1.4,
        category: 'Chilli',
        plantName: 'Talvar',
        size: 'Large',
        rating: 4.7,
        Days: 34,
        season: '22 - 25',
        imageURL: 'assets/m6.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),













    Plant(height: 30,
        plantId: 10,
        price: 1.0,
        category: 'Cauliflower',
        plantName: '473',
        size: 'Small',
        rating: 4.5,
        Days: 35,
        season: '23 - 28',
        imageURL: 'assets/f1.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 11,
        price: 1.0,
        category: 'Cauliflower',
        plantName: '1522',
        size: 'Small',
        rating: 4.5,
        Days: 35,
        season: '23 - 28',
        imageURL: 'assets/f2.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 12,
        price: 1.0,
        category: 'Cauliflower',
        plantName: '6099',
        size: 'Small',
        rating: 4.5,
        Days: 35,
        season: '23 - 28',
        imageURL: 'assets/f4.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 13,
        price: 0.9,
        category: 'Cauliflower',
        plantName: 'shuhasini',
        size: 'Small',
        rating: 4.5,
        Days: 35,
        season: '23 - 28',
        imageURL: 'assets/f3.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 14,
        price: 2.6,
        category: 'Watermelon',
        plantName: 'Bahubali',
        size: 'Large',
        rating: 4.1,
        Days: 66,
        season: '12 - 16',
        imageURL: 'assets/w1.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 15,
        price: 2.90,
        category: 'Watermelon',
        plantName: 'Jambo Red',
        size: 'Medium',
        rating: 4.4,
        Days: 36,
        season: '15 - 18',
        imageURL: 'assets/w2.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 16,
        price: 2.9,
        category: 'Watermelon',
        plantName: 'sugar king',
        size: 'Small',
        rating: 4.2,
        Days: 46,
        season: '23 - 26',
        imageURL: 'assets/w3.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 17,
        price: 2.9,
        category: 'Watermelon',
        plantName: 'Sugar King',
        size: 'Medium',
        rating: 4.5,
        Days: 90,
        season: '21 - 24',
        imageURL: 'assets/w4.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 15,
        price: 2.9,
        category: 'Watermelon',
        plantName: 'Sweet Beauty',
        size: 'Medium',
        rating: 4.7,
        Days: 80 ,
        season: '21 - 25',
        imageURL: 'assets/w9.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 16,
        price: 2.9,
        category: 'Watermelon',
        plantName: 'simbha',
        size: 'Medium',
        rating: 4.7,
        Days: 80 ,
        season: '21 - 25',
        imageURL: 'assets/w8.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 17,
        price: 0.9,
        category: 'Cabbage',
        plantName: 'Veer333',
        size: 'Medium',
        rating: 4.7,
        Days: 80 ,
        season: '21 - 25',
        imageURL: 'assets/c1.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 18,
        price: 0.8,
        category: 'Cabbage',
        plantName: 'yuro-2',
        size: 'Medium',
        rating: 4.7,
        Days: 80 ,
        season: '21 - 25',
        imageURL: 'assets/c2.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 19,
        price: 0.9,
        category: 'Cabbage',
        plantName: 'Sent',
        size: 'Medium',
        rating: 4.7,
        Days: 80 ,
        season: '21 - 25',
        imageURL: 'assets/c3.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 20,
        price: 12.0,
        category: 'Papaya',
        plantName: 'Taivan 786',
        size: 'Medium',
        rating: 4.7,
        Days: 120 ,
        season: '21 - 25',
        imageURL: 'assets/p3.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 21,
        price: 15,
        category: 'Papaya',
        plantName: 'Pusa Nanha',
        size: 'Medium',
        rating: 4.7,
        Days: 130 ,
        season: '21 - 25',
        imageURL: 'assets/p2.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
    Plant(height: 30,
        plantId: 22,
        price: 16,
        category: 'Papaya',
        plantName: 'Solo',
        size: 'Medium',
        rating: 4.7,
        Days: 130 ,
        season: '21 - 25',
        imageURL: 'assets/p1.jpg',
        isFavorated: false,
        decription:
        'This plant is one of the best plant. It grows in most of the regions in the world and can survive'
            'even the harshest weather condition.',
        isSelected: false),
  ];

  //Get the favorated items
  static List<Plant> getFavoritedPlants(){
    List<Plant> _travelList = Plant.plantList;
    return _travelList.where((element) => element.isFavorated == true).toList();
  }

  //Get the cart items
  static List<Plant> addedToCartPlants(){
    List<Plant> _selectedPlants = Plant.plantList;
    return _selectedPlants.where((element) => element.isSelected == true).toList();
  }
}