import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_paths.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/extensions/string_ext.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/presentation/pages/base_page/base_page.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
import 'package:api_dictionary/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends BasePage {
  final Word word;
  final String chosenType;
  const DetailPage({super.key, required this.word, this.chosenType = 'Noun'});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends BasePageState<DetailPage> with RootPage, SingleTickerProviderStateMixin{
  int _currentIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();
  late TabController _tabController;
  List<Definitions> _definitions = [];
  List<String> _synonyms = [];
  List<String> _antonyms = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.animation!.addListener(() {
      setState(() {
        _currentIndex = (_tabController.animation!.value).round();
      });
    });
    setDataFromType();
    setDataForAudio();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
    _tabController.dispose();
  }

  void setDataFromType(){
    for(var item in widget.word.meanings){
      if(item.partOfSpeech.toLowerCase() == widget.chosenType.toLowerCase()){
        _definitions = item.definitions;
        _synonyms = item.synonyms;
        _antonyms = item.antonyms;
      }
    }
  }

  Future<void> setDataForAudio() async{
    for(var item in widget.word.phonetics){
      if(item.audio.isNotEmpty){
        await _audioPlayer.setUrl(item.audio);
        return;
      }
    }
  }

  @override
  Widget appBarWidget() => Text('Definition', style: AppStyles.appStyle(color: AppColors.white, fontSize: AppConstants.fontAppBarSize));

  @override
  Color statusBarColor() => AppColors.crimson;

  @override
  Color appBarColor() => AppColors.crimson;

  @override
  bool useLeading() => true;

  @override
  double? toolbarHeight() => 210;

  @override
  PreferredSize? bottom() => PreferredSize(
    preferredSize: const Size.fromHeight(10.0),
    child: Container(
      color: AppColors.crimson,
      padding: EdgeInsets.symmetric(
        vertical: AppConstants.paddingDefault,
      ),
      child: Column(
        children: [
          Text(widget.word.word.upperCaseFirstLetter(), textAlign: TextAlign.center,
            style: AppStyles.appStyle(color: AppColors.white, fontWeight: FontWeight.w600, fontSize: AppConstants.fontGiantSize),),
          Text(widget.word.phonetic, style: AppStyles.appStyle(color: AppColors.white.withOpacity(.7), fontStyle: FontStyle.italic),),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingDefault,
            ).copyWith(top: AppConstants.paddingLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                functionBox(icon: AssetPaths.icVoice, title: 'Voice', onTap: () async{
                  bool loaded = _audioPlayer.processingState == ProcessingState.ready ||
                    _audioPlayer.processingState == ProcessingState.completed ||
                    _audioPlayer.processingState == ProcessingState.buffering;
                  if(loaded){
                    if(_audioPlayer.playing){
                      _audioPlayer.seek(Duration.zero);
                    }else{
                      _audioPlayer.play();
                    }
                  }
                }),
                functionBox(icon: AssetPaths.icEmptyStar, title: 'Save', onTap: (){}),
                functionBox(icon: AssetPaths.icShare, title: 'Share', onTap: (){
                  Share.share('${AppPaths.dictionaryUrl}/${widget.word.word}');
                }),
                functionBox(icon: AssetPaths.icCopy, title: 'Copy', onTap: () async{
                  await Clipboard.setData(ClipboardData(text: widget.word.word));
                  ToastUtils.showSuccessToast();
                }),
              ],
            ),
          )
        ],
      ),
    ),
  );

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
            length: _tabs.length,
            child: Column(
              children: [
                SizedBox(
                  width: widthScreen,
                  height: 50,
                  child: TabBar(
                    controller: _tabController,
                    onTap: (index){
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: AppColors.crimson,
                    dividerColor: AppColors.white,
                    tabs: List.generate(_tabs.length, (index) => Tab(child: Text(_tabs[index].title,
                      style: AppStyles.appStyle(color: _currentIndex == _tabs[index].index ? AppColors.crimson : AppColors.black)),)),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      definitionSection(),
                      _synonyms.isNotEmpty ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingLarge,
                          vertical: AppConstants.paddingLarge,
                        ),
                        child: ListView.builder(
                          itemCount: _synonyms.length,
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstants.paddingSmall,
                              ),
                              child: Text('${index + 1}. ${_synonyms[index].upperCaseFirstLetter()}', style: AppStyles.appStyle()),
                            );
                          },
                        ),
                      ) : Center(child: Text('We cannot find any synonyms \nfor this word', style: AppStyles.appStyle(), textAlign: TextAlign.center,)),
                      _antonyms.isNotEmpty ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppConstants.paddingLarge,
                          vertical: AppConstants.paddingLarge,
                        ),
                        child: ListView.builder(
                          itemCount: _antonyms.length,
                          itemBuilder: (context, index){
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstants.paddingSmall,
                              ),
                              child: Text('${index + 1}. ${_antonyms[index].upperCaseFirstLetter()}', style: AppStyles.appStyle()),
                            );
                          },
                        ),
                      ) : Center(child: Text('We cannot find any antonyms \nfor this word', style: AppStyles.appStyle(), textAlign: TextAlign.center,)),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget functionBox({required String icon, required String title, required VoidCallback onTap}){
    return RippleEffect(
      onPressed: onTap,
      radius: AppConstants.radiusContainer,
      child: Container(
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.radiusContainer),
          color: AppColors.grey.withOpacity(.4),
        ),
        padding: EdgeInsets.symmetric(
          vertical: AppConstants.paddingSmall,
        ),
        child: Column(
          children: [
            AssetIcon(icon: icon, size: AppConstants.iconDefaultSize, color: AppColors.white),
            Padding(
              padding: EdgeInsets.only(
                top: AppConstants.paddingSmall,
              ),
              child: Text(title, style: AppStyles.appStyle(color: AppColors.white),)
            )
          ],
        ),
      ),
    );
  }

  Widget definitionSection(){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLarge,
        vertical: AppConstants.paddingLarge,
      ),
      child: ListView.builder(
        itemCount: _definitions.length,
        itemBuilder: (context, index){
          return Container(
            padding: EdgeInsets.symmetric(
              vertical: AppConstants.paddingDefault,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${index + 1}. ${_definitions[index].definition.upperCaseFirstLetter()}', style: AppStyles.appStyle()),
                Padding(
                  padding: EdgeInsets.only(
                    top: AppConstants.paddingSmall,
                    left: AppConstants.paddingDefault,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                            color: const Color(0x7f9e9e9e),
                          ),
                          margin: EdgeInsets.only(
                            right: AppConstants.paddingSmall,
                          ),
                        ),
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: AppConstants.paddingTiny,
                              ),
                              child: Text(_definitions[index].example.isNotEmpty ? _definitions[index].example : 'There are no examples for this definition',
                                style: AppStyles.appStyle(color: AppColors.onyx, fontStyle: FontStyle.italic),),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  final List<TabItem> _tabs = [TabItem(index: 0, title: 'Definitions'), TabItem(index: 1, title: 'Synonyms'), TabItem(index: 2, title: 'Antonyms')];
}

class TabItem{
  final int index;
  final String title;
  TabItem({required this.index, required this.title});
}
