part of 'initial_cubit.dart';

abstract class InitialState {}

//Стэйты для списка Исполнительны производств
class InitialInitial extends InitialState {}

class IpLoading extends InitialState {}

class IpLoaded extends InitialState {
  List<IP> loadedData;
  IpLoaded({@required this.loadedData}) : assert(loadedData != null);
}

class IpError extends InitialState {}

//Стэйты для детальной информации по Исполнительному проиводству
class InitialIpDetail extends InitialState {}

class IpDetailLoading extends InitialState {}

class IpDetailLoaded extends InitialState {
  List<IPDetail> loadedDataIP;
  IpDetailLoaded({@required this.loadedDataIP}) : assert(loadedDataIP != null);
}

class IpDetailError extends InitialState {}

//Стэйты для информации на главном экране
class InitialInfo extends InitialState {}

class InfoLoading extends InitialState {}

class InfoLoaded extends InitialState {
  List<Info> loadedDataInfo;
  InfoLoaded({@required this.loadedDataInfo}) : assert(loadedDataInfo != null);
}

class InfoError extends InitialState {}

//Стэйты для информации на главном экране
class InitialAvto extends InitialState {}

class AvtoLoading extends InitialState {}

class AvtoLoaded extends InitialState {
  List<AvtoList> loadedDataInfo;
  AvtoLoaded({@required this.loadedDataInfo}) : assert(loadedDataInfo != null);
}

class AvtoError extends InitialState {}

//Стэйты для информации на главном экране
class InitialJOW extends InitialState {}

class JOWLoading extends InitialState {}

class JOWLoaded extends InitialState {
  List<JOW> loadedDataInfo;
  JOWLoaded({@required this.loadedDataInfo}) : assert(loadedDataInfo != null);
}

class JOWError extends InitialState {}


//Стэйты для взыскателей 
class InitialClaimant extends InitialState {}

class LoadingClaimant extends InitialState {}

class LoadedClaimant extends InitialState {
  List<Claimant> loadedDataInfo;
  LoadedClaimant({@required this.loadedDataInfo}) : assert(loadedDataInfo != null);
}

class ErrorClaimant extends InitialState {}