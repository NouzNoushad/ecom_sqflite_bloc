part of 'ecom_cubit.dart';

@immutable
abstract class EcomState {}

class EcomInitialState extends EcomState {}

class EcomCreateDatabase extends EcomState{}

class EcomGetFromDatabase extends EcomState{}

class EcomAddToDatabaseState extends EcomState {}

class EcomCartTotalPriceState extends EcomState{}

class EcomRemoveFromDatabaseState extends EcomState {}