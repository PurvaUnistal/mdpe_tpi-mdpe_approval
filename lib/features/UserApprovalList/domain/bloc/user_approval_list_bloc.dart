import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/bloc/user_approval_list_event.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/bloc/user_approval_list_state.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/model/getMdpePmcDataModel.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/helper/user_approval_list_helper.dart';

class UserApprovalListBloc extends Bloc<UserApprovalListEvent, UserApprovalListState> {
  UserApprovalListBloc() : super(UserApprovalListInitialState()) {
    on<UserApprovalListPageLoadEvent>(_pageLoad);
  }

  bool pageLoader = false;

  GetMdpePmcDataModel getMdpePmcDataModel = GetMdpePmcDataModel();
  List<MdpePmcData> listOfMdpePcmData = [];

  _pageLoad(UserApprovalListPageLoadEvent event, emit) async {
    emit(UserApprovalPageLoaderState());
    pageLoader = false;
    getMdpePmcDataModel = GetMdpePmcDataModel();
    listOfMdpePcmData = [];
    await fetchMdpeApprovalList(context: event.context);
    _eventCompleted(emit);
  }

  fetchMdpeApprovalList({required BuildContext context}) async {
    var res = await UserApprovalListHelper.mdpeApprovalList(context: context);
    if (res != null) {
      getMdpePmcDataModel = res;
      if (getMdpePmcDataModel.data != null) {
        listOfMdpePcmData = getMdpePmcDataModel.data!;
      }
      return res;
    }
  }

  _eventCompleted(Emitter<UserApprovalListState> emit) {
    emit(UserApprovalListDataState(
      getMdpePmcDataModel: getMdpePmcDataModel,
      listOfMdpePcmData: listOfMdpePcmData,
    ));
  }
}
