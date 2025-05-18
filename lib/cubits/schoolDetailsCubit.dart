import 'package:equatable/equatable.dart';
import 'package:eschool/data/models/schoolDetails.dart';
import 'package:eschool/data/repositories/schoolDetailsRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SchooldetailsState extends Equatable {}

class SchooldetailsInitial extends SchooldetailsState {
  @override
  List<Object?> get props => [];
}

class SchooldetailsFetchInProgress extends SchooldetailsState {
  @override
  List<Object?> get props => [];
}

class SchooldetailsFetchSuccess extends SchooldetailsState {
  final SchoolDetails schoolDetails;

  SchooldetailsFetchSuccess({required this.schoolDetails});
  @override
  List<Object?> get props => [schoolDetails];
}

class SchooldetailsFetchFailure extends SchooldetailsState {
  final String errorMessage;

  SchooldetailsFetchFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class SchooldetailsCubit extends Cubit<SchooldetailsState> {
  SchooldetailsCubit() : super(SchooldetailsInitial());

  Future<void> fetchSchooldetails() async {
    emit(SchooldetailsFetchInProgress());
    try {
      emit(
        SchooldetailsFetchSuccess(
          schoolDetails: await Schooldetailsfetch.fetchSchoolDetails(),
        ),
      );
    } catch (e, st) {
      print(st);
      emit(SchooldetailsFetchFailure(e.toString()));
    }
  }
}
