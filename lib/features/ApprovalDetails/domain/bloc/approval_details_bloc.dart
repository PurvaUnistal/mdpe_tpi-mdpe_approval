import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/GetImage/get_image_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/flutter_toast.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_string.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/text_form_widget.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/helper/approval_details_helper.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/presentation/widget/accpect_reject_pop.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/presentation/user_approval_list_view.dart';

import 'approval_details_event.dart';
import 'approval_details_state.dart';

class ApprovalDetailsBloc
    extends Bloc<ApprovalDetailsEvent, ApprovalDetailsState> {
  ApprovalDetailsBloc() : super(ApprovalDetailsInitialState()) {
    on<ApprovalDetailsPageLoadEvent>(_pageLoad);
    on<CaptureCameraPhotoEvent>(_captureCameraPhoto);
    on<CaptureGalleryPhotoEvent>(_captureGalleryPhoto);
    on<PmcApprovalDetailsEvent>(_submitBtnApproved);
    on<PmcRejectDetailsEvent>(_submitBtnReject);
  }

  bool isPageLoader = false;
  bool isBtnLoader = false;

  File photo = File("");
  final TextEditingController remarksController = TextEditingController();
  final TextEditingController actualLengthController = TextEditingController();

  _pageLoad(ApprovalDetailsPageLoadEvent event, emit) async {
    emit(ApprovalDetailsInitialState());
    isPageLoader = false;
    isBtnLoader = false;
    photo = File("");
    remarksController.text = "";
    actualLengthController.text = await AppConfig.instanceInit()!.mdpePmcData.layingLength ?? "";
    _eventCompleted(emit);
  }

   submit({
    required BuildContext context,
    required String rejectReason,
    required String status,
    required  emit,
  }) async {
    try {
      isBtnLoader = true;
      _eventCompleted(emit);
      final res = await ApprovalDetailsHelper.savePmcApproval(
        context: context,
        layingId: AppConfig.instanceInit()?.mdpePmcData.layingId ?? "",
        actualLength: actualLengthController.text.trim(),
        image: photo.path.toString(),
        status: status,
        remarks: rejectReason,
      );
      if (res != null) {
        isBtnLoader = false;
        _eventCompleted(emit);
       return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => UserApprovalListView()),
              (route) => false,
        );
      }else{
        isBtnLoader = false;
        _eventCompleted(emit);
      }
    } catch (e) {
      isBtnLoader = false;
      _eventCompleted(emit);
      log("savePmcApproval Error: ${e.toString()}");
    }
    return null;
  }



  Widget _buildDialog({
    required BuildContext context,
    required Widget content,
    required VoidCallback onConfirm,
  }) {
    return CupertinoAlertDialogWidget(
      content: content,
      child: isBtnLoader
          ? DottedLoaderWidget()
          : TextButton(
        child: Text("Yes"),
        onPressed: onConfirm,
      ),
    );
  }
  _captureCameraPhoto(CaptureCameraPhotoEvent event, emit) async {
    var photoPath = await GetImageWidget.cameraCapture();
    log("photo-->$photoPath");
    if (photoPath?.path != null) {
      photo = photoPath!;
    }
    _eventCompleted(emit);
  }

  _captureGalleryPhoto(CaptureGalleryPhotoEvent event, emit) async {
    var photoPath = await GetImageWidget.galleryCapture();
    log("photo-->$photoPath");
    if (photoPath.path.isNotEmpty) {
      photo = photoPath;
    }
    _eventCompleted(emit);
  }

  Future _submitBtnApproved(PmcApprovalDetailsEvent event, Emitter emit) {
    return showCupertinoDialog(
      context: event.context,
      builder: (context) {
        return BlocBuilder<ApprovalDetailsBloc, ApprovalDetailsState>(
          builder: (context, state) {
            if (state is ApprovalDetailsDataState) {
              return _buildDialog(
                context: context,
                content: SizedBox.shrink(),
                onConfirm: () => submit(
                  context: event.context,
                  rejectReason: "",
                  status: "1",
                  emit: emit,
                ),
              );
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }

  Future _submitBtnReject(PmcRejectDetailsEvent event, Emitter emit) {
    remarksController.clear();
    return showCupertinoDialog(
      context: event.context,
      builder: (context) {
        return BlocBuilder<ApprovalDetailsBloc, ApprovalDetailsState>(
          builder: (context, state) {
            if (state is ApprovalDetailsDataState) {
              return _buildDialog(
                context: context,
                content: TextFieldWidget(
                  star: AppString.star,
                  label: AppString.remarks,
                  hintText: AppString.remarks,
                  controller: remarksController,
                ),
                onConfirm: () {
                  final remarks = remarksController.text.trim();
                  if (remarks.isEmpty) {
                    UtilsToast.errorSnackBar(
                      msg: "This Remark is required",
                      context: event.context,
                    );
                  } else {
                    submit(
                      context: event.context,
                      rejectReason: remarks,
                      status: "2",
                      emit: emit,
                    );
                  }
                },
              );
            }
            return SizedBox.shrink();
          },
        );
      },
    );
  }


  _eventCompleted(Emitter<ApprovalDetailsState> emit) {
    emit(ApprovalDetailsDataState(
      isBtnLoader: isBtnLoader,
      photo: photo,
      actualLengthController: actualLengthController,
      remarksController: remarksController,
    ));
  }
}
