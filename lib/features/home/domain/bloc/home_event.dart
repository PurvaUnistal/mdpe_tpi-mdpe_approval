 import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

 abstract class HomeEvent extends Equatable{}

 class HomePageLoadedEvent extends HomeEvent{
   final BuildContext context;
   HomePageLoadedEvent({required this.context});
  @override
  // TODO: implement props
  List<Object?> get props => [context];
}