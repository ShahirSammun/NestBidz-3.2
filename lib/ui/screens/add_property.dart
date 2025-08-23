import 'package:flutter/material.dart';
import 'package:mobile_application6/ui/widget/screen_background.dart';

class AddPropertyScreen extends StatefulWidget {
  const AddPropertyScreen({Key? key}) : super(key: key);

  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  String? propertyType;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  int beds = 0;
  int baths = 0;
  final TextEditingController _descriptionController = TextEditingController();

  void _incrementBeds() => setState(() => beds++);
  void _decrementBeds() => setState(() => beds = beds > 0 ? beds - 1 : 0);

  void _incrementBaths() => setState(() => baths++);
  void _decrementBaths() => setState(() => baths = baths > 0 ? baths - 1 : 0);

  void _submitProperty() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Property Submitted Successfully")),
    );
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
                // Back button + Page title
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Add Your Property',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Center(
                  child: Text(
                    'Fill in the details to list your property',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 20),

                // Property Type Dropdown
                const Text('Select Option', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
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
                    hint: Row(
                      children: const [
                        Icon(Icons.home, color: Colors.black54),
                        SizedBox(width: 8),
                        Text('Rent / Sell'),
                      ],
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Rent', child: Text('Rent')),
                      DropdownMenuItem(value: 'Sell', child: Text('Sell')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        propertyType = value;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                const Text('Title', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter the property title',
                    prefixIcon: const Icon(Icons.title),
                  ),
                ),

                const SizedBox(height: 16),

                // Location
                const Text('Location', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Enter the property location',
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                ),

                const SizedBox(height: 16),

                // Price / Beds / Baths row
                Row(
                  children: [
                    Expanded(
                      child: _inputBox('Price', _priceController, icon: Icons.attach_money),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: _counterBox('Beds', beds, _incrementBeds, _decrementBeds)),
                    const SizedBox(width: 8),
                    Expanded(child: _counterBox('Baths', baths, _incrementBaths, _decrementBaths)),
                  ],
                ),

                const SizedBox(height: 16),

                // Description
                const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                TextField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    hintText: 'Describe your property in detail...',
                  ),
                ),

                const SizedBox(height: 16),

                // Upload images
                const Text('Upload Images', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(3, (index) {
                    return Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.add),
                    );
                  }),
                ),

                const SizedBox(height: 24),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitProperty,
                    child: const Text('Submit Property'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputBox(String label, TextEditingController controller, {IconData? icon, String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            hintText: hintText,
            prefixIcon: icon != null ? Icon(icon) : null,
          ),
        ),
      ],
    );
  }

  Widget _counterBox(String label, int value, VoidCallback increment, VoidCallback decrement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey),
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
}