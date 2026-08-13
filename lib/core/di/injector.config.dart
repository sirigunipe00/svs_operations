// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;
import 'package:package_info_plus/package_info_plus.dart' as _i655;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../app/data/app_repository.dart' as _i691;
import '../../app/data/app_version.dart' as _i346;
import '../../app/presentation/app_update_blocprovider.dart' as _i266;
import '../../features/auth/data/auth_repo.dart' as _i585;
import '../../features/auth/data/auth_repo_impl.dart' as _i328;
import '../../features/auth/presentation/bloc/auth/auth_cubit.dart' as _i190;
import '../../features/auth/presentation/bloc/sign_in/sign_in_cubit.dart'
    as _i140;
import '../core.dart' as _i351;
import '../local_storage/key_vale_storage.dart' as _i1012;
import '../network/api_client.dart' as _i557;
import '../network/internet_check.dart' as _i402;
import 'injector.dart' as _i811;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final thirdPartyDependencies = _$ThirdPartyDependencies();
    gh.factory<DateTime>(() => thirdPartyDependencies.defaultDateTime);
    gh.singleton<_i519.Client>(() => thirdPartyDependencies.httpClient);
    gh.singleton<_i895.Connectivity>(() => thirdPartyDependencies.connectivity);
    gh.singleton<_i558.FlutterSecureStorage>(
        () => thirdPartyDependencies.secureStorage);
    await gh.singletonAsync<_i655.PackageInfo>(
      () => thirdPartyDependencies.packageInfo,
      preResolve: true,
    );
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => thirdPartyDependencies.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i402.InternetConnectionChecker>(
        () => _i402.InternetConnectionChecker(gh<_i895.Connectivity>()));
    gh.factory<_i557.ApiClient>(() => _i557.ApiClient(
          gh<_i519.Client>(),
          gh<_i402.InternetConnectionChecker>(),
        ));
    gh.factory<_i1012.KeyValueStorage>(() => _i1012.KeyValueStorage(
          gh<_i558.FlutterSecureStorage>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i346.AppVersion>(
        () => _i346.AppVersion(gh<_i655.PackageInfo>()));
    gh.lazySingleton<_i585.AuthRepo>(() => _i328.AuthRepoImpl(
          gh<_i351.ApiClient>(),
          gh<_i351.KeyValueStorage>(),
        ));
    gh.lazySingleton<_i691.AppRepository>(() => _i691.AppRepository(
          gh<_i351.ApiClient>(),
          gh<_i346.AppVersion>(),
        ));
    gh.factory<_i140.SignInCubit>(
        () => _i140.SignInCubit(gh<_i585.AuthRepo>()));
    gh.factory<_i190.AuthCubit>(() => _i190.AuthCubit(gh<_i585.AuthRepo>()));
    gh.lazySingleton<_i266.AppUpdateBlocprovider>(
        () => _i266.AppUpdateBlocprovider(gh<_i691.AppRepository>()));
    return this;
  }
}

class _$ThirdPartyDependencies extends _i811.ThirdPartyDependencies {}
