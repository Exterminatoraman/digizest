import 'package:flutter/material.dart';
import 'api.dart';
void main() {
  runApp(const MyApp());
}
List a=[];
String loc="chennai";
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'This is a weather app'
          ''),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purple.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white54),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              loc=value;

            });



            // Perform search functionality here
          },
        ),
      ),





      body:FutureBuilder<Map<String, dynamic>>(
    future: fetchWeatherData("$loc"),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    } else if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
    } else {
    final jsonData = snapshot.data;

    final temperature = jsonData!['current']['temp_c'];
    final description = jsonData['current']['temp_f'];
    final location = jsonData['location']['name'];
    String link='https:'+jsonData!['current']['condition']['icon'];
    return Column(
    children: [
      Center(child: Image.network(link)),
      Center(child: Text('location: $location')),
      Text('Temperature: $temperature'+" °C"),
    Text('Description: $description'),],);
    };}
    ),);
  }
}
