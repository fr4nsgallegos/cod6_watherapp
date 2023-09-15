import 'package:cod6_watherapp/models/city.dart';
import 'package:cod6_watherapp/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForeCastWidget extends StatefulWidget {
  const ForeCastWidget({super.key});

  @override
  State<ForeCastWidget> createState() => _ForeCastWidgetState();
}

class _ForeCastWidgetState extends State<ForeCastWidget> {
  @override
  Widget build(BuildContext context) {
    // ApiServices apiServices = ApiServices();
    // apiServices.getWeatherData();
    return Container(
      margin: const EdgeInsets.only(right: 15, bottom: 15),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
      decoration: BoxDecoration(
          boxShadow: [
            const BoxShadow(
              color: Colors.black,
              // spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(4, 8),
            )
          ],
          // color: Colors.orange,
          color: const Color(0xff3E4145),
          borderRadius: BorderRadius.circular(30)),
      child: const Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "1 AM",
            style: TextStyle(
              color: Colors.white60,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Icon(
            Icons.cloud_outlined,
            color: Colors.white,
            size: 35,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "18 °C",
            style: TextStyle(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }
}
