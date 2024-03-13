import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/helper/dio_helper.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/presentation/pages/base_page/base_page.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/search_box.dart';
import 'package:api_dictionary/repository/dictionary_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> with RootPage, SingleTickerProviderStateMixin{
  final TextEditingController _searchCtrl = TextEditingController();
  late TabController _tabController;
  Word? word;

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
          final DictionaryRepositoryImpl repo = DictionaryRepositoryImpl(dio: DioHelper().dio);
          final result = await repo.getWord(searchWord: _searchCtrl.text.trim());
          word = result;
          setState(() {});
        },
        onClearSearch: () => setState(() {
          word = null;
        }),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: sections.length, vsync: this);
  }

  @override
  Widget buildUi() {
    return DefaultTabController(
      length: sections.length,
      child: Column(
        children: [
          SizedBox(
            width: widthScreen,
            height: 50,
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              tabAlignment: TabAlignment.start,
              indicatorColor: AppColors.crimson,
              dividerColor: AppColors.white,
              tabs: List.generate(sections.length, (index) => Tab(child: Text(sections[index], style: AppStyles.appStyle()),)),
            ),
          ),
          Expanded(
            child: word != null && word!.word.isNotEmpty ? Column(
              children: List.generate(word!.meanings.length, (index){
                return ListTile(
                  leading: const AssetIcon(icon: AssetPaths.icSphere, size: AppConstants.iconDefaultSize, color: AppColors.crimson),
                  title: Text(word!.meanings[index].definitions.first.definition, style: AppStyles.appStyle()),
                );
              }),
            ) : const SizedBox(),
          ),
        ],
      ),
    );
  }

  List<String> sections = ['All', 'Noun', 'Pronoun', 'Adjective', 'Verb', 'Adverb', 'Preposition', 'Conjunction', 'Interjection'];
}

