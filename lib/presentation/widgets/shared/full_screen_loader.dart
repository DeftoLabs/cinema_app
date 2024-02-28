import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});



  Stream<String> getLoadingMessage(){

    final messages = <String> [
    'Searching Movies',
    'Buying Pop Corn',
    'Loading Popular',
    'Waiting ... ',
    'Loading Movies',
    'Searching Favorites',
    'Loading .....',
  ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Wait Please'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(height: 10),
          StreamBuilder(
            stream: getLoadingMessage(), 
            builder: (context, snaphot){
              if(!snaphot.hasData) return const Text('Loading ...');

              return Text(snaphot.data!);
            }),
        ],
      ),
    );
  }
}