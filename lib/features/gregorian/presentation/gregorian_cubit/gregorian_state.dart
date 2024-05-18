abstract class GregorianState {}

final class GregorianInitial extends GregorianState {}

final class GetGregorianYearSuccess extends GregorianState {}

final class GetGregorianYearFailure extends GregorianState {
  final String errMessage;

  GetGregorianYearFailure(this.errMessage);
}

final class GetGregorianYearLocalSuccess extends GregorianState {}


final class ChangeMonth extends GregorianState {}
