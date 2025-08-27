import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class UserApprovalListEvent extends Equatable {}

class UserApprovalListPageLoadEvent extends UserApprovalListEvent {
  final BuildContext context;
  UserApprovalListPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}