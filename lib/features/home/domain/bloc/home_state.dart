import 'package:equatable/equatable.dart';
import 'package:mdpe_approve_app/features/home/domain/model/ConsAllocationModel.dart';

abstract class HomeState extends Equatable{}

class HomeInitialState extends HomeState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class HomePageLoadingState extends HomeInitialState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class HomePageLoadedState extends HomeInitialState{
  final List<AllocationData> listOfAllocationData;
  HomePageLoadedState({required this.listOfAllocationData});
  @override
  // TODO: implement props
  List<Object?> get props => [listOfAllocationData];
}