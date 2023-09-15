import 'package:cod6_watherapp/models/city.dart';
import 'package:cod6_watherapp/services/api_services.dart';
import 'package:cod6_watherapp/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _cityController = TextEditingController();

  City? city;
  City? cityTemp;
  bool isLoading = false;
  final formkey = GlobalKey<FormState>();

  Future<void> getData(String cityName) async {
    ApiServices apiServices = ApiServices();
    isLoading = true;
    city = await apiServices.getWeatherData(cityName);
    if (city == null) {
      city = cityTemp;
      isLoading = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
          content: const Text("Hubo un inconveniente, intenta con otra ciudad"),
        ),
      );
    } else {
      cityTemp = city;
      _cityController.clear();
      isLoading = false;
      setState(() {});
    }
  }

  Future<void> getDataLocation() async {
    ApiServices apiServices = ApiServices();
    isLoading = true;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    city = await apiServices.getWeatherLocation(
        position.latitude, position.longitude);
    if (city != null) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getDataLocation().then((value) => {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xff282B30),
      appBar: AppBar(
        title: const Text("WeatherApp"),
        centerTitle: true,
        backgroundColor: const Color(0xff282B30),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              getDataLocation();
            },
            icon: const Icon(Icons.location_on_outlined),
          )
        ],
      ),
      body: isLoading == true && city == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: formkey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(
                      "https://cdn4.iconfinder.com/data/icons/weather-129/64/weather-2-512.png",
                      color: Colors.white,
                      height: 65,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          city?.current.tempC.toString() ?? "no value",
                          style: TextStyle(
                            fontSize: height * 0.15,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          " °C",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white54,
                          ),
                        ),

                        // Text(
                        //   city!.location.country,
                        //   style: const TextStyle(color: Colors.white),
                        // )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${city!.location.name}, ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          city!.location.country,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _cityController,
                      cursorColor: Colors.orange,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Ingresa ciudad",
                        fillColor: Colors.white.withOpacity(0.08),
                        hintStyle: TextStyle(
                          color: Colors.white54,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      validator: (String? value) {
                        if (value != null && value.isEmpty) {
                          return "El campo es obligatorio";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          print(_cityController.text);
                          if (formkey.currentState!.validate()) {
                            String cityName = _cityController.text;
                            getData(cityName);
                          }
                        },
                        child: Text("Buscar"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          ForeCastWidget(),
                          ForeCastWidget(),
                          ForeCastWidget(),
                          ForeCastWidget(),
                          ForeCastWidget(),
                          ForeCastWidget(),
                          ForeCastWidget(),
                          ForeCastWidget(),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
