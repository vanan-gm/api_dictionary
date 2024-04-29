import 'package:api_dictionary/commons/app_colors.dart';
import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_styles.dart';
import 'package:api_dictionary/commons/asset_paths.dart';
import 'package:api_dictionary/injector.dart';
import 'package:api_dictionary/presentation/widgets/asset_icon.dart';
import 'package:api_dictionary/presentation/widgets/ripple_effect.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;
  final VoidCallback? onClearSearch;
  final FocusNode? focusNode;
  final VoidCallback onVoice;
  const SearchBox({super.key, required this.onSearch, required this.controller, this.onClearSearch,
    this.focusNode, required this.onVoice});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  Widget suffixIc = const SizedBox();

  @override
  void initState() {
    super.initState();
    suffixIc = RippleEffect(
      onPressed: widget.onVoice,
      radius: AppConstants.radiusCircle,
      child: Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.all(AppConstants.paddingDefault),
          child: const AssetIcon(icon: AssetPaths.icMic, color: AppColors.onyx, size: AppConstants.iconSmallSize),
        ),
      ),
    );
    widget.focusNode!.addListener(() {
      if(!widget.focusNode!.hasFocus && widget.controller.text.trim().isNotEmpty){
         widget.onSearch.call();
      }
    });
    widget.controller.addListener(() {
      if(widget.controller.text.trim().isEmpty){
        suffixIc = RippleEffect(
          onPressed: (){
            widget.focusNode!.unfocus();
            widget.onVoice.call();
          },
          radius: AppConstants.radiusCircle,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(AppConstants.paddingDefault),
              child: const AssetIcon(icon: AssetPaths.icMic, color: AppColors.onyx, size: AppConstants.iconSmallSize),
            ),
          ),
        );
      }else{
        suffixIc = RippleEffect(
          onPressed: () => setState(() {
            widget.controller.text = '';
            if(widget.onClearSearch != null) widget.onClearSearch!.call();
          }),
          radius: AppConstants.radiusCircle,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(AppConstants.paddingDefault),
              child: const AssetIcon(icon: AssetPaths.icClose, color: AppColors.onyx, size: AppConstants.iconSmallSize),
            ),
          ),
        );
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      style: AppStyles.appStyle(color: AppColors.onyx),
      focusNode: widget.focusNode,
      decoration: InputDecoration(
        hintText: 'Search here...',
        hintStyle: AppStyles.appStyle(color: AppColors.onyx),
        fillColor: AppColors.white,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingLarge,
          vertical: AppConstants.paddingLarge,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(AppConstants.paddingDefault),
          child: const AssetIcon(icon: AssetPaths.icSearch, color: AppColors.onyx, size: AppConstants.iconTinySize),
        ),
        suffixIcon: suffixIc,
        suffixIconConstraints: const BoxConstraints(maxWidth: AppConstants.suffixWith, minWidth: AppConstants.suffixWith),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(AppConstants.radiusCircle),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(AppConstants.radiusCircle),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(AppConstants.radiusCircle),
        ),
      ),
    );
  }
}
