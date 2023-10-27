

extension ListExtension<T> on List<T>{
  T? get second{
    if(length >= 2){
      return this[1];
    }else{
      return null;
    }
  }
}