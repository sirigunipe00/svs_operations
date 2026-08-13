import 'package:dartz/dartz.dart';

void main() {
 final response =  check(false);
 response.fold((l) {
 }, (r) {
 },);
  
}

Either<String, bool> check(bool flag) {
  
  return flag ? right(true) : left('Geetha');
}