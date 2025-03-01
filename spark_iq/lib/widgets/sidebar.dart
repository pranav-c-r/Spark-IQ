import 'package:flutter/material.dart';
import '../../models/user.dart';

class CustomSidebar extends StatefulWidget {
  final User user;
  final bool isSidebarOpen;
  final Function(bool) onSidebarToggle;
  final Function(String) onMenuItemSelected;

  const CustomSidebar({
    super.key,
    required this.user,
    required this.isSidebarOpen,
    required this.onSidebarToggle,
    required this.onMenuItemSelected,
  });

  @override
  _CustomSidebarState createState() => _CustomSidebarState();
}

class _CustomSidebarState extends State<CustomSidebar> {
  String _selectedMenuItem = 'Profile';

  final List<String> _studentMenuItems = [
    'Profile',
    'Assignment Submission',
    'Personalized Feedback',
    'Attendance Monitoring',
    'Grading Access',
    'Resource Utilization',
    'Gamification Elements',
    'Meeting Participation',
    'Collaboration Tools',
    'Chatbot Access',
    'AI-Generated Questions',
    'Inbox for Suggestions',
    'Chat Functionality'
  ];

  final List<String> _teacherMenuItems = [
    'Profile',
    'Assignment Management',
    'Grading System',
    'Attendance Tracking',
    'Chatbot Interaction',
    'Feedback Provision',
    'Question Generation',
    'Suggestions to Students',
    'Meeting Hosting',
    'Collaboration',
    'Announcements'
  ];

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: widget.isSidebarOpen ? 250 : 80,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xE61D1E33),
              Color(0xE60A0E21),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          children: [
            // Sidebar Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xCC00FFE0),
                    Color(0x6600FFE0),
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 40,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  if (widget.isSidebarOpen)
                    Expanded(
                      child: Text(
                        widget.user.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
              ),
            ),
            // Toggle Button
            IconButton(
              icon: Icon(
                widget.isSidebarOpen ? Icons.chevron_left : Icons.menu,
                color: Colors.white,
              ),
              onPressed: () => widget.onSidebarToggle(!widget.isSidebarOpen),
            ),
            // Menu Items
            Expanded(
              child: ListView.builder(
                itemCount: widget.user.role == 'Student'
                    ? _studentMenuItems.length
                    : _teacherMenuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = widget.user.role == 'Student'
                      ? _studentMenuItems[index]
                      : _teacherMenuItems[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _selectedMenuItem == menuItem
                          ? const Color(0x3300FFE0)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: widget.isSidebarOpen
                        ? ListTile(
                            leading: _getIconForMenuItem(menuItem),
                            title: Text(
                              menuItem,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              setState(() => _selectedMenuItem = menuItem);
                              widget.onMenuItemSelected(menuItem);
                            },
                          )
                        : Center(
                            child: IconButton(
                              icon: _getIconForMenuItem(menuItem),
                              onPressed: () {
                                setState(() => _selectedMenuItem = menuItem);
                                widget.onMenuItemSelected(menuItem);
                              },
                            ),
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon _getIconForMenuItem(String menuItem) {
    switch (menuItem) {
      case 'Profile':
        return const Icon(Icons.account_circle, color: Colors.white);
      case 'Assignment Submission':
      case 'Assignment Management':
        return const Icon(Icons.assignment_turned_in, color: Colors.white);
      // Add all other icon cases as in original code
      default:
        return const Icon(Icons.more_horiz, color: Colors.white);
    }
  }
}