import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_application6/ui/widget/map_picker_screen.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class AddPropertyScreen extends StatefulWidget {
  final String category;
  final QueryDocumentSnapshot? propertyData;

  const AddPropertyScreen({Key? key, required this.category, this.propertyData}) : super(key: key);

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  String? propertyType;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  int bedrooms = 0;
  int bathrooms = 0;
  int parking = 0;

  final List<File?> _selectedImages = [null, null, null];
  final List<String?> _networkImages = [null, null, null];
  final picker = ImagePicker();
  bool _loading = false;

  double? pickedLat;
  double? pickedLng;

  final String cloudName = "dzhkytyhh";
  final String uploadPreset = "properties";

  @override
  void initState() {
    super.initState();
    if (widget.propertyData != null) {
      final data = widget.propertyData!.data() as Map<String, dynamic>;
      _titleController.text = data['title'] ?? '';
      _locationController.text = data['location'] ?? '';
      _priceController.text = (data['price'] ?? '').toString();
      _areaController.text = (data['area'] ?? '').toString();
      _descriptionController.text = data['description'] ?? '';
      bedrooms = data['bedrooms'] ?? 0;
      bathrooms = data['bathrooms'] ?? 0;
      parking = data['parking'] ?? 0;
      propertyType = data['type'] ?? null;
      _contactController.text = data['contactNumber'] ?? '';

      if (data.containsKey('latitude') && data.containsKey('longitude')) {
        pickedLat = (data['latitude'] as num?)?.toDouble();
        pickedLng = (data['longitude'] as num?)?.toDouble();
      }

      if (data['images'] != null && (data['images'] as List).isNotEmpty) {
        for (int i = 0; i < 3; i++) {
          if (i < (data['images'] as List).length) {
            _networkImages[i] = (data['images'] as List)[i];
          }
        }
      }
    } else {
      _contactController.text = "+880";
    }
  }

  void _increment(Function() update) => setState(update);
  void _decrement(Function() update) => setState(update);

  Future<void> _pickImage(int index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImages[index] = File(pickedFile.path);
        _networkImages[index] = null;
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    final url = Uri.parse("https://api.cloudinary.com/v1_1/$cloudName/image/upload");
    final request = http.MultipartRequest("POST", url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    if (response.statusCode == 200) {
      final resData = await http.Response.fromStream(response);
      final data = json.decode(resData.body);
      return data['secure_url'];
    }
    return null;
  }

  bool _validateContact(String value) {
    final reg = RegExp(r'^\+880\d{10}$');
    return reg.hasMatch(value);
  }

  Future<void> _submitProperty() async {
    if (_titleController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _areaController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        propertyType == null ||
        _contactController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields & select property type")),
      );
      return;
    }

    if (!_validateContact(_contactController.text.trim())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contact must be in format +880##########")),
      );
      return;
    }

    setState(() => _loading = true);

    List<String> imageUrls = [];
    for (int i = 0; i < 3; i++) {
      if (_selectedImages[i] != null) {
        final url = await _uploadImage(_selectedImages[i]!);
        if (url != null) imageUrls.add(url);
      } else if (_networkImages[i] != null) {
        imageUrls.add(_networkImages[i]!);
      }
    }

    final uid = FirebaseAuth.instance.currentUser?.uid ?? "anonymous";
    final dataToSave = {
      "title": _titleController.text,
      "location": _locationController.text,
      "price": double.tryParse(_priceController.text) ?? 0,
      "bedrooms": bedrooms,
      "bathrooms": bathrooms,
      "parking": parking,
      "area": double.tryParse(_areaController.text) ?? 0,
      "description": _descriptionController.text,
      "type": propertyType,
      "category": widget.category,
      "isActive": true,
      "createdBy": uid,
      "images": imageUrls,
      "contactNumber": _contactController.text.trim(),
    };

    if (pickedLat != null && pickedLng != null) {
      dataToSave['latitude'] = pickedLat;
      dataToSave['longitude'] = pickedLng;
    }

    if (widget.propertyData != null) {
      await FirebaseFirestore.instance
          .collection("properties")
          .doc(widget.propertyData!.id)
          .update(dataToSave);
    } else {
      dataToSave['createdAt'] = FieldValue.serverTimestamp();
      await FirebaseFirestore.instance.collection("properties").add(dataToSave);
    }

    setState(() => _loading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.propertyData != null
            ? "Property Updated Successfully"
            : "Property Submitted Successfully"),
      ),
    );
    Navigator.pop(context);
  }

  Widget _inputBox(String label, TextEditingController controller,
      {Widget? prefix, IconData? icon, String? hintText, Widget? suffix}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
            prefixIcon: prefix == null && icon != null ? Icon(icon, color: Colors.black54) : null,
            prefix: prefix,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }

  Widget _counterBox(
      String label, int value, VoidCallback increment, VoidCallback decrement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: decrement, icon: const Icon(Icons.remove)),
              Text('$value'),
              IconButton(onPressed: increment, icon: const Icon(Icons.add)),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openMapPicker() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => MapPickerScreen(
        initialLat: pickedLat,
        initialLng: pickedLng,
        initialAddress: _locationController.text.isNotEmpty ? _locationController.text : null,
      )),
    );

    if (result != null && mounted) {
      setState(() {
        _locationController.text = result['address'] ?? _locationController.text;
        pickedLat = result['lat'];
        pickedLng = result['lng'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Centered title
                          Text(
                            widget.propertyData != null
                                ? 'Edit Your Property'
                                : 'Add Your Property',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          // Back button on the left
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Fill in the details to list your property",
                    style: TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Select Option', style: TextStyle(fontWeight: FontWeight.bold)),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButton<String>(
                    value: propertyType,
                    isExpanded: true,
                    underline: const SizedBox(),
                    hint: const Text('Rent / Sell'),
                    items: const [
                      DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                      DropdownMenuItem(value: 'Sell', child: Text('Sell')),
                    ],
                    onChanged: (value) => setState(() => propertyType = value),
                  ),
                ),
                const SizedBox(height: 16),
                _inputBox('Title', _titleController, icon: Icons.title, hintText: 'Enter the property title'),
                const SizedBox(height: 16),
                _inputBox(
                  'Location',
                  _locationController,
                  icon: Icons.location_on,
                  hintText: 'Enter the property location',
                  suffix: IconButton(icon: const Icon(Icons.map_outlined), onPressed: _openMapPicker),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _inputBox(
                          'Price',
                          _priceController,
                          prefix: const Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text('৳', style: TextStyle(fontSize: 18)),
                          ),
                          hintText: 'Enter price',
                        )
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: _counterBox('Bedrooms', bedrooms,
                                () => _increment(() => bedrooms++),
                                () => _decrement(() => bedrooms = bedrooms > 0 ? bedrooms - 1 : 0))),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _counterBox('Bathrooms', bathrooms,
                                () => _increment(() => bathrooms++),
                                () => _decrement(() => bathrooms = bathrooms > 0 ? bathrooms - 1 : 0))),
                    const SizedBox(width: 8),
                    Expanded(
                        child: _counterBox('Parking', parking,
                                () => _increment(() => parking++),
                                () => _decrement(() => parking = parking > 0 ? parking - 1 : 0))),
                  ],
                ),
                const SizedBox(height: 16),
                _inputBox('Area (sqft)', _areaController, icon: Icons.square_foot, hintText: 'Enter area'),
                const SizedBox(height: 16),
                const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Describe your property in detail...'),
                ),
                const SizedBox(height: 16),
                _inputBox('Contact Number', _contactController, icon: Icons.phone, hintText: '+8801XXXXXXXXX'),
                const SizedBox(height: 16),
                const Text('Upload Images', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return GestureDetector(
                      onTap: () => _pickImage(index),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          image: _selectedImages[index] != null
                              ? DecorationImage(image: FileImage(_selectedImages[index]!), fit: BoxFit.cover)
                              : _networkImages[index] != null
                              ? DecorationImage(image: NetworkImage(_networkImages[index]!), fit: BoxFit.cover)
                              : null,
                        ),
                        child: (_selectedImages[index] == null && _networkImages[index] == null)
                            ? const Icon(Icons.add)
                            : null,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _loading ? null : _submitProperty,
                    child: _loading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(widget.propertyData != null ? 'Update Property' : 'Submit Property'),
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