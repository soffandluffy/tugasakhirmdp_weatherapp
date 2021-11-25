import 'package:flutter/material.dart';
import 'package:weatherapp/models/location_model.dart';
import 'package:weatherapp/pages/current_detail_page.dart';
import 'package:weatherapp/providers/location_provider.dart';
import 'package:provider/provider.dart';

class CurrentPage extends StatelessWidget {
  const CurrentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget cityCard(Location location) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CurrentDetailPage(
                  id: location.id,
                ),
              ));
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 24),
          clipBehavior: Clip.antiAlias,
          elevation: 12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.center,
                child: Image.network(
                    'https://st2.depositphotos.com/4806425/9614/v/600/depositphotos_96141284-stock-illustration-vector-watercolor-jakarta-city-illustration.jpg'),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  location.name,
                  style: const TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future<List<Location>> getlocation() async {
      return Provider.of<LocationProvider>(context).getlocation();
    }

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(24),
        alignment: Alignment.center,
        child: Column(
          children: [
            const Text(
              "Weather Today",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Colors.teal),
            ),
            const SizedBox(
              height: 24,
            ),
            FutureBuilder<List<Location>>(
              future: getlocation(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Location>> snapshot) {
                // AsyncSnapshot<Your object type>
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Column(
                      children: snapshot.data!
                          .map((location) => cityCard(location))
                          .toList(),
                    );
                  } // snapshot.data  :- get your object which is pass from your downloadData() function
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
