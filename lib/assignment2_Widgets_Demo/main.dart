import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2 ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const WidgetsDemoPage(),
    );
  }
}

class WidgetsDemoPage extends StatelessWidget {
  const WidgetsDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widgets Demo '),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          const Text(
            'Text Widget Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'This is a basic Text widget displaying content',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),

          const SizedBox(height: 30),
          const Text(
            'Container Widget Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 120,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.indigo.shade100,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.indigo, width: 3),
            ),
            child: const Center(
              child: Text(
                'Styled Container',
                style: TextStyle(fontSize: 18, color: Colors.indigo),
              ),
            ),
          ),

          const SizedBox(height: 30),
          const Text(
            'Row Widget Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 50,
                width: 80,
                color: Colors.purple,
                child: const Center(child: Text('1', style: TextStyle(color: Colors.white))),
              ),
              Container(
                height: 50,
                width: 80,
                color: Colors.teal,
                child: const Center(child: Text('2', style: TextStyle(color: Colors.white))),
              ),
              Container(
                height: 50,
                width: 80,
                color: Colors.amber,
                child: const Center(child: Text('3', style: TextStyle(color: Colors.white))),
              ),
            ],
          ),

         
          const SizedBox(height: 30),
          const Text(
            'Column Widget Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, // changed alignment
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.green.shade300,
                child: const Center(child: Text('Row 1', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(height: 10),
              Container(
                height: 60, // changed height
                width: double.infinity,
                color: Colors.green.shade400,
                child: const Center(child: Text('Row 2', style: TextStyle(color: Colors.white))),
              ),
              const SizedBox(height: 10),
              Container(
                height: 70, // changed height
                width: double.infinity,
                color: Colors.green.shade600,
                child: const Center(child: Text('Row 3', style: TextStyle(color: Colors.white))),
              ),
            ],
          ),

          // SizedBox Widget
          const SizedBox(height: 30),
          const Text(
            'SizedBox Widget Example',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150, // increased height
            child: Container(
              color: Colors.orange.shade100, // changed color
              child: const Center(
                child: Text(
                  'Height changed to 150',
                  style: TextStyle(fontSize: 18, color: Colors.orange),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}