 import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ApprovalDetailsEvent extends Equatable{}

class ApprovalDetailsPageLoadEvent extends ApprovalDetailsEvent {
  final BuildContext context;
  ApprovalDetailsPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


 class CaptureCameraPhotoEvent extends ApprovalDetailsEvent {
   @override
   // TODO: implement props
   List<Object> get props => [];
 }

 class CaptureGalleryPhotoEvent extends ApprovalDetailsEvent {
   @override
   // TODO: implement props
   List<Object> get props => [];
 }

class PmcApprovalDetailsEvent extends ApprovalDetailsEvent {
  final BuildContext context;
  PmcApprovalDetailsEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [ context];
}

class PmcRejectDetailsEvent extends ApprovalDetailsEvent {
  final BuildContext context;
  PmcRejectDetailsEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}