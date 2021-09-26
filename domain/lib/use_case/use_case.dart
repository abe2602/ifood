import 'package:domain/exceptions.dart';
import 'package:meta/meta.dart';

abstract class UseCase<Params, Response> {
  @protected
  Future<Response> getRawFuture(Params? params);

  Future<Response> call({Params? params = null}) {
    try {
      return getRawFuture(params);
    } catch(error) {
      if (error is! ChallengeException) {
        throw GenericException();
      } else {
        rethrow;
      }
    }
  }
}