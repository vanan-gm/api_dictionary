import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
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

  Widget leading() => RippleEffect(
    onPressed: () => Navigator.of(context).maybePop(),
    child: const AssetIcon(icon: AssetPaths.icBack, size: AppConstants.iconDefaultSize, color: AppColors.black),
  );

  void initStateBase() => (){};
  void disposeStateBase() => (){};
  void buildUICompleted() => (){};

  void removeFocus() => FocusScope.of(context).unfocus();
}

mixin RootPage<Page extends BasePage> on BasePageState<Page>{
  late double widthScreen;
  late double heightScreen;

  @override
  void initState() {
    super.initState();
    initStateBase();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      buildUICompleted();
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposeStateBase();
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
        body: SafeArea(
          child: buildUi(),
        ),
      ) : AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: statusBarBrightness(),
          statusBarColor: statusBarColor(),
        ),
        child: Scaffold(
          backgroundColor: backGroundColor(),
          body: SafeArea(
            child: buildUi(),
          ),
          floatingActionButton: useFloatingButton() ? floatingButton() : null,
        ),
      ),
    );
  }
  
}