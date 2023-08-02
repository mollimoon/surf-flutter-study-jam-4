import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/data/get_prediction.dart';

import '../data/repository.dart';

class MagicBallScreen extends StatefulWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  State<MagicBallScreen> createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  final _infoRepository = InfoRepository();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xff0e0b28),
          body: Column(
            children: [
              Flexible(
                child: Stack(
                  children: <Widget>[
                    FutureBuilder<Prediction>(
                      future: _infoRepository.getPrediction(),
                      builder: (_, snapshot) {
                        String imageChoice;
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          imageChoice = 'assets/images/ball_main.png';
                        } else if (snapshot.hasError) {
                          imageChoice = 'assets/images/ball_error.png';
                        } else {
                          imageChoice = 'assets/images/ball_text.png';
                        }
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _infoRepository.getPrediction();
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imageChoice),
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Center(
                      child: FutureBuilder<Prediction>(
                        future: _infoRepository.getPrediction(),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                            final items = snapshot.data;
                            return Text(
                              items!.title,
                              style: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                              ),
                            );
                          } else if (snapshot.connectionState == ConnectionState.waiting) {
                            // здесь не нужно показывать индикатор прогресса, так как у нас есть кастомное изображение для загрузки
                            return Container();
                          }
                          if (snapshot.hasError) {
                            return const Text('');
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset('assets/images/ball_shadow.png'),
              const SizedBox(height: 30),
              const Text(
                'Нажмите на шар\nили потрясите телефон',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
            ],
          )),
    );
  }
}
