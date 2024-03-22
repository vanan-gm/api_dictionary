import 'package:api_dictionary/blocs/word_bloc/word_bloc.dart';
import 'package:api_dictionary/blocs/word_bloc/word_event.dart';
import 'package:api_dictionary/blocs/word_bloc/word_state.dart';
import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/enums/internet_state.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/presentation/pages/base_page/base_page.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/dummy_word_box.dart';
import 'package:api_dictionary/presentation/widgets/search_box.dart';
import 'package:api_dictionary/presentation/widgets/word_box.dart';
import 'package:api_dictionary/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> with RootPage, SingleTickerProviderStateMixin{
  final TextEditingController _searchCtrl = TextEditingController();
  late TabController _tabController;
  Word? _word;
  List<Meanings> _listMeanings = [];
  String _errorMessage = '';
  late WordBloc _bloc;

  @override
  Widget appBarWidget() => Text('E-E Dictionary', style: AppStyles.appStyle(color: AppColors.white, fontSize: AppConstants.fontAppBarSize));

  @override
  double? toolbarHeight() => 120;

  @override
  Color statusBarColor() => AppColors.crimson;

  @override
  Color appBarColor() => AppColors.crimson;

  @override
  Widget leading() => Padding(
    padding: EdgeInsets.all(AppConstants.paddingSmallest),
    child: const AssetIcon(icon: AssetPaths.icLeftMenu, size: AppConstants.iconDefaultSize, color: AppColors.white)
  );

  @override
  bool useLeading() => true;
  
  @override
  PreferredSize? bottom() => PreferredSize(
    preferredSize: const Size.fromHeight(0.0),
    child: Container(
      color: AppColors.crimson,
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.paddingDefault,
        horizontal: AppConstants.paddingDefault,
      ),
      child: SearchBox(
        controller: _searchCtrl,
        onSearch: () async{
          if(internetState != InternetState.disconnected){
            _bloc.add(GetWordDefinitionEvent(word: _searchCtrl.text.trim()));
          }else{
            DialogUtils.showNetworkErrorDialog(context);
          }
        },
        onClearSearch: () => setState(() {
          _word = null;
          _listMeanings = [];
          _errorMessage = '';
          _tabController.index = 0;
          _bloc.add(ResetSearchWordEvent());
        }),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: sections.length, vsync: this);
    _bloc = BlocProvider.of<WordBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
    _tabController.dispose();
    _searchCtrl.dispose();
  }

  void handleOnTapSectionBar(int index){
    if(_word == null) return;
    _bloc.add(FilterWordTypeEvent(word: _word!, filterType: sections[index]));
  }

  @override
  Widget buildUi() {
    return Column(
      children: [
        Container(
          width: widthScreen,
          height: 8,
          decoration: const BoxDecoration(
            color: AppColors.crimson,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(AppConstants.radiusRound),
              bottomLeft: Radius.circular(AppConstants.radiusRound),
            ),
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: sections.length,
            child: Column(
              children: [
                SizedBox(
                  width: widthScreen,
                  height: 50,
                  child: TabBar(
                    isScrollable: true,
                    controller: _tabController,
                    onTap: handleOnTapSectionBar,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabAlignment: TabAlignment.start,
                    indicatorColor: AppColors.crimson,
                    dividerColor: AppColors.white,
                    tabs: List.generate(sections.length, (index) => Tab(child: Text(sections[index], style: AppStyles.appStyle()),)),
                  ),
                ),
                Expanded(
                  child: BlocConsumer<WordBloc, WordState>(
                    builder: (context, state){
                      if(state is WordLoadingState){
                        return Shimmer.fromColors(
                          baseColor: AppColors.grey.withOpacity(.85),
                          highlightColor: AppColors.grey.withOpacity(.45),
                          child: ListView.builder(
                            itemCount: 5,
                            itemBuilder: (context, index){
                              return const DummyWordBox();
                            },
                          ),
                        );
                      }else if(state is WordSuccessState){
                        return ListView.builder(
                          itemCount: state.data.data.meanings.length,
                          itemBuilder: (context, index){
                            return WordBox(word: state.data.data, meanings: state.data.data.meanings[index]);
                          }
                        );
                      }else if(state is WordFailureState){
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingGiant),
                          child: Center(
                            child: Text(state.failure.errorMessage, style: AppStyles.appStyle(), textAlign: TextAlign.center,)
                          )
                        );
                      }else if(state is WordAfterFilerState){
                        return state.word.meanings.isNotEmpty ? ListView.builder(
                          itemCount: state.word.meanings.length,
                          itemBuilder: (context, index){
                            return WordBox(word: state.word, meanings: state.word.meanings[index]);
                          }
                        ) : Padding(
                          padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingGiant),
                          child: Center(
                            child: Text('Your word definitions do not have this type', style: AppStyles.appStyle(), textAlign: TextAlign.center,)
                          )
                        );
                      }else{
                        return const SizedBox();
                      }
                    },
                    listener: (context, state){
                      if(state is WordSuccessState){
                        _word = state.data.data;
                      }else if(state is WordFailureState){
                        _word = null;
                      }
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<String> sections = ['All', 'Noun', 'Pronoun', 'Adjective', 'Verb', 'Adverb', 'Preposition', 'Conjunction', 'Interjection'];
}

