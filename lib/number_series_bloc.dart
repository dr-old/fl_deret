import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class NumberSeriesEvent extends Equatable {
  const NumberSeriesEvent();

  @override
  List<Object> get props => [];
}

class GenerateSeries1ToN extends NumberSeriesEvent {
  final int N;

  const GenerateSeries1ToN(this.N);

  @override
  List<Object> get props => [N];
}

class GenerateSeries1ToNTo1 extends NumberSeriesEvent {
  final int N;

  const GenerateSeries1ToNTo1(this.N);

  @override
  List<Object> get props => [N];
}

class GenerateSpecialSeries extends NumberSeriesEvent {
  final int N;

  const GenerateSpecialSeries(this.N);

  @override
  List<Object> get props => [N];
}

class GenerateSeriesWithReplacements extends NumberSeriesEvent {
  final int N;

  const GenerateSeriesWithReplacements(this.N);

  @override
  List<Object> get props => [N];
}

// State
abstract class NumberSeriesState extends Equatable {
  const NumberSeriesState();

  @override
  List<Object> get props => [];
}

class NumberSeriesInitial extends NumberSeriesState {}

class NumberSeriesLoading extends NumberSeriesState {}

class NumberSeriesLoaded extends NumberSeriesState {
  final String series;

  const NumberSeriesLoaded(this.series);

  @override
  List<Object> get props => [series];
}

class NumberSeriesError extends NumberSeriesState {
  final String message;

  const NumberSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

// NumberSeries Class
class NumberSeries {
  // Method untuk menghasilkan deret angka dari 1 sampai N
  String generateSeries1ToN(int N) {
    StringBuffer result = StringBuffer();
    for (int i = 1; i <= N; i++) {
      result.write(i);
    }
    return result.toString();
  }

  // Method untuk menghasilkan deret angka dari 1 sampai N lalu kembali ke 1
  String generateSeries1ToNTo1(int N) {
    StringBuffer result = StringBuffer();
    for (int i = 1; i <= N; i++) {
      result.write(i);
    }
    for (int i = N - 1; i >= 1; i--) {
      result.write(i);
    }
    return result.toString();
  }

  // Method untuk menghasilkan deret angka seperti 10 21 32 43 54
  String generateSpecialSeries(int N) {
    return List.generate(N, (index) {
      int number = 10 + index * 11;
      return '$number';
    }).join(' ');
  }

  // Method untuk menghasilkan deret angka dengan kelipatan 5 diganti LIMA dan kelipatan 7 diganti TUJUH
  String generateSeriesWithReplacements(int N) {
    StringBuffer result = StringBuffer();
    for (int i = 1; i <= N; i++) {
      if (i % 5 == 0) {
        result.write('LIMA');
      } else if (i % 7 == 0) {
        result.write('TUJUH');
      } else {
        result.write(i);
      }
    }
    return result.toString();
  }
}

// Bloc
class NumberSeriesBloc extends Bloc<NumberSeriesEvent, NumberSeriesState> {
  final NumberSeries numberSeries;

  NumberSeriesBloc(this.numberSeries) : super(NumberSeriesInitial()) {
    on<GenerateSeries1ToN>((event, emit) async {
      emit(NumberSeriesLoading());
      try {
        final series = numberSeries.generateSeries1ToN(event.N);
        emit(NumberSeriesLoaded(series));
      } catch (e) {
        emit(const NumberSeriesError('Failed to generate series'));
      }
    });

    on<GenerateSeries1ToNTo1>((event, emit) async {
      emit(NumberSeriesLoading());
      try {
        final series = numberSeries.generateSeries1ToNTo1(event.N);
        emit(NumberSeriesLoaded(series));
      } catch (e) {
        emit(const NumberSeriesError('Failed to generate series'));
      }
    });

    on<GenerateSpecialSeries>((event, emit) async {
      emit(NumberSeriesLoading());
      try {
        final series = numberSeries.generateSpecialSeries(event.N);
        emit(NumberSeriesLoaded(series));
      } catch (e) {
        emit(const NumberSeriesError('Failed to generate series'));
      }
    });

    on<GenerateSeriesWithReplacements>((event, emit) async {
      emit(NumberSeriesLoading());
      try {
        final series = numberSeries.generateSeriesWithReplacements(event.N);
        emit(NumberSeriesLoaded(series));
      } catch (e) {
        emit(const NumberSeriesError('Failed to generate series'));
      }
    });
  }
}
