extension StringExt on String{
    String cutString(int index){
      if(index > length) return this;
      return substring(0, index);
    }

    String upperCaseFirstLetter(){
      return '${substring(0, 1).toUpperCase()}${substring(1, length)}';
    }
}