import 'package:equatable/equatable.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/model/getMdpePmcDataModel.dart';

abstract class UserApprovalListState extends Equatable {}

class UserApprovalListInitialState extends UserApprovalListState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UserApprovalPageLoaderState extends UserApprovalListInitialState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class UserApprovalListDataState extends UserApprovalListState {
  final GetMdpePmcDataModel getMdpePmcDataModel;
  final List<MdpePmcData> listOfMdpePcmData;

  UserApprovalListDataState({
    required this.getMdpePmcDataModel,
    required this.listOfMdpePcmData
  });

  @override
  // TODO: implement props
  List<Object?> get props => [getMdpePmcDataModel, listOfMdpePcmData];
}
