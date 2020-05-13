import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';

const kAppName = 'Quiz Master';

const kSecondsPerQuestion = 5;
const kSecondsBetweenQuestions = 5;
const kMilliInSecond = 1000;
const kMinimumTimePoints = 100;
const kBasePoints = 100;

const kCorrectFeedback = 'תשובה נכונה!';
const kWrongFeedback = 'תשובה שגויה!';

const kAnswersColor = Colors.teal;
const kSelectedAnswerColor = Color(0xffa5a515);

const kMyBlue = Color(0xff3424B0);
const kMyPurple = Color(0xff864EC5);

const kBackgroundGradient = BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: [0.2, 1],
    colors: [
      kMyBlue,
      kMyPurple,
    ],
  ),
);

const kBackgroundPic = BoxDecoration(
  image: DecorationImage(
    image: AssetImage("assets/images/background.jpg"),
    fit: BoxFit.cover,
  ),
);

const kParticleOptionsWhite = ParticleOptions(
  baseColor: Colors.white,
  spawnOpacity: 0.0,
  opacityChangeRate: 0.25,
  minOpacity: 0.1,
  maxOpacity: 0.4,
  spawnMinSpeed: 30.0,
  spawnMaxSpeed: 70.0,
  spawnMinRadius: 7.0,
  spawnMaxRadius: 15.0,
  particleCount: 40,
);

const kParticleOptionsTeal = ParticleOptions(
  baseColor: Colors.teal,
  spawnOpacity: 0.0,
  opacityChangeRate: 0.25,
  minOpacity: 0.1,
  maxOpacity: 0.4,
  spawnMinSpeed: 30.0,
  spawnMaxSpeed: 70.0,
  spawnMinRadius: 7.0,
  spawnMaxRadius: 15.0,
  particleCount: 40,
);