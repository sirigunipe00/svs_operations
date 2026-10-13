// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_item_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CreateItemState {
  AddItemModel get form => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;
  AddItemView get view => throw _privateConstructorUsedError;
  Failure? get error => throw _privateConstructorUsedError;
  String? get successMsg => throw _privateConstructorUsedError;

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateItemStateCopyWith<CreateItemState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateItemStateCopyWith<$Res> {
  factory $CreateItemStateCopyWith(
          CreateItemState value, $Res Function(CreateItemState) then) =
      _$CreateItemStateCopyWithImpl<$Res, CreateItemState>;
  @useResult
  $Res call(
      {AddItemModel form,
      bool isLoading,
      bool isSuccess,
      AddItemView view,
      Failure? error,
      String? successMsg});

  $AddItemModelCopyWith<$Res> get form;
  $FailureCopyWith<$Res>? get error;
}

/// @nodoc
class _$CreateItemStateCopyWithImpl<$Res, $Val extends CreateItemState>
    implements $CreateItemStateCopyWith<$Res> {
  _$CreateItemStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? view = null,
    Object? error = freezed,
    Object? successMsg = freezed,
  }) {
    return _then(_value.copyWith(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as AddItemModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as AddItemView,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      successMsg: freezed == successMsg
          ? _value.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddItemModelCopyWith<$Res> get form {
    return $AddItemModelCopyWith<$Res>(_value.form, (value) {
      return _then(_value.copyWith(form: value) as $Val);
    });
  }

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FailureCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $FailureCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CreateItemStateImplCopyWith<$Res>
    implements $CreateItemStateCopyWith<$Res> {
  factory _$$CreateItemStateImplCopyWith(_$CreateItemStateImpl value,
          $Res Function(_$CreateItemStateImpl) then) =
      __$$CreateItemStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AddItemModel form,
      bool isLoading,
      bool isSuccess,
      AddItemView view,
      Failure? error,
      String? successMsg});

  @override
  $AddItemModelCopyWith<$Res> get form;
  @override
  $FailureCopyWith<$Res>? get error;
}

/// @nodoc
class __$$CreateItemStateImplCopyWithImpl<$Res>
    extends _$CreateItemStateCopyWithImpl<$Res, _$CreateItemStateImpl>
    implements _$$CreateItemStateImplCopyWith<$Res> {
  __$$CreateItemStateImplCopyWithImpl(
      _$CreateItemStateImpl _value, $Res Function(_$CreateItemStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = null,
    Object? isLoading = null,
    Object? isSuccess = null,
    Object? view = null,
    Object? error = freezed,
    Object? successMsg = freezed,
  }) {
    return _then(_$CreateItemStateImpl(
      form: null == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as AddItemModel,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
      view: null == view
          ? _value.view
          : view // ignore: cast_nullable_to_non_nullable
              as AddItemView,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as Failure?,
      successMsg: freezed == successMsg
          ? _value.successMsg
          : successMsg // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CreateItemStateImpl implements _CreateItemState {
  const _$CreateItemStateImpl(
      {required this.form,
      required this.isLoading,
      required this.isSuccess,
      required this.view,
      this.error,
      this.successMsg});

  @override
  final AddItemModel form;
  @override
  final bool isLoading;
  @override
  final bool isSuccess;
  @override
  final AddItemView view;
  @override
  final Failure? error;
  @override
  final String? successMsg;

  @override
  String toString() {
    return 'CreateItemState(form: $form, isLoading: $isLoading, isSuccess: $isSuccess, view: $view, error: $error, successMsg: $successMsg)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateItemStateImpl &&
            (identical(other.form, form) || other.form == form) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess) &&
            (identical(other.view, view) || other.view == view) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.successMsg, successMsg) ||
                other.successMsg == successMsg));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, form, isLoading, isSuccess, view, error, successMsg);

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateItemStateImplCopyWith<_$CreateItemStateImpl> get copyWith =>
      __$$CreateItemStateImplCopyWithImpl<_$CreateItemStateImpl>(
          this, _$identity);
}

abstract class _CreateItemState implements CreateItemState {
  const factory _CreateItemState(
      {required final AddItemModel form,
      required final bool isLoading,
      required final bool isSuccess,
      required final AddItemView view,
      final Failure? error,
      final String? successMsg}) = _$CreateItemStateImpl;

  @override
  AddItemModel get form;
  @override
  bool get isLoading;
  @override
  bool get isSuccess;
  @override
  AddItemView get view;
  @override
  Failure? get error;
  @override
  String? get successMsg;

  /// Create a copy of CreateItemState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateItemStateImplCopyWith<_$CreateItemStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
