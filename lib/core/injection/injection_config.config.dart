// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/forex_pairs/data/data_source/forex_pairs_data_remote_source.dart'
    as _i268;
import '../../features/forex_pairs/data/mapper/forex_pair_mapper.dart' as _i812;
import '../../features/forex_pairs/data/repository/forex_pairs_repository_impl.dart'
    as _i1022;
import '../../features/forex_pairs/domain/repository/forex_pairs_repository.dart'
    as _i516;
import '../../features/forex_pairs/domain/use_cases/get_forex_pairs_use_case.dart'
    as _i384;
import '../../features/forex_pairs/presentation/forex_pairs_list/bloc/forex_pairs_bloc.dart'
    as _i784;
import '../../features/forex_pairs_bottom_nav_bar/presentation/bloc/forex_pairs_bottom_nav_bar_bloc.dart'
    as _i50;
import '../../features/ticker/data/data_source/web_socket_data_source.dart'
    as _i547;
import '../../features/ticker/data/mapper/ticker_list_mapper.dart' as _i51;
import '../../features/ticker/data/mapper/ticker_mapper.dart' as _i1054;
import '../../features/ticker/data/repository/web_socket_repo_impl.dart'
    as _i628;
import '../../features/ticker/domain/repository/web_socket_repo.dart' as _i949;
import '../../features/ticker/domain/use_cases/disconnect_use_case.dart'
    as _i155;
import '../../features/ticker/domain/use_cases/get_latest_ticker_data_use_case.dart'
    as _i78;
import '../../features/ticker/domain/use_cases/get_stream_use_case.dart'
    as _i438;
import '../../features/ticker/domain/use_cases/subscribe_use_case.dart' as _i11;
import '../../features/ticker/domain/use_cases/unsubscribe_use_case.dart'
    as _i363;
import '../../features/ticker/presentation/bloc/ticker_bloc_bloc.dart' as _i670;
import '../dio/dio_client.dart' as _i191;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i1054.TickerMapper>(() => _i1054.TickerMapper());
    gh.factory<_i78.GetLatestTickerDataUseCase>(
      () => _i78.GetLatestTickerDataUseCase(),
    );
    gh.factory<_i812.ForexPairMapper>(() => _i812.ForexPairMapper());
    gh.factory<_i50.ForexPairsBottomNavBarBloc>(
      () => _i50.ForexPairsBottomNavBarBloc(),
    );
    gh.singleton<_i547.WebSocketDataSource>(() => _i547.WebSocketDataSource());
    gh.lazySingleton<_i191.DioClient>(() => _i191.DioClient());
    gh.factory<_i51.TickerListMapper>(
      () => _i51.TickerListMapper(gh<_i1054.TickerMapper>()),
    );
    gh.factory<_i268.ForexPairsRemoteDataSource>(
      () => _i268.ForexPairsRemoteDataSource(gh<_i191.DioClient>()),
    );
    gh.factory<_i516.ForexPairsRepository>(
      () => _i1022.ForexPairsRepositoryIMPL(
        gh<_i268.ForexPairsRemoteDataSource>(),
        gh<_i812.ForexPairMapper>(),
      ),
    );
    gh.factory<_i949.WebSocketRepository>(
      () => _i628.WebSocketRepoImpl(
        gh<_i547.WebSocketDataSource>(),
        gh<_i51.TickerListMapper>(),
      ),
    );
    gh.factory<_i384.GetForexPairsUseCase>(
      () => _i384.GetForexPairsUseCase(gh<_i516.ForexPairsRepository>()),
    );
    gh.factory<_i784.ForexPairsBloc>(
      () => _i784.ForexPairsBloc(gh<_i384.GetForexPairsUseCase>()),
    );
    gh.factory<_i11.SubscribeUseCase>(
      () => _i11.SubscribeUseCase(gh<_i949.WebSocketRepository>()),
    );
    gh.factory<_i155.DisconnectUseCase>(
      () => _i155.DisconnectUseCase(gh<_i949.WebSocketRepository>()),
    );
    gh.factory<_i363.UnSubscribeUseCase>(
      () => _i363.UnSubscribeUseCase(gh<_i949.WebSocketRepository>()),
    );
    gh.factory<_i438.GetStreamUseCase>(
      () => _i438.GetStreamUseCase(gh<_i949.WebSocketRepository>()),
    );
    gh.factory<_i670.TickerBloc>(
      () => _i670.TickerBloc(
        gh<_i11.SubscribeUseCase>(),
        gh<_i363.UnSubscribeUseCase>(),
        gh<_i438.GetStreamUseCase>(),
        gh<_i78.GetLatestTickerDataUseCase>(),
      ),
    );
    return this;
  }
}
