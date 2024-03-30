import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usres_app/methods/common_methods.dart';
import 'package:usres_app/models/prediction_model.dart';
import 'package:usres_app/widgets/prediction_place_ui.dart';

import '../appInfo/app_info.dart';
import '../global/global_var.dart';

class SearchDestinationPage extends StatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  State<SearchDestinationPage> createState() => _SearchDestinationPageState();
}



class _SearchDestinationPageState extends State<SearchDestinationPage>
{
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController destinationTextEditingController = TextEditingController();
  List<PredictionModel> dropOfPredictionsPlacesList = [];

  //Google Places API - Place Autocomplete
  searchLocation(String locationName)async{
    if(locationName.length > 1){
      String apiPlacesUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&key=$googleMapKey&components=country:in";
      var responseFromPlacesAPI = await CommonMethods.sendRequestToAPI(apiPlacesUrl);

      if(responseFromPlacesAPI == "error"){
        return;
      }
      if(responseFromPlacesAPI["status"] == "OK"){
        var predictionResultInJason = responseFromPlacesAPI["predictions"];
        var predictionsList = (predictionResultInJason as List).map((eachPlacePrediction) => PredictionModel.fromJson(eachPlacePrediction)).toList();
        setState(() {
          dropOfPredictionsPlacesList = predictionsList;
        });

        // print("predictionResultInJason = " + predictionResultInJason.toString());

      }
    }
  }

  @override
  Widget build(BuildContext context)
  {

    final appInfo = Provider.of<AppInfo>(context, listen: false);
    String userAddress = appInfo.pickUpLocation?.humanReadableAddress ?? "";
    pickUpTextEditingController.text = userAddress;
    // String userAddress = Provider.of<AppInfo>(context, listen: false).pickUpLocation?.humanReadableAddress ?? "";
    // // String userAddress = Provider.of<AppInfo>(context, listen: false).pickUpLocation!.humanReadableAddress ?? "";
    // pickUpTextEditingController.text = userAddress;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Card(
              elevation: 10,
              child: Container(
                height: 230,
                decoration: const BoxDecoration(
                  color: Colors.black12,
                  boxShadow:
                  [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
                  child: Column(
                    children: [

                      const SizedBox(height: 6,),

                      //icon button - title
                      Stack(
                        children: [

                          GestureDetector(
                            onTap: ()
                            {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back, color: Colors.white,),
                          ),

                          const Center(
                            child: Text(
                              "Set Dropoff Location",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 18,),

                      //pickup text field
                      Row(
                        children: [

                          Image.asset(
                            "assets/images/initial.png",
                            height: 16,
                            width: 16,
                          ),

                          const SizedBox(width: 18,),

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: TextField(
                                  controller: pickUpTextEditingController,
                                  decoration: const InputDecoration(
                                      hintText: "Pickup Address",
                                      fillColor: Colors.white12,
                                      filled: true,
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(left: 11, top: 9, bottom: 9)
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 10,),

                      //destination text field
                      Row(
                        children: [

                          Image.asset(
                            "assets/images/final.png",
                            height: 16,
                            width: 16,
                          ),

                          const SizedBox(width: 18,),

                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: TextField(
                                  controller: destinationTextEditingController,
                                  onChanged: (inputText)
                                  {
                                    searchLocation(inputText);
                                  },
                                  decoration: const InputDecoration(
                                      hintText: "Destination Address",
                                      fillColor: Colors.white12,
                                      filled: true,
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.only(left: 11, top: 9, bottom: 9)
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),

            //display predictions for destination
            (dropOfPredictionsPlacesList.length > 0)
                ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListView.separated(
                    padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index){
                        return Card(
                          elevation: 3,
                          child: PredictionPlaceUI(
                            predictedPlaceData: dropOfPredictionsPlacesList[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) => const SizedBox(
                        height: 2 ),
                      itemCount: dropOfPredictionsPlacesList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                  ),
                )
                : Container()


          ],
        ),
      ),
    );
  }
}
