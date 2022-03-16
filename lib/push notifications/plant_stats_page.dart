import 'package:flutter/material.dart';
import 'package:push_notifications_with_awesome_notifications/push%20notifications/widgets.dart';

class PlantStatsPage extends StatelessWidget {
  const PlantStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Plant Stats',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(height: 45),
              const PlantImage(),
              const SizedBox(height: 25),
              const PlantStats(),
            ],
          ),
        ),
      ),
    );
  }
}
