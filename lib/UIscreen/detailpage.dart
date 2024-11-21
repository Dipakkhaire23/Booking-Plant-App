import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../model/plant.dart';
import 'booking page.dart';
import 'constant.dart';

class DetailPage extends StatefulWidget {
  final Plant plant;

  const DetailPage({Key? key, required this.plant}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.plantName),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Plant Image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    widget.plant.imageURL,
                    height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Plant Name
              Center(
                child: Text(
                  widget.plant.plantName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Category and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category: ${widget.plant.category}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₹${widget.plant.price}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Plant Details
              _buildDetailRow('Size', widget.plant.size),
              _buildDetailRow('Rating', widget.plant.rating.toString()),
              _buildDetailRow('Days to Grow', '${widget.plant.Days} days'),
              _buildDetailRow('Season', widget.plant.season),
              const SizedBox(height: 16),
              // Description
              const Text(
                'Description:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.plant.decription,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              // Favorite and Add to Cart Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Toggle favorite status
                      widget.plant.isFavorated = !widget.plant.isFavorated;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(widget.plant.isFavorated
                              ? 'Added to Favorites!'
                              : 'Removed from Favorites!'),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.plant.isFavorated ? 'Unfavorite' : 'Favorite',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Toggle selection status
                      widget.plant.isSelected = !widget.plant.isSelected;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            widget.plant.isSelected
                                ? 'Added to Cart!'
                                : 'Removed from Cart!',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      widget.plant.isSelected ? 'Remove from Cart':'Add to card' ,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),
              Center(
                child: Container(
                  width: 150,
                  height: 50,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isTapped = !_isTapped; // Toggle the tap state
                      });
                      Navigator.push(
                        context,
                        PageTransition(
                          child: BookingPage(),
                          type: PageTransitionType.bottomToTop,
                        ),
                      );
                    },
                    child: AnimatedScale(
                      scale: _isTapped ? 1.1 : 1.0, // Scale effect when tapped
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: _isTapped ? 10 : 5, // Increase shadow on tap
                              color: Constants.primaryColor.withOpacity(0.3),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'BOOK NOW',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for plant detail rows
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
