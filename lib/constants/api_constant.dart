//const String kApiUrl = 'http://10.0.2.2:8000/api/v1';
//if you are using android studio emulator, change localhost to 10.0.2.2
import 'package:flutter_login_test_2/models/TagModel.dart';

const String kApiUrl = 'http://192.168.1.2:8000/api/v1';

// AUTHENTICATION SYSTEM
const String kApiRegister = '/register';
const String kApiLogin = '/login';
const String kApiActivateAccount = '/activate_account';
const String kApiLogout = '/logout';

// TAG
const String kApiGetAllTagsByTagTypeId =
    '/tag/get_all_tags_by_type_id?tag_type_id=';
