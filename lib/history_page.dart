import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  final List<String> history;
  final VoidCallback onClear;
  final bool isDarkMode;

  const HistoryPage({
    super.key,
    required this.history,
    required this.onClear,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isDarkMode ? const Color(0xFF424242) : const Color(0xFFE0E0E0);
    final textColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text('History', style: TextStyle(color: textColor)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: textColor),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: textColor),
            onPressed: () {
              onClear();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              history[index],
              style: TextStyle(color: textColor, fontSize: 20),
              textAlign: TextAlign.right,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          );
        },
      ),
    );
  }
}
