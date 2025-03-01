import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/user.dart';
import '../widgets/sidebar.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isSidebarOpen = true;
  bool _isEditing = false;
  String _selectedMenuItem = 'Profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() => _isEditing = !_isEditing),
        backgroundColor: const Color(0xFF00FFE0),
        child: Icon(
          _isEditing ? Icons.save : Icons.edit,
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          // Main Content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(left: _isSidebarOpen ? 250 : 80),
            child: Container(
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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      _selectedMenuItem,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    if (_selectedMenuItem == 'Profile') _buildProfileContent(),
                  ],
                ),
              ),
            ),
          ),
          // Sidebar
          CustomSidebar(
            user: widget.user,
            isSidebarOpen: _isSidebarOpen,
            onSidebarToggle: (isOpen) => setState(() => _isSidebarOpen = isOpen),
            onMenuItemSelected: (menuItem) => setState(() {
              _selectedMenuItem = menuItem;
              _navigateToScreen(menuItem);
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildProfileInfoItem('Full Name', widget.user.fullName),
        _buildProfileInfoItem('Email', widget.user.email),
        _buildProfileInfoItem('Role', widget.user.role),
        if (widget.user.role == 'Teacher')
          _buildProfileInfoItem('Subject', widget.user.subject ?? ''),
        if (widget.user.role == 'Student')
          _buildProfileInfoItem('Batch', widget.user.batch ?? ''),
        _buildProfileInfoItem('Phone', widget.user.phone),
        _buildProfileInfoItem('Address', widget.user.address),
        _buildProfileInfoItem(
          'Date of Birth',
          DateFormat('yyyy-MM-dd').format(widget.user.dob),
        ),
        if (_isEditing) _buildEditButton(),
      ],
    );
  }

  Widget _buildProfileInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildEditButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            // Implement edit functionality
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color(0xFF00FFE0),
          ),
          child: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToScreen(String menuItem) {
    switch (menuItem) {
      case 'Profile':
        break;
      case 'Assignment Submission':
        Navigator.pushNamed(context, '/assignments');
        break;
      case 'Assignment Management':
        Navigator.pushNamed(context, '/assignment-management');
        break;
    }
  }
}