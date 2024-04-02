import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;


String googleMapKey = "AIzaSyC738gHDuDAlZLScE3GjJvwE6YxPaTR4hE";
String serverKeyFCM = "key=AAAAXzK4oGc:APA91bHJdm--WsCgVAU-S8mBjP9i-c8avygnNj5J1JwmScKpaauczs6tHhPX8iD3-C2LLU43iUuEiYJA68fFDf86_KbsYlkGFLbsbFNSFpCT-kIo4KVgMRpdzu36jCEAfvm8e7vSAUm-";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(37.42796133580664, -122.085749655962),
  zoom: 14.4746,
);