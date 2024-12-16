import 'package:farm_easy/Constants/color_constants.dart';
import 'package:farm_easy/Screens/LandSection/LandDetails/Info/Controller/land_weather_controller.dart';
import 'package:farm_easy/Screens/WeatherScreen/Controller/current_weather_controller.dart';
import 'package:farm_easy/Screens/WeatherScreen/Controller/wether_forecast_cont.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.lat, required this.long});
  final double lat;
  final double long;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final currentWeather= Get.put(LandWeatherController());
  final forecastController= Get.put(WeatherForecastController());

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentWeather.currentWeather(widget.lat, widget.long);
    forecastController.weatherForecastData(widget.lat, widget.long);
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.BACKGROUND,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.09),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColor.DARK_GREEN,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 60, left: 10, right: 30),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    )),
                Text(
                  '            Weather Forecast',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
              ],
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          currentWeather.currentWeather(widget.lat, widget.long);
          forecastController.weatherForecastData(widget.lat, widget.long);
        },
        child: SingleChildScrollView(
          child: Obx(() {
            return currentWeather.loading.value?Center(child: CircularProgressIndicator(),):
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on_outlined,color: AppColor.BROWN_TEXT,),
                      Text(
                        '${currentWeather.currentWeatherData.value.name??""}',
                        style: GoogleFonts.poppins(
                          color: AppColor.BROWN_TEXT,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    // IconButton(onPressed: (){}, icon: Icon(Icons.keyboard_arrow_down_rounded,size:35,),)
                    ],
                  ),
                  Container(
                    height: Get.height*0.08,
                    width: Get.width*0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage("http://openweathermap.org/img/wn/${currentWeather.currentWeatherData.value.weather?[0].icon}.png"),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  Text(
                    '${currentWeather.currentWeatherData.value.main?.feelsLike?.toInt()}º',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF483C32),
                      fontSize: 40,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Text(
                    '${currentWeather.currentWeatherData.value.weather?[0].main}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF483C32),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0,
                    ),
                  ),
                  Obx(() {
                    return  Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Min: ${currentWeather.currentWeatherData.value.main?.tempMin?.toInt()}º / Max: ${currentWeather.currentWeatherData.value.main?.tempMax?.toInt()}º',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF483C32),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: AppColor.PRIMARY_GRADIENT
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/img/rain.svg",width: 30,),
                            Text(
                              '  ${currentWeather.currentWeatherData.value.clouds?.all??"0"}%',
                              style: GoogleFonts.poppins(
                                color: AppColor.BROWN_TEXT,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/img/humidity.svg",width: 30,),
                            Text(
                              '  ${currentWeather.currentWeatherData.value.main?.humidity??"0"}%',
                              style: GoogleFonts.poppins(
                                color: AppColor.BROWN_TEXT,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/img/wind.svg",width: 30,),
                            Text(
                              '   ${currentWeather.currentWeatherData.value.wind?.speed??"5"}km/hr',
                              style: GoogleFonts.poppins(
                                color: AppColor.BROWN_TEXT,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  //   padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       gradient: AppColor.PRIMARY_GRADIENT
                  //   ),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //         children: [
                  //           Text(
                  //             'Today',
                  //             style: TextStyle(
                  //               color: Color(0xFF483C32),
                  //               fontSize: 20,
                  //               fontFamily: 'Poppins',
                  //               fontWeight: FontWeight.w600,
                  //               height: 0,
                  //             ),
                  //           ),
                  //           Text(
                  //             'Dec, 9',
                  //             textAlign: TextAlign.right,
                  //             style: TextStyle(
                  //               color: Color(0xFF483C32),
                  //               fontSize: 18,
                  //               fontFamily: 'Poppins',
                  //               fontWeight: FontWeight.w400,
                  //               height: 0,
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //       Container(
                  //         height:Get.height*0.17,
                  //         width: double.infinity,
                  //         margin: EdgeInsets.symmetric(vertical: 12),
                  //         child: ListView.builder(
                  //             itemCount: 6,
                  //             shrinkWrap: true,
                  //             scrollDirection: Axis.horizontal,
                  //             itemBuilder: (context, index){
                  //               return  Container(
                  //                 margin: EdgeInsets.symmetric(horizontal: 10,),
                  //                 child: Column(
                  //                   crossAxisAlignment: CrossAxisAlignment.center,
                  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //                   children: [
                  //                     Text(
                  //                       '24°C',
                  //                       style: TextStyle(
                  //                         color: Color(0xFF483C32),
                  //                         fontSize: 14,
                  //                         fontFamily: 'Poppins',
                  //                         fontWeight: FontWeight.w400,
                  //                         height: 0,
                  //                       ),
                  //                     ),
                  //                     Container(
                  //                       margin: EdgeInsets.symmetric(vertical: 10),
                  //                       height: 30,
                  //                       width: 30,
                  //                       color: Colors.black,
                  //                     ),
                  //                     Text(
                  //                       '15:00',
                  //                       style: TextStyle(
                  //                         color: Color(0xFF483C32),
                  //                         fontSize: 14,
                  //                         fontFamily: 'Poppins',
                  //                         fontWeight: FontWeight.w400,
                  //                         height: 0,
                  //                       ),
                  //                     )
                  //                   ],
                  //                 ),
                  //               );
                  //             }),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: AppColor.PRIMARY_GRADIENT
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Next Forecast',
                              style: TextStyle(
                                color: Color(0xFF483C32),
                                fontSize: 20,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            Icon(Icons.calendar_month_sharp,color: AppColor.BROWN_TEXT,size: 30,)
                          ],
                        ),
                        Container(
                          height: Get.height * 0.48,
                          child: Obx(() {
                            return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: forecastController.weatherForecast.value.listWeather?.length ?? 0,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                final dayAndDateList = forecastController.convertUnixTimestampToDayAndDate();
                                final day = dayAndDateList.isNotEmpty ? dayAndDateList[index]['day'] ?? '' : '';
                                final date = dayAndDateList.isNotEmpty ? dayAndDateList[index]['date'] ?? '' : '';
                                final tempDay = forecastController.weatherForecast.value.listWeather?[index].temp?.day ?? 0;
                                final tempNight = forecastController.weatherForecast.value.listWeather?[index].temp?.night ?? 0;
                                final weatherIcon = forecastController.weatherForecast.value.listWeather?[index].weather?[0].icon ?? '';
                                return Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '$day, $date',
                                        style: TextStyle(
                                          color: Color(0xFF483C32),
                                          fontSize: 14,
                                          fontFamily: 'Alegreya Sans',
                                          fontWeight: FontWeight.w700,
                                          height: 0,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                "http://openweathermap.org/img/wn/$weatherIcon.png"
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${tempDay.toInt()}°', // Display day temperature
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFF483C32),
                                              fontSize: 18,
                                              fontFamily: 'Alegreya Sans',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          ),
                                          Text(
                                            '  ${tempNight.toInt()}°', // Display night temperature
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0x99483C32),
                                              fontSize: 18,
                                              fontFamily: 'Alegreya Sans',
                                              fontWeight: FontWeight.w500,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          }),
                        )

                      ],
                    ),
                  )

                ]);
          })
        ),
      ),
    );
  }
}
