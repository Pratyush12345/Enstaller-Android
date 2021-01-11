import 'package:enstaller/core/enums/view_state.dart';
import 'package:enstaller/core/model/user_model.dart';
import 'package:enstaller/core/provider/base_model.dart';
import 'package:enstaller/core/service/pref_service.dart';

class GetUserDetailsViewModel extends BaseModel{


  UserModel user;
  void getUserDetails()async{
    setState(ViewState.Busy);
    user=await Prefs.getUser();
    print(user.toJson());
    setState(ViewState.Idle);
  }
}