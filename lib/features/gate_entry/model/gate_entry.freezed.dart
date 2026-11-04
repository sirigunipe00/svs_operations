// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gate_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GateEntry _$GateEntryFromJson(Map<String, dynamic> json) {
  return _GateEntry.fromJson(json);
}

/// @nodoc
mixin _$GateEntry {
  String get name => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'po_number')
  String get poNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_no', defaultValue: '')
  String get vehicleNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_invoice_no', defaultValue: '')
  String get vendorInvNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_date', defaultValue: '')
  String get invoiceDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_invoice_quantity')
  double? get invoiceQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'invoice_amount')
  double? get invoiceAmt => throw _privateConstructorUsedError;
  @JsonKey(name: 'gate_entry_date', defaultValue: '')
  String get entryDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_image')
  String? get vehiclePhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'vehicle_back_photo')
  String? get vehicleBackPhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_name')
  String? get vendorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_invoice_photo')
  String? get invoicePhoto => throw _privateConstructorUsedError;
  @JsonKey(name: 'remarks')
  String? get remarks => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_job_work')
  int? get isJobWork => throw _privateConstructorUsedError;
  @JsonKey(name: 'receive_mode')
  String? get receiveMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_name_person_name')
  String? get driverName => throw _privateConstructorUsedError;
  @JsonKey(name: 'driver_mobile_no_person_mobile_no')
  String? get driverMobileNo => throw _privateConstructorUsedError;
  @JsonKey(name: 'delivery_challan')
  String? get deliveryChallan => throw _privateConstructorUsedError;
  @JsonKey(name: 'lr_no')
  String? get lrNo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GateEntryCopyWith<GateEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GateEntryCopyWith<$Res> {
  factory $GateEntryCopyWith(GateEntry value, $Res Function(GateEntry) then) =
      _$GateEntryCopyWithImpl<$Res, GateEntry>;
  @useResult
  $Res call(
      {String name,
      String? status,
      @JsonKey(name: 'po_number') String poNumber,
      @JsonKey(name: 'vehicle_no', defaultValue: '') String vehicleNo,
      @JsonKey(name: 'vendor_invoice_no', defaultValue: '') String vendorInvNo,
      @JsonKey(name: 'invoice_date', defaultValue: '') String invoiceDate,
      @JsonKey(name: 'vendor_invoice_quantity') double? invoiceQty,
      @JsonKey(name: 'invoice_amount') double? invoiceAmt,
      @JsonKey(name: 'gate_entry_date', defaultValue: '') String entryDate,
      @JsonKey(name: 'vehicle_image') String? vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
      @JsonKey(name: 'vendor_name') String? vendorName,
      @JsonKey(name: 'vendor_invoice_photo') String? invoicePhoto,
      @JsonKey(name: 'remarks') String? remarks,
      @JsonKey(name: 'is_job_work') int? isJobWork,
      @JsonKey(name: 'receive_mode') String? receiveMode,
      @JsonKey(name: 'driver_name_person_name') String? driverName,
      @JsonKey(name: 'driver_mobile_no_person_mobile_no')
      String? driverMobileNo,
      @JsonKey(name: 'delivery_challan') String? deliveryChallan,
      @JsonKey(name: 'lr_no') String? lrNo});
}

/// @nodoc
class _$GateEntryCopyWithImpl<$Res, $Val extends GateEntry>
    implements $GateEntryCopyWith<$Res> {
  _$GateEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = freezed,
    Object? poNumber = null,
    Object? vehicleNo = null,
    Object? vendorInvNo = null,
    Object? invoiceDate = null,
    Object? invoiceQty = freezed,
    Object? invoiceAmt = freezed,
    Object? entryDate = null,
    Object? vehiclePhoto = freezed,
    Object? vehicleBackPhoto = freezed,
    Object? vendorName = freezed,
    Object? invoicePhoto = freezed,
    Object? remarks = freezed,
    Object? isJobWork = freezed,
    Object? receiveMode = freezed,
    Object? driverName = freezed,
    Object? driverMobileNo = freezed,
    Object? deliveryChallan = freezed,
    Object? lrNo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      poNumber: null == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      vendorInvNo: null == vendorInvNo
          ? _value.vendorInvNo
          : vendorInvNo // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceQty: freezed == invoiceQty
          ? _value.invoiceQty
          : invoiceQty // ignore: cast_nullable_to_non_nullable
              as double?,
      invoiceAmt: freezed == invoiceAmt
          ? _value.invoiceAmt
          : invoiceAmt // ignore: cast_nullable_to_non_nullable
              as double?,
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
      vendorName: freezed == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String?,
      invoicePhoto: freezed == invoicePhoto
          ? _value.invoicePhoto
          : invoicePhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      isJobWork: freezed == isJobWork
          ? _value.isJobWork
          : isJobWork // ignore: cast_nullable_to_non_nullable
              as int?,
      receiveMode: freezed == receiveMode
          ? _value.receiveMode
          : receiveMode // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverMobileNo: freezed == driverMobileNo
          ? _value.driverMobileNo
          : driverMobileNo // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryChallan: freezed == deliveryChallan
          ? _value.deliveryChallan
          : deliveryChallan // ignore: cast_nullable_to_non_nullable
              as String?,
      lrNo: freezed == lrNo
          ? _value.lrNo
          : lrNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GateEntryImplCopyWith<$Res>
    implements $GateEntryCopyWith<$Res> {
  factory _$$GateEntryImplCopyWith(
          _$GateEntryImpl value, $Res Function(_$GateEntryImpl) then) =
      __$$GateEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? status,
      @JsonKey(name: 'po_number') String poNumber,
      @JsonKey(name: 'vehicle_no', defaultValue: '') String vehicleNo,
      @JsonKey(name: 'vendor_invoice_no', defaultValue: '') String vendorInvNo,
      @JsonKey(name: 'invoice_date', defaultValue: '') String invoiceDate,
      @JsonKey(name: 'vendor_invoice_quantity') double? invoiceQty,
      @JsonKey(name: 'invoice_amount') double? invoiceAmt,
      @JsonKey(name: 'gate_entry_date', defaultValue: '') String entryDate,
      @JsonKey(name: 'vehicle_image') String? vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
      @JsonKey(name: 'vendor_name') String? vendorName,
      @JsonKey(name: 'vendor_invoice_photo') String? invoicePhoto,
      @JsonKey(name: 'remarks') String? remarks,
      @JsonKey(name: 'is_job_work') int? isJobWork,
      @JsonKey(name: 'receive_mode') String? receiveMode,
      @JsonKey(name: 'driver_name_person_name') String? driverName,
      @JsonKey(name: 'driver_mobile_no_person_mobile_no')
      String? driverMobileNo,
      @JsonKey(name: 'delivery_challan') String? deliveryChallan,
      @JsonKey(name: 'lr_no') String? lrNo});
}

/// @nodoc
class __$$GateEntryImplCopyWithImpl<$Res>
    extends _$GateEntryCopyWithImpl<$Res, _$GateEntryImpl>
    implements _$$GateEntryImplCopyWith<$Res> {
  __$$GateEntryImplCopyWithImpl(
      _$GateEntryImpl _value, $Res Function(_$GateEntryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = freezed,
    Object? poNumber = null,
    Object? vehicleNo = null,
    Object? vendorInvNo = null,
    Object? invoiceDate = null,
    Object? invoiceQty = freezed,
    Object? invoiceAmt = freezed,
    Object? entryDate = null,
    Object? vehiclePhoto = freezed,
    Object? vehicleBackPhoto = freezed,
    Object? vendorName = freezed,
    Object? invoicePhoto = freezed,
    Object? remarks = freezed,
    Object? isJobWork = freezed,
    Object? receiveMode = freezed,
    Object? driverName = freezed,
    Object? driverMobileNo = freezed,
    Object? deliveryChallan = freezed,
    Object? lrNo = freezed,
  }) {
    return _then(_$GateEntryImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      poNumber: null == poNumber
          ? _value.poNumber
          : poNumber // ignore: cast_nullable_to_non_nullable
              as String,
      vehicleNo: null == vehicleNo
          ? _value.vehicleNo
          : vehicleNo // ignore: cast_nullable_to_non_nullable
              as String,
      vendorInvNo: null == vendorInvNo
          ? _value.vendorInvNo
          : vendorInvNo // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceDate: null == invoiceDate
          ? _value.invoiceDate
          : invoiceDate // ignore: cast_nullable_to_non_nullable
              as String,
      invoiceQty: freezed == invoiceQty
          ? _value.invoiceQty
          : invoiceQty // ignore: cast_nullable_to_non_nullable
              as double?,
      invoiceAmt: freezed == invoiceAmt
          ? _value.invoiceAmt
          : invoiceAmt // ignore: cast_nullable_to_non_nullable
              as double?,
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
      vendorName: freezed == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String?,
      invoicePhoto: freezed == invoicePhoto
          ? _value.invoicePhoto
          : invoicePhoto // ignore: cast_nullable_to_non_nullable
              as String?,
      remarks: freezed == remarks
          ? _value.remarks
          : remarks // ignore: cast_nullable_to_non_nullable
              as String?,
      isJobWork: freezed == isJobWork
          ? _value.isJobWork
          : isJobWork // ignore: cast_nullable_to_non_nullable
              as int?,
      receiveMode: freezed == receiveMode
          ? _value.receiveMode
          : receiveMode // ignore: cast_nullable_to_non_nullable
              as String?,
      driverName: freezed == driverName
          ? _value.driverName
          : driverName // ignore: cast_nullable_to_non_nullable
              as String?,
      driverMobileNo: freezed == driverMobileNo
          ? _value.driverMobileNo
          : driverMobileNo // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryChallan: freezed == deliveryChallan
          ? _value.deliveryChallan
          : deliveryChallan // ignore: cast_nullable_to_non_nullable
              as String?,
      lrNo: freezed == lrNo
          ? _value.lrNo
          : lrNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GateEntryImpl implements _GateEntry {
  const _$GateEntryImpl(
      {required this.name,
      this.status,
      @JsonKey(name: 'po_number') required this.poNumber,
      @JsonKey(name: 'vehicle_no', defaultValue: '') required this.vehicleNo,
      @JsonKey(name: 'vendor_invoice_no', defaultValue: '')
      required this.vendorInvNo,
      @JsonKey(name: 'invoice_date', defaultValue: '')
      required this.invoiceDate,
      @JsonKey(name: 'vendor_invoice_quantity') this.invoiceQty,
      @JsonKey(name: 'invoice_amount') this.invoiceAmt,
      @JsonKey(name: 'gate_entry_date', defaultValue: '')
      required this.entryDate,
      @JsonKey(name: 'vehicle_image') this.vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') this.vehicleBackPhoto,
      @JsonKey(name: 'vendor_name') this.vendorName,
      @JsonKey(name: 'vendor_invoice_photo') this.invoicePhoto,
      @JsonKey(name: 'remarks') this.remarks,
      @JsonKey(name: 'is_job_work') this.isJobWork,
      @JsonKey(name: 'receive_mode') this.receiveMode,
      @JsonKey(name: 'driver_name_person_name') this.driverName,
      @JsonKey(name: 'driver_mobile_no_person_mobile_no') this.driverMobileNo,
      @JsonKey(name: 'delivery_challan') this.deliveryChallan,
      @JsonKey(name: 'lr_no') this.lrNo});

  factory _$GateEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$GateEntryImplFromJson(json);

  @override
  final String name;
  @override
  final String? status;
  @override
  @JsonKey(name: 'po_number')
  final String poNumber;
  @override
  @JsonKey(name: 'vehicle_no', defaultValue: '')
  final String vehicleNo;
  @override
  @JsonKey(name: 'vendor_invoice_no', defaultValue: '')
  final String vendorInvNo;
  @override
  @JsonKey(name: 'invoice_date', defaultValue: '')
  final String invoiceDate;
  @override
  @JsonKey(name: 'vendor_invoice_quantity')
  final double? invoiceQty;
  @override
  @JsonKey(name: 'invoice_amount')
  final double? invoiceAmt;
  @override
  @JsonKey(name: 'gate_entry_date', defaultValue: '')
  final String entryDate;
  @override
  @JsonKey(name: 'vehicle_image')
  final String? vehiclePhoto;
  @override
  @JsonKey(name: 'vehicle_back_photo')
  final String? vehicleBackPhoto;
  @override
  @JsonKey(name: 'vendor_name')
  final String? vendorName;
  @override
  @JsonKey(name: 'vendor_invoice_photo')
  final String? invoicePhoto;
  @override
  @JsonKey(name: 'remarks')
  final String? remarks;
  @override
  @JsonKey(name: 'is_job_work')
  final int? isJobWork;
  @override
  @JsonKey(name: 'receive_mode')
  final String? receiveMode;
  @override
  @JsonKey(name: 'driver_name_person_name')
  final String? driverName;
  @override
  @JsonKey(name: 'driver_mobile_no_person_mobile_no')
  final String? driverMobileNo;
  @override
  @JsonKey(name: 'delivery_challan')
  final String? deliveryChallan;
  @override
  @JsonKey(name: 'lr_no')
  final String? lrNo;

  @override
  String toString() {
    return 'GateEntry(name: $name, status: $status, poNumber: $poNumber, vehicleNo: $vehicleNo, vendorInvNo: $vendorInvNo, invoiceDate: $invoiceDate, invoiceQty: $invoiceQty, invoiceAmt: $invoiceAmt, entryDate: $entryDate, vehiclePhoto: $vehiclePhoto, vehicleBackPhoto: $vehicleBackPhoto, vendorName: $vendorName, invoicePhoto: $invoicePhoto, remarks: $remarks, isJobWork: $isJobWork, receiveMode: $receiveMode, driverName: $driverName, driverMobileNo: $driverMobileNo, deliveryChallan: $deliveryChallan, lrNo: $lrNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GateEntryImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
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
            (identical(other.vendorName, vendorName) ||
                other.vendorName == vendorName) &&
            (identical(other.invoicePhoto, invoicePhoto) ||
                other.invoicePhoto == invoicePhoto) &&
            (identical(other.remarks, remarks) || other.remarks == remarks) &&
            (identical(other.isJobWork, isJobWork) ||
                other.isJobWork == isJobWork) &&
            (identical(other.receiveMode, receiveMode) ||
                other.receiveMode == receiveMode) &&
            (identical(other.driverName, driverName) ||
                other.driverName == driverName) &&
            (identical(other.driverMobileNo, driverMobileNo) ||
                other.driverMobileNo == driverMobileNo) &&
            (identical(other.deliveryChallan, deliveryChallan) ||
                other.deliveryChallan == deliveryChallan) &&
            (identical(other.lrNo, lrNo) || other.lrNo == lrNo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        status,
        poNumber,
        vehicleNo,
        vendorInvNo,
        invoiceDate,
        invoiceQty,
        invoiceAmt,
        entryDate,
        vehiclePhoto,
        vehicleBackPhoto,
        vendorName,
        invoicePhoto,
        remarks,
        isJobWork,
        receiveMode,
        driverName,
        driverMobileNo,
        deliveryChallan,
        lrNo
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GateEntryImplCopyWith<_$GateEntryImpl> get copyWith =>
      __$$GateEntryImplCopyWithImpl<_$GateEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GateEntryImplToJson(
      this,
    );
  }
}

abstract class _GateEntry implements GateEntry {
  const factory _GateEntry(
      {required final String name,
      final String? status,
      @JsonKey(name: 'po_number') required final String poNumber,
      @JsonKey(name: 'vehicle_no', defaultValue: '')
      required final String vehicleNo,
      @JsonKey(name: 'vendor_invoice_no', defaultValue: '')
      required final String vendorInvNo,
      @JsonKey(name: 'invoice_date', defaultValue: '')
      required final String invoiceDate,
      @JsonKey(name: 'vendor_invoice_quantity') final double? invoiceQty,
      @JsonKey(name: 'invoice_amount') final double? invoiceAmt,
      @JsonKey(name: 'gate_entry_date', defaultValue: '')
      required final String entryDate,
      @JsonKey(name: 'vehicle_image') final String? vehiclePhoto,
      @JsonKey(name: 'vehicle_back_photo') final String? vehicleBackPhoto,
      @JsonKey(name: 'vendor_name') final String? vendorName,
      @JsonKey(name: 'vendor_invoice_photo') final String? invoicePhoto,
      @JsonKey(name: 'remarks') final String? remarks,
      @JsonKey(name: 'is_job_work') final int? isJobWork,
      @JsonKey(name: 'receive_mode') final String? receiveMode,
      @JsonKey(name: 'driver_name_person_name') final String? driverName,
      @JsonKey(name: 'driver_mobile_no_person_mobile_no')
      final String? driverMobileNo,
      @JsonKey(name: 'delivery_challan') final String? deliveryChallan,
      @JsonKey(name: 'lr_no') final String? lrNo}) = _$GateEntryImpl;

  factory _GateEntry.fromJson(Map<String, dynamic> json) =
      _$GateEntryImpl.fromJson;

  @override
  String get name;
  @override
  String? get status;
  @override
  @JsonKey(name: 'po_number')
  String get poNumber;
  @override
  @JsonKey(name: 'vehicle_no', defaultValue: '')
  String get vehicleNo;
  @override
  @JsonKey(name: 'vendor_invoice_no', defaultValue: '')
  String get vendorInvNo;
  @override
  @JsonKey(name: 'invoice_date', defaultValue: '')
  String get invoiceDate;
  @override
  @JsonKey(name: 'vendor_invoice_quantity')
  double? get invoiceQty;
  @override
  @JsonKey(name: 'invoice_amount')
  double? get invoiceAmt;
  @override
  @JsonKey(name: 'gate_entry_date', defaultValue: '')
  String get entryDate;
  @override
  @JsonKey(name: 'vehicle_image')
  String? get vehiclePhoto;
  @override
  @JsonKey(name: 'vehicle_back_photo')
  String? get vehicleBackPhoto;
  @override
  @JsonKey(name: 'vendor_name')
  String? get vendorName;
  @override
  @JsonKey(name: 'vendor_invoice_photo')
  String? get invoicePhoto;
  @override
  @JsonKey(name: 'remarks')
  String? get remarks;
  @override
  @JsonKey(name: 'is_job_work')
  int? get isJobWork;
  @override
  @JsonKey(name: 'receive_mode')
  String? get receiveMode;
  @override
  @JsonKey(name: 'driver_name_person_name')
  String? get driverName;
  @override
  @JsonKey(name: 'driver_mobile_no_person_mobile_no')
  String? get driverMobileNo;
  @override
  @JsonKey(name: 'delivery_challan')
  String? get deliveryChallan;
  @override
  @JsonKey(name: 'lr_no')
  String? get lrNo;
  @override
  @JsonKey(ignore: true)
  _$$GateEntryImplCopyWith<_$GateEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
