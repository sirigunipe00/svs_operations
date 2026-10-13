
import 'package:equatable/equatable.dart';

class PageListFilters extends Equatable {
  const PageListFilters({required this.status, this.query});

  final String status;
  final String? query;
  
  @override
  List<Object?> get props => [status, query];

  factory PageListFilters.initial() => const PageListFilters(status: 'Draft');

  PageListFilters copyWith({
    String? status,
    String? query,
  }) => PageListFilters(status: status ?? this.status, query: query ?? this.query);
}