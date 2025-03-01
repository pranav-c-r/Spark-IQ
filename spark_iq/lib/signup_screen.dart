import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // For date formatting
import 'screens/profile_screen.dart';    // Import the ProfileScreen
import 'models/user.dart';               // Import the User model

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedRole;
  String? _selectedSubject;
  String? _selectedBatch;

  final List<String> _subjects = ['Math', 'Science', 'English', 'History'];
  final List<String> _batches = ['2023', '2024', '2025', '2026'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E21),
              Color(0xFF1D1E33),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('Full Name', Icons.person, _fullNameController),
                  const SizedBox(height: 20),
                  _buildDatePicker(),
                  const SizedBox(height: 20),
                  _buildTextField('Email', Icons.email, _emailController),
                  const SizedBox(height: 20),
                  _buildPasswordField('Password', _passwordController),
                  const SizedBox(height: 20),
                  _buildPasswordField('Confirm Password', null),
                  const SizedBox(height: 20),
                  _buildTextField('Phone Number', Icons.phone, _phoneController),
                  const SizedBox(height: 20),
                  _buildTextField('Address', Icons.location_on, _addressController),
                  const SizedBox(height: 20),
                  _buildRoleDropdown(),
                  const SizedBox(height: 20),
                  if (_selectedRole == 'Teacher') _buildSubjectDropdown(),
                  if (_selectedRole == 'Student') _buildBatchDropdown(),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF00FFE0),
                      ),
                      onPressed: _submitForm,
                      child: const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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

  Widget _buildTextField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFE0), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField(String label, TextEditingController? controller) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFE0), width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        if (label == 'Confirm Password' && value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  Widget _buildDatePicker() {
    return TextFormField(
      controller: _dobController,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: 'Date of Birth',
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFE0), width: 2),
        ),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: Color(0xFF00FFE0),
                  onPrimary: Colors.black,
                  surface: Color(0xFF1D1E33),
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: const Color(0xFF0A0E21),
              ),
              child: child!,
            );
          },
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
            _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
          });
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select Date of Birth';
        }
        return null;
      },
    );
  }

  Widget _buildRoleDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedRole,
      dropdownColor: Colors.grey[900],
      decoration: InputDecoration(
        labelText: 'Role',
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.group, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFE0), width: 2),
        ),
      ),
      items: ['Student', 'Teacher']
          .map<DropdownMenuItem<String>>((String role) {
        return DropdownMenuItem<String>(
          value: role,
          child: Text(role, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedRole = value;
        });
      },
      validator: (value) => value == null ? 'Please select role' : null,
    );
  }

  Widget _buildSubjectDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedSubject,
      dropdownColor: Colors.grey[900],
      decoration: InputDecoration(
        labelText: 'Subject',
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.book, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFE0), width: 2),
        ),
      ),
      items: _subjects
          .map<DropdownMenuItem<String>>((String subject) {
        return DropdownMenuItem<String>(
          value: subject,
          child: Text(subject, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedSubject = value;
        });
      },
      validator: (value) => value == null ? 'Please select subject' : null,
    );
  }

  Widget _buildBatchDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedBatch,
      dropdownColor: Colors.grey[900],
      decoration: InputDecoration(
        labelText: 'Batch',
        labelStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.school, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[900],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF00FFE0), width: 2),
        ),
      ),
      items: _batches
          .map<DropdownMenuItem<String>>((String batch) {
        return DropdownMenuItem<String>(
          value: batch,
          child: Text(batch, style: const TextStyle(color: Colors.white)),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          _selectedBatch = value;
        });
      },
      validator: (value) => value == null ? 'Please select batch' : null,
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create User object from form data
      User newUser = User(
        fullName: _fullNameController.text,
        email: _emailController.text,
        role: _selectedRole!,
        subject: _selectedSubject,
        batch: _selectedBatch,
        phone: _phoneController.text,
        address: _addressController.text,
        dob: _selectedDate!,
      );

      // Navigate to ProfileScreen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileScreen(user: newUser),
        ),
      );
    }
  }
}