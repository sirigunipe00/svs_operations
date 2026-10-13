// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_gate_entry_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewGateEntryForm _$NewGateEntryFormFromJson(Map<String, dynamic> json) {
  return _NewGateEntryForm.fromJson(json);
}

/// @nodoc
mixin _$NewGateEntryForm {
  @JsonKey(includeToJson: false)
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: true, includeIfNull: false)
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'po_number')
  String? get poNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_no')
  String? get vehicleNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_invoice_no')
  String? get vendorInvNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_date')
  String? get invoiceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_qty')
  String? get invoiceQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_amount')
  String? get invoiceAmt => throw _privateConstructorUsedError;
  @JsonKey(name: 'entry_date')
  String get entryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_photo')
  String? get vehiclePhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_back_photo')
  String? get vehicleBackPhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_photo')
  String? get vendorInvPhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'remarks')
  String? get remarks => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_is_job_work')
  int? get isJobWork => throw _privateConstructorUsedError;

  /// Serializes this NewGateEntryForm to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NewGateEntryForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NewGateEntryFormCopyWith<NewGateEntryForm> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewGateEntryFormCopyWith<$Res> {
  factory $NewGateEntryFormCopyWith(
          NewGateEntryForm value, $Res Function(NewGateEntryForm) then) =
      _$NewGateEntryFormCopyWithImpl<$Res, NewGateEntryForm>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String? status,
      @JsonKey(includeToJson: true, includeIfNull: false) String? name,
      @JsonKey(name: 'po_number') String? poNumber,
      @JsonKey(name: 'vehicle_no') String? vehicleNo,
      @JsonKey(name: 'vendor_invoice_no') String? vendorInvNo,
      @JsonKey(name: 'invoice_date') String? invoiceDate,
      @JsonKey(name: 'invoice_qty') String? invoiceQty,
      @JsonKey(name: 'invoice_amount') String? invoiceAmt,
      @JsonKey(name: 'entry_date') String entryDate,
      @JsonKey(name: 'vehicle_photo') String? vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
      @JsonKey(name: 'invoice_photo') String? vendorInvPhoto,
      @JsonKey(name: 'remarks') String? remarks,
      @JsonKey(name: 'custom_is_job_work') int? isJobWork});
}

/// @nodoc
class _$NewGateEntryFormCopyWithImpl<$Res, $Val extends NewGateEntryForm>
    implements $NewGateEntryFormCopyWith<$Res> {
  _$NewGateEntryFormCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NewGateEntryForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? name = freezed,
    Object? poNumber = freezed,
    Object? vehicleNo = freezed,
    Object? vendorInvNo = freezed,
    Object? invoiceDate = freezed,
    Object? invoiceQty = freezed,
    Object? invoiceAmt = freezed,
    Object? entryDate = null,
    Object? vehiclePhoto = freezed,
    Object? vehicleBackPhoto = freezed,
    Object? vendorInvPhoto = freezed,
    Object? remarks = freezed,
    Object? isJobWork = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      poNumber: freezed == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNo: freezed == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorInvNo: freezed == vendorInvNo
          ? _value.vendorInvNo
          : vendorInvNo // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceDate: freezed == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceQty: freezed == invoiceQty
          ? _value.invoiceQty
          : invoiceQty // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceAmt: freezed == invoiceAmt
          ? _value.invoiceAmt
          : invoiceAmt // ignore: cast_nullable_to_non_nullable
              as String?,
      entryDate: null == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as String,
      vehiclePhoto: freezed == vehiclePhoto
          ? _value.vehiclePhoto
          : vehiclePhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleBackPhoto: freezed == vehicleBackPhoto
          ? _value.vehicleBackPhoto
          : vehicleBackPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorInvPhoto: freezed == vendorInvPhoto
          ? _value.vendorInvPhoto
          : vendorInvPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      isJobWork: freezed == isJobWork
          ? _value.isJobWork
          : isJobWork // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewGateEntryFormImplCopyWith<$Res>
    implements $NewGateEntryFormCopyWith<$Res> {
  factory _$$NewGateEntryFormImplCopyWith(_$NewGateEntryFormImpl value,
          $Res Function(_$NewGateEntryFormImpl) then) =
      __$$NewGateEntryFormImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) String? status,
      @JsonKey(includeToJson: true, includeIfNull: false) String? name,
      @JsonKey(name: 'po_number') String? poNumber,
      @JsonKey(name: 'vehicle_no') String? vehicleNo,
      @JsonKey(name: 'vendor_invoice_no') String? vendorInvNo,
      @JsonKey(name: 'invoice_date') String? invoiceDate,
      @JsonKey(name: 'invoice_qty') String? invoiceQty,
      @JsonKey(name: 'invoice_amount') String? invoiceAmt,
      @JsonKey(name: 'entry_date') String entryDate,
      @JsonKey(name: 'vehicle_photo') String? vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
      @JsonKey(name: 'invoice_photo') String? vendorInvPhoto,
      @JsonKey(name: 'remarks') String? remarks,
      @JsonKey(name: 'custom_is_job_work') int? isJobWork});
}

/// @nodoc
class __$$NewGateEntryFormImplCopyWithImpl<$Res>
    extends _$NewGateEntryFormCopyWithImpl<$Res, _$NewGateEntryFormImpl>
    implements _$$NewGateEntryFormImplCopyWith<$Res> {
  __$$NewGateEntryFormImplCopyWithImpl(_$NewGateEntryFormImpl _value,
      $Res Function(_$NewGateEntryFormImpl) _then)
      : super(_value, _then);

  /// Create a copy of NewGateEntryForm
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? name = freezed,
    Object? poNumber = freezed,
    Object? vehicleNo = freezed,
    Object? vendorInvNo = freezed,
    Object? invoiceDate = freezed,
    Object? invoiceQty = freezed,
    Object? invoiceAmt = freezed,
    Object? entryDate = null,
    Object? vehiclePhoto = freezed,
    Object? vehicleBackPhoto = freezed,
    Object? vendorInvPhoto = freezed,
    Object? remarks = freezed,
    Object? isJobWork = freezed,
  }) {
    return _then(_$NewGateEntryFormImpl(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      poNumber: freezed == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleNo: freezed == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorInvNo: freezed == vendorInvNo
          ? _value.vendorInvNo
          : vendorInvNo // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceDate: freezed == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceQty: freezed == invoiceQty
          ? _value.invoiceQty
          : invoiceQty // ignore: cast_nullable_to_non_nullable
              as String?,
      invoiceAmt: freezed == invoiceAmt
          ? _value.invoiceAmt
          : invoiceAmt // ignore: cast_nullable_to_non_nullable
              as String?,
      entryDate: null == entryDate
          ? _value.entryDate
          : entryDate // ignore: cast_nullable_to_non_nullable
              as String,
      vehiclePhoto: freezed == vehiclePhoto
          ? _value.vehiclePhoto
          : vehiclePhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      vehicleBackPhoto: freezed == vehicleBackPhoto
          ? _value.vehicleBackPhoto
          : vehicleBackPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      vendorInvPhoto: freezed == vendorInvPhoto
          ? _value.vendorInvPhoto
          : vendorInvPhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      isJobWork: freezed == isJobWork
          ? _value.isJobWork
          : isJobWork // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewGateEntryFormImpl implements _NewGateEntryForm {
  const _$NewGateEntryFormImpl(
      {@JsonKey(includeToJson: false) this.status,
      @JsonKey(includeToJson: true, includeIfNull: false) this.name,
      @JsonKey(name: 'po_number') this.poNumber,
      @JsonKey(name: 'vehicle_no') this.vehicleNo,
      @JsonKey(name: 'vendor_invoice_no') this.vendorInvNo,
      @JsonKey(name: 'invoice_date') this.invoiceDate,
      @JsonKey(name: 'invoice_qty') this.invoiceQty,
      @JsonKey(name: 'invoice_amount') this.invoiceAmt,
      @JsonKey(name: 'entry_date') required this.entryDate,
      @JsonKey(name: 'vehicle_photo') this.vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') this.vehicleBackPhoto,
      @JsonKey(name: 'invoice_photo') this.vendorInvPhoto,
      @JsonKey(name: 'remarks') this.remarks,
      @JsonKey(name: 'custom_is_job_work') this.isJobWork});

  factory _$NewGateEntryFormImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewGateEntryFormImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final String? status;
  @override
  @JsonKey(includeToJson: true, includeIfNull: false)
  final String? name;
  @override
  @JsonKey(name: 'po_number')
  final String? poNumber;
  @override
  @JsonKey(name: 'vehicle_no')
  final String? vehicleNo;
  @override
  @JsonKey(name: 'vendor_invoice_no')
  final String? vendorInvNo;
  @override
  @JsonKey(name: 'invoice_date')
  final String? invoiceDate;
  @override
  @JsonKey(name: 'invoice_qty')
  final String? invoiceQty;
  @override
  @JsonKey(name: 'invoice_amount')
  final String? invoiceAmt;
  @override
  @JsonKey(name: 'entry_date')
  final String entryDate;
  @override
  @JsonKey(name: 'vehicle_photo')
  final String? vehiclePhoto;
  @override
  @JsonKey(name: 'vehicle_back_photo')
  final String? vehicleBackPhoto;
  @override
  @JsonKey(name: 'invoice_photo')
  final String? vendorInvPhoto;
  @override
  @JsonKey(name: 'remarks')
  final String? remarks;
  @override
  @JsonKey(name: 'custom_is_job_work')
  final int? isJobWork;

  @override
  String toString() {
    return 'NewGateEntryForm(status: $status, name: $name, poNumber: $poNumber, vehicleNo: $vehicleNo, vendorInvNo: $vendorInvNo, invoiceDate: $invoiceDate, invoiceQty: $invoiceQty, invoiceAmt: $invoiceAmt, entryDate: $entryDate, vehiclePhoto: $vehiclePhoto, vehicleBackPhoto: $vehicleBackPhoto, vendorInvPhoto: $vendorInvPhoto, remarks: $remarks, isJobWork: $isJobWork)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewGateEntryFormImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.poNumber, poNumber) ||
                other.poNumber == poNumber) &&
            (identical(other.vehicleNo, vehicleNo) ||
                other.vehicleNo == vehicleNo) &&
            (identical(other.vendorInvNo, vendorInvNo) ||
                other.vendorInvNo == vendorInvNo) &&
            (identical(other.invoiceDate, invoiceDate) ||
                other.invoiceDate == invoiceDate) &&
            (identical(other.invoiceQty, invoiceQty) ||
                other.invoiceQty == invoiceQty) &&
            (identical(other.invoiceAmt, invoiceAmt) ||
                other.invoiceAmt == invoiceAmt) &&
            (identical(other.entryDate, entryDate) ||
                other.entryDate == entryDate) &&
            (identical(other.vehiclePhoto, vehiclePhoto) ||
                other.vehiclePhoto == vehiclePhoto) &&
            (identical(other.vehicleBackPhoto, vehicleBackPhoto) ||
                other.vehicleBackPhoto == vehicleBackPhoto) &&
            (identical(other.vendorInvPhoto, vendorInvPhoto) ||
                other.vendorInvPhoto == vendorInvPhoto) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.isJobWork, isJobWork) ||
                other.isJobWork == isJobWork));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      name,
      poNumber,
      vehicleNo,
      vendorInvNo,
      invoiceDate,
      invoiceQty,
      invoiceAmt,
      entryDate,
      vehiclePhoto,
      vehicleBackPhoto,
      vendorInvPhoto,
      remarks,
      isJobWork);

  /// Create a copy of NewGateEntryForm
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NewGateEntryFormImplCopyWith<_$NewGateEntryFormImpl> get copyWith =>
      __$$NewGateEntryFormImplCopyWithImpl<_$NewGateEntryFormImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewGateEntryFormImplToJson(
      this,
    );
  }
}

abstract class _NewGateEntryForm implements NewGateEntryForm {
  const factory _NewGateEntryForm(
      {@JsonKey(includeToJson: false) final String? status,
      @JsonKey(includeToJson: true, includeIfNull: false) final String? name,
      @JsonKey(name: 'po_number') final String? poNumber,
      @JsonKey(name: 'vehicle_no') final String? vehicleNo,
      @JsonKey(name: 'vendor_invoice_no') final String? vendorInvNo,
      @JsonKey(name: 'invoice_date') final String? invoiceDate,
      @JsonKey(name: 'invoice_qty') final String? invoiceQty,
      @JsonKey(name: 'invoice_amount') final String? invoiceAmt,
      @JsonKey(name: 'entry_date') required final String entryDate,
      @JsonKey(name: 'vehicle_photo') final String? vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') final String? vehicleBackPhoto,
      @JsonKey(name: 'invoice_photo') final String? vendorInvPhoto,
      @JsonKey(name: 'remarks') final String? remarks,
      @JsonKey(name: 'custom_is_job_work')
      final int? isJobWork}) = _$NewGateEntryFormImpl;

  factory _NewGateEntryForm.fromJson(Map<String, dynamic> json) =
      _$NewGateEntryFormImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  String? get status;
  @override
  @JsonKey(includeToJson: true, includeIfNull: false)
  String? get name;
  @override
  @JsonKey(name: 'po_number')
  String? get poNumber;
  @override
  @JsonKey(name: 'vehicle_no')
  String? get vehicleNo;
  @override
  @JsonKey(name: 'vendor_invoice_no')
  String? get vendorInvNo;
  @override
  @JsonKey(name: 'invoice_date')
  String? get invoiceDate;
  @override
  @JsonKey(name: 'invoice_qty')
  String? get invoiceQty;
  @override
  @JsonKey(name: 'invoice_amount')
  String? get invoiceAmt;
  @override
  @JsonKey(name: 'entry_date')
  String get entryDate;
  @override
  @JsonKey(name: 'vehicle_photo')
  String? get vehiclePhoto;
  @override
  @JsonKey(name: 'vehicle_back_photo')
  String? get vehicleBackPhoto;
  @override
  @JsonKey(name: 'invoice_photo')
  String? get vendorInvPhoto;
  @override
  @JsonKey(name: 'remarks')
  String? get remarks;
  @override
  @JsonKey(name: 'custom_is_job_work')
  int? get isJobWork;

  /// Create a copy of NewGateEntryForm
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NewGateEntryFormImplCopyWith<_$NewGateEntryFormImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
