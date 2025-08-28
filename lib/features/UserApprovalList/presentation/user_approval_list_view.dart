import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/background_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_string.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/text_form_widget.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/presentation/approval_details_view.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/bloc/user_approval_list_bloc.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/bloc/user_approval_list_event.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/bloc/user_approval_list_state.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/presentation/widgets/logout_widget.dart';

class UserApprovalListView extends StatefulWidget {
  const UserApprovalListView({super.key});

  @override
  State<UserApprovalListView> createState() => _UserApprovalListViewState();
}

class _UserApprovalListViewState extends State<UserApprovalListView> {
  @override
  void initState() {
    BlocProvider.of<UserApprovalListBloc>(context)
        .add(UserApprovalListPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(
        title: AppString.mdpeApp,
        boolLeading: true,

      ),
      body: SafeArea(
        child: BlocBuilder<UserApprovalListBloc, UserApprovalListState>(
          builder: (context, state) {
            if (state is UserApprovalListDataState) {
              return BackgroundWidget(child: _buildLayout(dataState: state));
            } else {
              return const Center(
                child: SpinLoader(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildLayout({required UserApprovalListDataState dataState}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _searchLindId(dataState: dataState),
          _vertical(),
          _listOfLineId(dataState: dataState),
        ],
      ),
    );
  }

  Widget _searchLindId({required UserApprovalListDataState dataState}) {
    return TextFieldWidget(
      label: "Search Line ID...",
      hintText: "Search Line ID...",
      controller: TextEditingController(),
    );
  }

  int? selectedValue;

  Widget _listOfLineId({required UserApprovalListDataState dataState}) {
    return Flexible(
      child: ListView.builder(
          itemCount: dataState.listOfMdpePcmData.length,
          itemBuilder: (BuildContext context, int i) {
            final data = dataState.listOfMdpePcmData[i];
            return InkWell(
              onTap: () async {
                await AppConfig.instanceInit()?.setMdpePmcData(
                    newMdpePmcData: dataState.listOfMdpePcmData[i]);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ApprovalDetailsView()));
              },
              child: Card(
                shadowColor: Colors.green,
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.username ?? "",
                                style: TextStyle(
                                    fontSize: 16, color: AppColor.primer),
                              ),
                            ],
                          ),
                          _row(
                              title: "Status",
                              fontSize: 16,
                              color: statusColor[data.pmcApprovalSta],
                              subtitle: statusMap[data.pmcApprovalSta] ?? ""),
                        ],
                      ),
                      _row(title: "Line ID", subtitle: data.mdpeid ?? ""),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  final statusMap = {
    "2": "Reject",
    "": "New",
    "1": "Approval",
  };
  final statusColor = {
    "2": Colors.red,
    "": Colors.yellow.shade800
    ,
    "1": Colors.green,
  };

  Widget _row({required String title, required String subtitle, Color? color,double? fontSize }) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(
            "${title} : ",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: fontSize ?? 14, color: color),
          ),
        ],
      ),
    );
  }

  _vertical() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.009,
    );
  }
}
