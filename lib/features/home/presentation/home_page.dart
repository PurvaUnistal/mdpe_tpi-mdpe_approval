import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/AppNavigator.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_string.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/row_widget.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/presentation/user_approval_list_view.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/presentation/widgets/logout_widget.dart';
import 'package:mdpe_approve_app/features/home/domain/bloc/home_bloc.dart';
import 'package:mdpe_approve_app/features/home/domain/bloc/home_event.dart';
import 'package:mdpe_approve_app/features/home/domain/bloc/home_state.dart';
import '../../../Utils/common_widgets/background_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<HomeBloc>(
      context,
    ).add(HomePageLoadedEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.mdpeApp,
        actions: [
          IconButton(
            onPressed:
                () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const LogoutWidget(),
                ),
            icon: Icon(Icons.logout, color: AppColor.white),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomePageLoadedState) {
              return BackgroundWidget(child: _buildLayout(dataState: state));
            } else {
              return const Center(child: SpinLoader());
            }
          },
        ),
      ),
    );
  }

  _buildLayout({required HomePageLoadedState dataState}) {
    return dataState.listOfAllocationData.isEmpty
        ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.search_off, size: 48, color: Colors.grey),
              const SizedBox(height: 10),
              const Text(
                "No Data Found",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  context.read<HomeBloc>().add(
                    HomePageLoadedEvent(context: context),
                  );
                },
                child: const Text("Retry"),
              ),
            ],
          ),
        )
        : ListView.builder(
          itemCount: dataState.listOfAllocationData.length,
          itemBuilder: (BuildContext context, int i) {
            final data = dataState.listOfAllocationData[i];
            return InkWell(
              onTap: () async {
                await AppConfig.instanceInit()?.setAllocationData(
                  allocationData: data,
                );
                AppNavigator.push(UserApprovalListView());
              },
              child: Card(
                child: ListTile(
                  subtitle: Column(
                    children: [
                      RowWidget(
                        title: "AllocationNumber",
                        subtitle: data.allocationNumber ?? "",
                      ),
                      RowWidget(title: "WBS No.", subtitle: data.wbsNo ?? ""),
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
