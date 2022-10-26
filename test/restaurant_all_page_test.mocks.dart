// Mocks generated by Mockito 5.2.0 from annotations
// in restaurant_app/test/restaurant_all_page_test.dart.
// Do not manually edit this file.

import 'dart:ui' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:restaurant_app/models/restaurant_model.dart' as _i4;
import 'package:restaurant_app/providers/restaurants_provider.dart' as _i3;
import 'package:restaurant_app/service/service_api.dart' as _i2;
import 'package:restaurant_app/utils/result_state.dart' as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeServiceApi_0 extends _i1.Fake implements _i2.ServiceApi {}

/// A class which mocks [RestaurantProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestaurantProvider extends _i1.Mock
    implements _i3.RestaurantProvider {
  MockRestaurantProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.ServiceApi get apiService =>
      (super.noSuchMethod(Invocation.getter(#apiService),
          returnValue: _FakeServiceApi_0()) as _i2.ServiceApi);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);
  @override
  List<_i4.Restaurants> get result =>
      (super.noSuchMethod(Invocation.getter(#result),
          returnValue: <_i4.Restaurants>[]) as List<_i4.Restaurants>);
  @override
  _i5.ResultState get state => (super.noSuchMethod(Invocation.getter(#state),
      returnValue: _i5.ResultState.loading) as _i5.ResultState);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  void addListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i6.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}
