import 'package:flutter/material.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade200,
      body: const Center(
        child: Text("COMPLETED TAB BAR VIEW"),
      ),
    );
  }
}
