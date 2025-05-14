abstract class Result {}

class ResultSuccess extends Result {
  final String verificationId;
  final String identityId;
  ResultSuccess(this.verificationId, this.identityId);
}

class ResultCancelled extends Result {
  final String verificationId;
  final String identityId;
  ResultCancelled(this.verificationId, this.identityId);
}

class ResultCreated extends Result {
  final String verificationId;
  final String identityId;
  ResultCreated(this.verificationId, this.identityId);
}
