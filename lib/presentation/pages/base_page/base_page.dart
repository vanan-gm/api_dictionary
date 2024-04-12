import 'dart:async';

import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/enums/internet_state.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/no_internet_box.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class BasePage extends StatefulWidget{
  const BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<Page extends BasePage> extends State<Page>{
  bool useAppBar() => true;

  Brightness statusBarBrightness() => Brightness.light;

  Color statusBarColor() => AppColors.transparent;

  Color backGroundColor() => AppColors.white;

  Widget appBarWidget() => Text('E-E Dictionary', style: AppStyles.appStyle());

  Color appBarColor() => AppColors.white;

  bool useLeading() => false;

  bool useFloatingButton() => false;

  bool resizeToAvoidBottomInset() => true;

  double? toolbarHeight() => kToolbarHeight;

  Widget? flexibleSpace() => Container();

  PreferredSize? bottom() => PreferredSize(preferredSize: const Size.fromHeight(0.0), child: Container());

  List<Widget> actions() => [];


  FloatingActionButton? floatingButton() => FloatingActionButton(
    onPressed: (){},
    elevation: AppConstants.elevationZero,
    backgroundColor: AppColors.blue,
    child: const Icon(Icons.add, color: AppColors.white),
  );

  Widget leading() => CupertinoButton(
    onPressed: () => Navigator.of(context).maybePop(),
    child: const Icon(CupertinoIcons.chevron_back, color: AppColors.white),
  );

  void initStateBase() => (){};
  void disposeStateBase() => (){};
  void buildUICompleted() => (){};

  void removeFocus() => FocusScope.of(context).unfocus();
}

mixin RootPage<Page extends BasePage> on BasePageState<Page>{
  late double widthScreen;
  late double heightScreen;
  late StreamSubscription internetSubscription;
  InternetState internetState = InternetState.connected;

  @override
  void initState() {
    super.initState();
    initStateBase();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buildUICompleted();
    });
    handleInternetState();
  }

  @override
  void dispose() {
    super.dispose();
    disposeStateBase();
    internetSubscription.cancel();
  }

  Future<void> handleInternetState() async{
    final result = await Connectivity().checkConnectivity();
    internetState = result == ConnectivityResult.none ? InternetState.disconnected : InternetState.connected;
    internetSubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if(result == ConnectivityResult.none){
        internetState = InternetState.disconnected;
      }else if(result == ConnectivityResult.wifi || result == ConnectivityResult.mobile){
        internetState = InternetState.connected;
      }
      setState(() {});
    });
    setState(() {});
  }

  Widget buildUi();

  @override
  Widget build(BuildContext context) {
    widthScreen = MediaQuery.sizeOf(context).width;
    heightScreen = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => removeFocus(),
      child: useAppBar() ? Scaffold(
        backgroundColor: backGroundColor(),
        appBar: AppBar(
          backgroundColor: appBarColor(),
          toolbarHeight: toolbarHeight(),
          flexibleSpace: flexibleSpace(),
          centerTitle: true,
          title: appBarWidget(),
          leading: useLeading() ? leading() : null,
          elevation: AppConstants.elevationZero,
          actions: actions(),
          bottom: bottom(),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: statusBarColor(),
            // statusBarBrightness: statusBarBrightness(),
          ),
        ),
        resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
        body: SafeArea(
          child: Stack(
            children: [
              buildUi(),
              if(internetState == InternetState.disconnected) const Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: NoInternetBox(),
              ),
            ],
          ),
        ),
      ) : AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: statusBarBrightness(),
          statusBarColor: statusBarColor(),
        ),
        child: Scaffold(
          backgroundColor: backGroundColor(),
          resizeToAvoidBottomInset: resizeToAvoidBottomInset(),
          body: SafeArea(
            child: Stack(
              children: [
                buildUi(),
                if(internetState == InternetState.disconnected) const Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: NoInternetBox(),
                ),
              ],
            ),
          ),
          floatingActionButton: useFloatingButton() ? floatingButton() : null,
        ),
      ),
    );
  }
  
}