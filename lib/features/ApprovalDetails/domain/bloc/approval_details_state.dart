import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ApprovalDetailsState extends Equatable {}

class ApprovalDetailsInitialState extends ApprovalDetailsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ApprovalDetailsDataState extends ApprovalDetailsState {
  final bool isBtnLoader;
  final File photo;
  final TextEditingController actualLengthController;
  final TextEditingController remarksController;

  ApprovalDetailsDataState(
      {required this.isBtnLoader,
        required this.photo,
        required this.actualLengthController,
        required this.remarksController});

  @override
  // TODO: implement props
  List<Object?> get props => [isBtnLoader,photo, actualLengthController,remarksController];
}
