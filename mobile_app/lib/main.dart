import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/student.dart'; // ✅ import model

void main() {
  runApp(const MyApp());
}

/* =======================
   APP START
======================= */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home Page'),
    );
  }
}

/* =======================
   HOME PAGE
======================= */
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  late Future<List<Student>> futureStudents;

  @override
  void initState() {
    super.initState();
    futureStudents = fetchStudents();
  }

  /* =======================
     FETCH STUDENTS FROM API
  ======================= */
  Future<List<Student>> fetchStudents() async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/students'),
      // اگر موبایل واقعی است IP سیستم خودت را بگذار
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);
      return jsonData.map((e) => Student.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text('Counter Value:', style: TextStyle(fontSize: 20)),
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text("Increase"),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                onPressed: _decrementCounter,
                child: const Text("Decrease"),
              ),
            ],
          ),

          const Divider(height: 40),

          const Text(
            "Students List",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: FutureBuilder<List<Student>>(
              future: futureStudents,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading students'));
                }

                // ignore: non_constant_identifier_names
                final Student = snapshot.data!;

                return ListView.builder(
                  itemCount: Student.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Text(Student[index].id.toString()),
                      ),
                      title: Text(Student[index].name),
                      subtitle: Text(Student[index].fname),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
