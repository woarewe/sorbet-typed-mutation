# typed: strict

class Service
  extend T::Sig

  include Types::Result

  LoginDuplicateError = Class.new(StandardError)
  NetworkError = Class.new(StandardError)
  ResultType = T.type_alias {
    T.any(
      Success[Types::Student],
      Failure[LoginDuplicateError],
      Failure[NetworkError],
    )
  }

  sig { params(student: Types::Student).returns(ResultType) }
  def call(student)
    if rand(100).odd?
      success(student)
    else
      if rand(100).odd?
        failure(LoginDuplicateError.new)
      else
        failure(NetworkError.new)
      end
    end
  end
end
