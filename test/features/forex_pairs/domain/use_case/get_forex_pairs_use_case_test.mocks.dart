// Mocks generated by Mockito 5.4.5 from annotations
// in ft/test/features/forex_pairs/domain/use_case/get_forex_pairs_use_case_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:ft/features/forex_pairs/domain/entity/forex_pair.dart' as _i4;
import 'package:ft/features/forex_pairs/domain/repository/forex_pairs_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [ForexPairsRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockForexPairsRepository extends _i1.Mock
    implements _i2.ForexPairsRepository {
  MockForexPairsRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.ForexPair>> getForexPairs() =>
      (super.noSuchMethod(
            Invocation.method(#getForexPairs, []),
            returnValue: _i3.Future<List<_i4.ForexPair>>.value(
              <_i4.ForexPair>[],
            ),
          )
          as _i3.Future<List<_i4.ForexPair>>);
}
