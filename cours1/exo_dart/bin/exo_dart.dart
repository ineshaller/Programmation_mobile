import 'package:exo_dart/exo_dart.dart' as exo_dart;

// Les bases
void main() {
  int? a;
  int b = a ?? 5;

  if (a == null) {
    a = 3;
  }

  int c = a;
  print(c);

  print(a.isEven);
}
/*
// Fonctions
String foo(String name, int number, bool toUpperCase) =>
   '${(toUpperCase ? name.toUpperCase() : name)} $number';

void useFoo() {
 foo(name: 'a');
 foo(name: 'b', number: 1);
 foo(name: 'c', toUpperCase: true);
 foo(name: 'd', number: 2, toUpperCase: true);
}

void main2() {
  List<int> l = [1, 2, 3, 4, 5];
  int? a=null;

  if (true){
    l.add(4);
  }

  if 
}
*/