import 'package:geocoder/geocoder.dart';

class GeoLocationService{

  static Future getAddressFromPinCode(String pinCode)async{
    return Geocoder.local.findAddressesFromQuery(pinCode);

  }
  static Future<List<Address>> getAddFromLatLong(double lat,double lng){
    return  Geocoder.local.findAddressesFromCoordinates(Coordinates(lat, lng));
  }


}