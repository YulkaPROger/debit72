import '../../models/avto_list.dart';
import '../../models/ip.dart';
import '../../models/ip_detail.dart';
import '../../models/judicial_order_work.dart';
import '../../models/previous_info.dart';
import '../../services/repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../services/repo.dart';

part 'initial_state.dart';

class InitialCubit extends Cubit<InitialState> {
  final RepositoryIP repository;

  InitialCubit({this.repository}) : super(InitialInitial());

  List<IP> fetchingIP;
  List<AvtoList> fetchingAvtoList;

  Future<void> fetchIP() async {
    try {
      emit(IpLoading());
      final List<IP> _loadedIP = await repository
          .getAllIDFromServer()
          .then((value) => fetchingIP = value);
      emit(IpLoaded(loadedData: _loadedIP));
    } catch (e) {
      print(e);
      emit(IpError());
    }
  }

  void searchListIP({String searchData}) async {
    emit(IpLoading());
    String data = searchData.toLowerCase();

    List<IP> searchIP = List<IP>();

    fetchingIP.forEach((element) {
      if (element.numberID.toLowerCase().contains(data) ||
          element.caseNumber.toLowerCase().contains(data) ||
          element.defendants.toLowerCase().contains(data) ||
          element.claimant.toLowerCase().contains(data) ||
          element.street.toLowerCase().contains(data) ||
          element.house.toLowerCase().contains(data) ||
          element.apartment.toLowerCase().contains(data) ||
          element.bailiff.toLowerCase().contains(data) ||
          element.bailiffDepartment.toLowerCase().contains(data)) {
        searchIP.add(element);
      }
    });

    emit(IpLoaded(loadedData: searchIP));
  }

  Future<void> fetchIPDetail(String numID) async {
    print("## cubit ============ provider.numID");
    print(numID);
    RepositoryIPDetail repositoryIPDetail = RepositoryIPDetail(numberID: numID);
    try {
      emit(IpDetailLoading());
      final List<IPDetail> _loadedIP =
          await repositoryIPDetail.getDetailIpFromID();
      print("## cubit ============ _loadedIP");
      print(_loadedIP);
      print(_loadedIP.runtimeType);
      emit(IpDetailLoaded(loadedDataIP: _loadedIP));
    } catch (e) {
      print(e);
      emit(IpDetailError());
    }
  }

  Future<void> fetchPreviousInfo() async {
    RepositoryInfo repositoryInfo = RepositoryInfo();
    try {
      emit(InfoLoading());
      final List<Info> _loadedInfo = await repositoryInfo.getInfoPevious();
      print("## cubit ============ _loadedInfo");
      print(_loadedInfo);
      print(_loadedInfo.runtimeType);
      emit(InfoLoaded(loadedDataInfo: _loadedInfo));
    } catch (e) {
      print(e);
      emit(InfoError());
    }
  }

  Future<void> fetchAvtoList() async {
    RepositoryAvtoList repositoryAvto = RepositoryAvtoList();
    try {
      emit(AvtoLoading());
      final List<AvtoList> _loadedInfo = await repositoryAvto
          .getAvtoList()
          .then((value) => fetchingAvtoList = value);
      print("## cubit ============ _loadedInfo");
      print(_loadedInfo);
      print(_loadedInfo.runtimeType);
      emit(AvtoLoaded(loadedDataInfo: _loadedInfo));
    } catch (e) {
      print(e);
      emit(AvtoError());
    }
  }

  void searchListAvto({String searchData}) async {
    emit(AvtoLoading());
    String data = searchData.toLowerCase();

    List<AvtoList> searchAvto = List<AvtoList>();

    fetchingAvtoList.forEach((element) {
      if (element.debitor.toLowerCase().contains(data) ||
          element.debitorVehicles.toLowerCase().contains(data) ||
          element.searchString.toLowerCase().contains(data)) {
        searchAvto.add(element);
      }
    });

    emit(AvtoLoaded(loadedDataInfo: searchAvto));
  }

  List<JOW> fetchingJow;

  Future<void> fetchJOWs() async {
    RepositoryJOW repositoryJOW = RepositoryJOW();
    try {
      emit(JOWLoading());
      final List<JOW> _loadedLOW = await repositoryJOW
          .getAllJudicalOrders()
          .then((value) => fetchingJow = value);
      emit(JOWLoaded(loadedDataInfo: _loadedLOW));
    } catch (e) {
      emit(JOWError());
    }
  }

  void searchListJOW({String searchData}) async {
    emit(JOWLoading());

    List<JOW> searchLOW = List<JOW>();
    String data = searchData.toLowerCase();

    fetchingJow.forEach((element) {
      if (element.date.toLowerCase().contains(data) ||
          element.court.toLowerCase().contains(data) ||
          element.hearingCourt.toLowerCase().contains(data) ||
          element.claimant.toLowerCase().contains(data) ||
          element.defendants.toLowerCase().contains(data) ||
          element.street.toLowerCase().contains(data) ||
          element.house.toLowerCase().contains(data) ||
          element.apartment.toLowerCase().contains(data)) {
        searchLOW.add(element);
      }
    });

    emit(JOWLoaded(loadedDataInfo: searchLOW));
  }
}

// bool fetchDataFromIPList(AvtoList element, String searchData) {
//   element.ipList.forEach((el) {
//     if (el.claimant.toLowerCase().contains(searchData)) {
//       return true;
//     } else
//       return false;
//   });
// }
