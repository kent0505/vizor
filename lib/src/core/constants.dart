import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class Constants {
  static double padding = 16;
}

abstract final class AppFonts {
  static const w400 = 'w400';
  static const w500 = 'w500';
  static const w600 = 'w600';
  static const w700 = 'w700';
}

abstract final class Assets {
  static const back = 'assets/back.svg';
  static const home1 = 'assets/home1.svg';
  static const home2 = 'assets/home2.svg';
  static const favorite1 = 'assets/favorite1.svg';
  static const favorite2 = 'assets/favorite2.svg';
  static const settings1 = 'assets/settings1.svg';
  static const settings2 = 'assets/settings2.svg';
}

abstract final class Keys {
  static const onboard = 'onboard';
  static const token = 'token';
  static const role = 'role';
  static const city = 'city';
}

abstract final class Env {
  static final baseUrl = dotenv.env['BASE_URL'] ?? '';
  static final s3Url = dotenv.env['S3_URL'] ?? '';
  static final s3Bucket = dotenv.env['S3_BUCKET'] ?? '';
}

/* 
abstract interface class OnboardRepository {
  const OnboardRepository();

  Future<void> removeOnboard();
}

final class OnboardRepositoryImpl implements OnboardRepository {
  OnboardRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  @override
  Future<void> removeOnboard() async {}
}
*/

/*
class TestBloc extends Bloc<TestEvent, TestState> {
  final TestRepository _repository;

  TestBloc({required TestRepository repository})
      : _repository = repository,
        super(TestInitial()) {
    on<TestEvent>(
      (event, emit) => switch (event) {
        LoadTest() => _loadTest(event, emit),
      },
    );
  }

  void _loadTest(
    LoadTest event,
    Emitter<TestState> emit,
  ) {
    logger(_repository.isTest());
  }
}
*/
