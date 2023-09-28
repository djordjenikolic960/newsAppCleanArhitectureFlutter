
//since every use case will have call method it is good to create one abstract class for it
abstract class UseCase<Type, Params> {
  Future<Type> call({Params params});
}
