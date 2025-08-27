import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/features/home/domain/model/ConsAllocationModel.dart';
import 'package:mdpe_approve_app/features/home/helper/home_helper.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  HomeBloc() : super(HomeInitialState()){
    on<HomePageLoadedEvent>(_pageLoading);
  }

  List<AllocationData> listOfAllocationData = [];

  _pageLoading(HomePageLoadedEvent event, emit) async {
    emit(HomePageLoadingState());
    listOfAllocationData = [];
    final res = await HomeHelper.contractorAllocation(context: event.context);
    if(res != null && res.data != null){
      listOfAllocationData  =  res.data!;
    }
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<HomeState> emit){
    emit(HomePageLoadedState(listOfAllocationData: listOfAllocationData));
  }
}

