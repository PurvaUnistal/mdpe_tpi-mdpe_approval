import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/background_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/button_red_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/button_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/enlarge_widge.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/image_pop_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/image_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_string.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/row_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/text_form_widget.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/domain/bloc/approval_details_bloc.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/domain/bloc/approval_details_event.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/domain/bloc/approval_details_state.dart';

class ApprovalDetailsView extends StatefulWidget {
  const ApprovalDetailsView({super.key});

  @override
  State<ApprovalDetailsView> createState() => _ApprovalDetailsViewState();
}

class _ApprovalDetailsViewState extends State<ApprovalDetailsView> {
  @override
  void initState() {
    BlocProvider.of<ApprovalDetailsBloc>(
      context,
    ).add(ApprovalDetailsPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(title: AppString.mdpeApp, boolLeading: true),
      body: SafeArea(
        child: BlocBuilder<ApprovalDetailsBloc, ApprovalDetailsState>(
          builder: (context, state) {
            if (state is ApprovalDetailsDataState) {
              return BackgroundWidget(child: _buildLayout(dataState: state));
            } else {
              return const Center(child: SpinLoader());
            }
          },
        ),
      ),
    );
  }

  Widget _buildLayout({required ApprovalDetailsDataState dataState}) {
    final getMdpePmcData = AppConfig.instanceInit()?.mdpePmcData;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          TextFieldWidget(
            label: "MDPE Line ID",
            hintText: "MDPE Line ID",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData!.lineid ?? "NA",
            ),
          ),
          _vertical(),
          TextFieldWidget(
            label: "Laying Date",
            hintText:"Laying Date",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData.layingDate ?? "NA",
            ),
          ),
          _vertical(),
          TextFieldWidget(
            label: "Area Name",
            hintText: "Area Name",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData.areaName ?? "NA",
            ),
          ),
          _vertical(),
          TextFieldWidget(
            label: "Road Owner",
            hintText: "Road Owner",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData.roadOwner ?? "NA",
            ),
          ),
          _vertical(),
          TextFieldWidget(
            label: "Pipe Side",
            hintText: "Pipe Side",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData.pipeSide ?? "NA",
            ),
          ),
          _vertical(),
          TextFieldWidget(
            label: "Dia",
            hintText:  "Dia",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData.diameter ?? "NA",
            ),
          ),
          _vertical(),
          TextFieldWidget(
            label: "Method",
            hintText:  "Method",
            enabled: false,
            controller: TextEditingController(
              text: getMdpePmcData.method ?? "NA",
            ),
          ),
          _vertical(),
          Row(
            children: [
              Flexible(
                child: TextFieldWidget(
                  label: "Latitude",
                  hintText:"Latitude",
                  enabled: false,
                  controller: TextEditingController(
                    text: getMdpePmcData.latitude ?? "NA",
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Flexible(
                child: TextFieldWidget(
                  label: "Longitude",
                  hintText:"Longitude",
                  enabled: false,
                  controller: TextEditingController(
                    text: getMdpePmcData.longitude ?? "NA",
                  )
                ),
              ),
            ],
          ),

          _vertical(),
          TextFieldWidget(
            label: "Actual Length",
            hintText: "Actual Length",
            controller: dataState.actualLengthController,
          ),
          _vertical(),
          imageWidget(dataState: dataState),
          _vertical(),
          _vertical(),
          _submitWidget(),
        ],
      ),
    );
  }

  Widget imageWidget({required ApprovalDetailsDataState dataState}) {
    final size = MediaQuery.of(context).size;
    final graphPhoto = AppConfig.instanceInit()?.mdpePmcData.graphPhoto;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ImageWidget(
          star: AppString.star,
          title: "Photo",
          imgFile: dataState.photo,
          onPressed: () {
            showModalBottomSheet(
              enableDrag: true,
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return ImagePopWidget(
                  onTapCamera: () async {
                    Navigator.of(context).pop();
                    BlocProvider.of<ApprovalDetailsBloc>(
                      context,
                    ).add(CaptureCameraPhotoEvent());
                  },
                  onTapGallery: () async {
                    Navigator.of(context).pop();
                    BlocProvider.of<ApprovalDetailsBloc>(
                      context,
                    ).add(CaptureGalleryPhotoEvent());
                  },
                );
              },
            );
          },
        ),

        InkWell(
          onTap: () {
            if (graphPhoto != null && graphPhoto.isNotEmpty) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.zero, // removes radius
                  ),
                ),
                builder: (_) => EnlargeWidget(
                  text: "Photo",
                  photoPath: File(graphPhoto), // safe null check
                ),
              );
            }
          },
          child: (graphPhoto == null || graphPhoto.isEmpty)
              ? const Icon(Icons.broken_image, size: 40, color: Colors.grey)
              : Image.network(
            graphPhoto,
            fit: BoxFit.fill,
            width: size.width * 0.23,
            height: size.height * 0.12,
            errorBuilder: (_, __, ___) =>
            const Icon(Icons.broken_image, size: 40, color: Colors.red),
          ),
        )



      ],
    );
  }

  Widget _submitWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: ButtonWidget(
            text: "Approval",
            onPressed: () {
              BlocProvider.of<ApprovalDetailsBloc>(
                context,
              ).add(PmcApprovalDetailsEvent(context: context));
            },
          ),
        ),
        Flexible(
          child: ButtonRedWidget(
            text: "Reject",
            onPressed: () {
              BlocProvider.of<ApprovalDetailsBloc>(
                context,
              ).add(PmcRejectDetailsEvent(context: context));
            },
          ),
        ),
      ],
    );
  }

  _vertical() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.009);
  }
}
