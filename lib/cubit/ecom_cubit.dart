import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'ecom_state.dart';

class EcomCubit extends Cubit<EcomState> {
  EcomCubit() : super(EcomInitialState());

  static EcomCubit getContext(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> brandLists = [
    {
      'name': 'Iphone',
      'price': 200,
    },
    {
      'name': 'Samsung Smartphone',
      'price': 100,
    },
    {
      'name': 'Sony Tv',
      'price': 80,
    },
  ];

  Database? database;
  List<Map> ecomLists = [];
  int sum = 0;

  void createDatabase() {
    openDatabase('ecomApp.db', version: 1, onCreate: (db, version) {
      db
          .execute(
              'CREATE TABLE ecom (id INTEGER PRIMARY KEY, name TEXT, price INTEGER)')
          .then((value) {
        print('Table Created');
      }).catchError((err) {
        print('Failed to create table, error: ${err.toString()}');
      });
    }, onOpen: (database) {
      getEcomFromDatabase(database);
      print('Database opened');
    }).then((value) {
      database = value;
      emit(EcomCreateDatabase());
    });
  }

  void getEcomFromDatabase(database) {
    ecomLists = [];
    database!.rawQuery('SELECT * FROM ecom').then((value) {
      print(value);
      for (var element in value) {
        ecomLists.add(element);
      }
      emit(EcomGetFromDatabase());
    }).catchError((err) {
      print('Failed to get Lists, error: ${err.toString()}');
    });
  }

  ecomAddToCart({required String name, required int price}) async {
    await database!.transaction((txn) async {
      txn.rawInsert('INSERT INTO ecom (name, price) VALUES (?, ?)', [
        name,
        price,
      ]).then((value) {
        getEcomFromDatabase(database);
        print('New product added to cart');
        emit(EcomAddToDatabaseState());
      }).catchError((err) {
        print('Failed to Add product into cart');
      });
    });
  }

  cartItemsTotal(List<int> prices) {
    sum = prices.fold(
        0, (previousValue, currentValue) => previousValue + currentValue);
    emit(EcomCartTotalPriceState());
  }

  deleteFromCart({required int id}) {
    database!.rawDelete('DELETE FROM ecom WHERE id = ?', [id]).then((value) {
      getEcomFromDatabase(database);
      print('Product removed from cart');
      emit(EcomRemoveFromDatabaseState());
    }).catchError((err) {
      print('Failed to remove product from cart');
    });
  }
}
