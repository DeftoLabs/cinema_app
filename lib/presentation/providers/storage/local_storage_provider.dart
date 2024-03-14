import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema/infrastructure/datasource/isar_datasource.dart';
import 'package:cinema/infrastructure/repositories/local_storage_repository_impl.dart';


final localStorageRepositoryProvider = Provider((ref){

  return LocalStorageRepositoryImpl(IsarDatasource());

});