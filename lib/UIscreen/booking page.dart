// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'constant.dart';
//
// class BookingPage extends StatefulWidget {
//   @override
//   _BookingPageState createState() => _BookingPageState();
// }
//
// class _BookingPageState extends State<BookingPage> {
//
//   Future<void> _saveBookingDetails() async {
//     if (_formKey.currentState!.validate()) {
//       bool confirm = await _confirmBooking();
//       if (!confirm) return;
//
//       setState(() {
//         _isLoading = true;
//       });
//
//       try {
//         await FirebaseFirestore.instance.collection('booking').add({
//           'name': _nameController.text,
//           'phone': _phoneController.text,
//           'service': _selectedService,
//           'bookingDate': _bookingDate?.toIso8601String(),
//           'deliveryDate': _deliveryDate?.toIso8601String(),
//           'paymentMethod': _paymentMethod,
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//
//         Fluttertoast.showToast(
//           msg: "Booking Successful and Saved to Firebase",
//           toastLength: Toast.LENGTH_SHORT,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//
//         _resetForm();
//       } catch (e) {
//         Fluttertoast.showToast(
//           msg: "Error: $e",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//           fontSize: 16.0,
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }
//     void _resetForm() {
//     _formKey.currentState!.reset();
//     setState(() {
//       _selectedService = null;
//       _bookingDate = null;
//       _deliveryDate = null;
//       _paymentMethod = "Credit Card";
//     });
//   }
//
//
//   final _formKey = GlobalKey<FormState>();
//   String? _selectedService;
//   String _paymentMethod = "Credit Card";
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   DateTime? _bookingDate;
//   DateTime? _deliveryDate;
//
//   // Updated service options
//   final List<String> _serviceOptions = [
//     "Self Pickup",
//     "Nursery Delivery",
//     "Custom Service (You Pay the Rent)"
//   ];
//
//   Future<void> _selectDate(BuildContext context, bool isBookingDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2025),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isBookingDate) {
//           _bookingDate = picked;
//         } else if (picked.isAfter(_bookingDate ?? DateTime.now())) {
//           _deliveryDate = picked;
//         } else {
//           Fluttertoast.showToast(
//             msg: "Delivery date must be after the booking date.",
//             toastLength: Toast.LENGTH_SHORT,
//             gravity: ToastGravity.BOTTOM,
//             timeInSecForIosWeb: 1,
//             backgroundColor: Colors.red,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//         }
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Booking Page"),
//         backgroundColor: Colors.green,
//       ),
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           // gradient: LinearGradient(
//           //   begin: Alignment.topCenter,
//           //   end: Alignment.bottomCenter,
//           //   colors: [
//           //     Colors.green.shade200,
//           //     Colors.white70,
//           //   ],
//           // ),
//           color: Colors.white
//         ),
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Select Service", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),
//                   DropdownButtonFormField<String>(
//                     value: _selectedService,
//                     hint: Text("Choose a service"),
//                     items: _serviceOptions.map((String value) {
//                       return DropdownMenuItem<String>(
//                         value: value,
//                         child: Text(value),
//                       );
//                     }).toList(),
//                     onChanged: (newValue) {
//                       setState(() {
//                         _selectedService = newValue;
//                       });
//                     },
//                     validator: (value) => value == null ? "Please select a service" : null,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(color: Colors.blue, width: 2.0),
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text("Your Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   _buildTextField("Name", _nameController, (value) {
//                     if (value == null || value.isEmpty) return 'Please enter your name';
//                     return null;
//                   }),
//                   _buildTextField("Mobile Number", _phoneController, (value) {
//                     if (value == null || value.isEmpty) return 'Please enter Mobile Number';
//                     if (!RegExp(r'^\d{10}$').hasMatch(value)) return 'Please enter a valid 10-digit mobile number';
//                     return null;
//                   }),
//                   SizedBox(height: 20),
//                   Text("Select Booking Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   _buildDateField("Select Booking Date", _bookingDate, true),
//                   SizedBox(height: 20),
//                   Text("Select Delivery Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   _buildDateField("Select Delivery Date", _deliveryDate, false),
//                   SizedBox(height: 20),
//                   Text("Select Payment Method", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   _buildPaymentMethodOption("Credit Card", Icons.credit_card),
//                   _buildPaymentMethodOption("Google Pay", Icons.account_balance_wallet),
//                   _buildPaymentMethodOption("Paypal", Icons.paypal),
//                   SizedBox(height: 10),
//                   Center(child: Container(
//                       width: 150,
//                       height: 50,
//                       child: InkWell(
//                         onTap:  _onBookNowPressed,
//                         child: Container(
//                           decoration: BoxDecoration(
//                               color: Constants.primaryColor,
//                               borderRadius: BorderRadius.circular(10),
//                               boxShadow: [
//                                 BoxShadow(
//                                   offset: const Offset(0, 1),
//                                   blurRadius: 5,
//                                   color: Constants.primaryColor.withOpacity(.3),
//                                 )
//                               ]),
//                           child: const Center(
//                             child: Text(
//                               'BOOK NOW',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 20.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                   ),)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField(String label, TextEditingController controller, String? Function(String?) validator) {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: TextFormField(
//         controller: controller,
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue, width: 2.0),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.green, width: 2.0),
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//           contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//         ),
//         validator: validator,
//       ),
//     );
//   }
//
//   Widget _buildDateField(String label, DateTime? date, bool isBookingDate) {
//     return GestureDetector(
//       onTap: () => _selectDate(context, isBookingDate),
//       child: AbsorbPointer(
//         child: TextFormField(
//           decoration: InputDecoration(
//             labelText: date == null ? label : "${date.toLocal()}".split(' ')[0],
//             border: OutlineInputBorder(),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.blue, width: 2.0),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.green, width: 2.0),
//               borderRadius: BorderRadius.circular(8.0),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPaymentMethodOption(String method, IconData icon) {
//     return ListTile(
//       title: Row(
//         children: [
//           Icon(icon, color: Colors.blueAccent),
//           SizedBox(width: 8),
//           Text(method),
//         ],
//       ),
//       leading: Radio<String>(
//         value: method,
//         groupValue: _paymentMethod,
//         onChanged: (value) {
//           setState(() {
//             _paymentMethod = value!;
//           });
//         },
//       ),
//     );
//   }
//
//   void _onBookNowPressed() {
//     if (_formKey.currentState!.validate()) {
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text("Booking Confirmed"),
//             content: Text(
//               "Service: $_selectedService\n"
//                   "Name: ${_nameController.text}\n"
//                   "Phone: ${_phoneController.text}"
//                   "Booking Date: ${_bookingDate?.toLocal().toString().split(' ')[0]}\n"
//                   "Delivery Date: ${_deliveryDate?.toLocal().toString().split(' ')[0]}\n"
//                   "Payment Method: $_paymentMethod\n",
//
//               style: TextStyle(fontSize: 16),
//             ),
//             actions: [
//               TextButton(
//                 child: Text("OK"),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   Fluttertoast.showToast(
//                     msg: "Booking Successful",
//                     toastLength: Toast.LENGTH_SHORT,
//                     gravity: ToastGravity.BOTTOM,
//                     timeInSecForIosWeb: 1,
//                     backgroundColor: Colors.green,
//                     textColor: Colors.white,
//                     fontSize: 16.0,
//                   );
//                   _nameController.clear();
//                   _phoneController.clear();
//                   _bookingDate;
//                   _deliveryDate;
//
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
// }



import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';



class BookingPage extends StatefulWidget {
  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  bool _showPayNowButton = false;
  void initState() {
    super.initState();
    // Listen for changes in the advanced amount field
    _advanced.addListener(() {
      setState(() {
        _showPayNowButton = _advanced.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _advanced.dispose();
    super.dispose();
  }
  Future<void> _showPaymentMethodDialog() async {
    String? selectedPayment = _paymentMethod;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select Payment Method"),
        content: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<String>(
                  title: Text("Credit Card"),
                  value: "Credit Card",
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    setState(() => selectedPayment = value);
                  },
                ),
                RadioListTile<String>(
                  title: Text("Google Pay"),
                  value: "Google Pay",
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    setState(() => selectedPayment = value);
                  },
                ),
                RadioListTile<String>(
                  title: Text("Paypal"),
                  value: "Paypal",
                  groupValue: selectedPayment,
                  onChanged: (value) {
                    setState(() => selectedPayment = value);
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _paymentMethod = selectedPayment ?? "");
              Navigator.of(context).pop();
              _showPayNowButton = false;
              Fluttertoast.showToast(
                msg: "Payment method selected: $_paymentMethod",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }




  final _formKey = GlobalKey<FormState>();
  String? _selectedService;
  String _paymentMethod = "";
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _advanced = TextEditingController();
  final TextEditingController _tyeController = TextEditingController();
  final TextEditingController _verity = TextEditingController();
  DateTime? _bookingDate;
  DateTime? _deliveryDate;
  bool _isLoading = false;

  final List<String> _serviceOptions = [
    "Self Pickup",
    "Nursery Delivery",
    "Custom Service (You Pay the Rent)"
  ];

  Future<void> _selectDate(BuildContext context, bool isBookingDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      setState(() {
        if (isBookingDate) {
          _bookingDate = picked;
        } else if (picked.isAfter(_bookingDate ?? DateTime.now())) {
          _deliveryDate = picked;
        } else {
          Fluttertoast.showToast(
            msg: "Delivery date must be after the booking date.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      });
    }
  }

  Future<void> _saveBookingDetails() async {
    if (_formKey.currentState!.validate()) {
      bool confirm = await _confirmBooking();
      if (!confirm) return;

      setState(() {
        _isLoading = true;
      });

      try {
        // Save booking details to Firestore
        await FirebaseFirestore.instance.collection('booking').add({
          'name': _nameController.text,
          'phone': _phoneController.text,
          'Type':_tyeController.text,
          'Verity':_verity.text,
          'advanced':_advanced.text,
          'service': _selectedService,
          'bookingDate': _bookingDate?.toIso8601String(),
          'deliveryDate': _deliveryDate?.toIso8601String(),
          'paymentMethod': _paymentMethod,
          'createdAt': FieldValue.serverTimestamp(),
        });

        Fluttertoast.showToast(
          msg: "Booking Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        // Clear name and phone number fields
        _nameController.clear();
        _phoneController.clear();
        _advanced.clear();

        // Reset other form fields
        _resetForm();

      } catch (e) {
        Fluttertoast.showToast(
          msg: "Error: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }




  Future<bool> _confirmBooking() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Booking"),
        content: Text("Are you sure you want to proceed with this booking?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("Confirm"),
          ),
        ],
      ),
    ) ??
        false;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _verity.clear();
      _tyeController.clear();
      _advanced.clear();
      _phoneController.clear();
      _nameController.clear();
      _selectedService = null;
      _bookingDate = null;
      _deliveryDate = null;

      _paymentMethod = "";
    });
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
  }

  String? validateField(String? value, String fieldName, {int? minLength}) {
    if (value == null || value.isEmpty) return ' $fieldName';
    if (minLength != null && value.length < minLength) return '$fieldName must be at least $minLength characters';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Booking Details",style: TextStyle(fontWeight: FontWeight.bold,),),),
        backgroundColor: Colors.green,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [Colors.green.shade200, Colors.white70],
          // ),
            color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Service", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green)),
                  SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    value: _selectedService,
                    hint: Text("Choose a service"),
                    items: _serviceOptions.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedService = newValue;
                      });
                    },
                    validator: (value) => value == null ? "Please select a service" : null,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Your Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green)),
                  _buildTextField("Name", _nameController, (value) => validateField(value, " please Enter Name")),
                  _buildTextField(
                    "Mobile Number",
                    _phoneController,
                        (value) => validateField(value, " please Enter Mobile Number", minLength: 10),
                  ),
                  SizedBox(height: 20),
                  Text("Plant Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green)),
                  _buildTextField("Type", _tyeController, (value) => validateField(value, " please Enter Type")),
                  _buildTextField("Verity", _verity, (value) => validateField(value, " please Enter Verity")),
                  SizedBox(height: 20),
                  Text("Select Dates", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green)),
                  Text("Select Booking Date"),
                  _buildDateField("Booking Date", _bookingDate, true),
                  SizedBox(height: 20),
                  Text("Select Delivery Date"),
                  _buildDateField("Delivery Date", _deliveryDate, false),
                  SizedBox(height: 20),
                  Text("Pay Advanced"),
                  _buildTextField("Enter Amount", _advanced, (value) => validateField(value, "Required to Pay 50% Amount")),
                  if (_showPayNowButton) // Show Pay Now button only if the amount is entered
                    Center(
                      child: ElevatedButton(
                        onPressed: () => _showPaymentMethodDialog(),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          backgroundColor: Colors.green,
                        ),
                        child: Text(
                          "Pay Now",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                  // Text("Select Payment Methods", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.green)),
                  // _buildPaymentOptions(),
                  SizedBox(height: 10),
                  Center(
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: _isLoading ? 0.5 : 1.0,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _saveBookingDetails,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25), // Rounded edges
                          ),
                          elevation: _isLoading ? 0 : 8,
                          backgroundColor: Colors.greenAccent.shade400, // Gradient-like color
                          shadowColor: Colors.green.shade100,
                        ),
                        child: _isLoading
                            ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                            SizedBox(width: 10),
                            Text("Processing...", style: TextStyle(color: Colors.white)),
                          ],
                        )
                            : TweenAnimationBuilder<double>(
                          tween: Tween<double>(begin: 1.0, end: 1.1),
                          duration: Duration(milliseconds: 600),
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: Text(
                            "Book Now",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          onEnd: () => setState(() {}),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String? Function(String?) validator) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, bool isBookingDate) {
    return GestureDetector(
      onTap: () => _selectDate(context, isBookingDate),
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: date == null ? label : formatDate(date),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOptions() {
    return Column(
      children: [
        _buildPaymentOption("Credit Card"),
        _buildPaymentOption("Google Pay"),
        _buildPaymentOption("Paypal"),
      ],
    );
  }

  Widget _buildPaymentOption(String option) {
    return RadioListTile<String>(
      title: Text(option),
      value: option,
      groupValue: _paymentMethod,
      onChanged: (value) {
        setState(() {
          _paymentMethod = value!;
        });
      },
    );
  }
}