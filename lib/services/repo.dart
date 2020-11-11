import '../models/avto_list.dart';
import '../models/ip.dart';
import '../models/judicial_order_work.dart';
import '../models/ip_detail.dart';
import '../models/previous_info.dart';

import '../services/api.dart';

class Repository {
  Api _providerApi = Api();
}

class RepositoryIP extends Repository {
  Future<List<IP>> getAllIDFromServer() => _providerApi.getAllID();
  Future<List<IP>> getAllIDFromJSON() => _providerApi.getAllIDfromJSON();
}

class RepositoryIPDetail extends Repository {
  final String numberID;

  RepositoryIPDetail({this.numberID});
  Future<List<IPDetail>> getDetailIpFromID() =>
      _providerApi.getDetailIPData(number: numberID);
}

class RepositoryJOW extends Repository {
  Future<List<JOW>> getAllJudicalOrders() => _providerApi.getJudicalOrderWork();
}

class RepositoryInfo extends Repository {
  Future<List<Info>> getInfoPevious() => _providerApi.getPreviusInfo();
}

class RepositoryAvtoList extends Repository {
  Future<List<AvtoList>> getAvtoList() => _providerApi.getAvtoList();
}
