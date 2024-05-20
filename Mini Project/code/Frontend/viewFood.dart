import 'package:pree/provider/loginuid.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:pree/Api_call/apiCall.dart';

class foodPage extends StatefulWidget {
  const foodPage({Key? key}) : super(key: key);

  @override
  State<foodPage> createState() => _foodPageState();
}

class _foodPageState extends State<foodPage> {
  var foodData;



  // Future<List<dynamic>> getod() async {
  //   return apiCall.getFood();
  // }

  getod() async {
  foodData = apiCall.getFood();
}


  @override
  Widget build(BuildContext context) {
    return Consumer<loginuid>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text("Food"),
        ),
        body: FutureBuilder<List<dynamic>>(
          future: getod(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading.."),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              return ListView.builder(
                itemCount: foodData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index]['foodName']),
                      subtitle: Text(
                        'Quantity: ${snapshot.data![index]['quantity']}',
                      ),
                      onTap: () {
                        // Handle card tap
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
