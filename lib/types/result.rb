# typed: strict
# frozen_string_literal: true

module Types
  module Result
    extend T::Sig

    sig do
      type_parameters(:ValueType).params(
        value: T.type_parameter(:ValueType)
      ).returns(
        Success[T.type_parameter(:ValueType)]
      )
    end
    def success(value)
      Success.new(value)
    end

    sig do
      type_parameters(:ErrorType).params(
        error: T.type_parameter(:ErrorType)
      ).returns(
        Failure[T.type_parameter(:ErrorType)]
      )
    end
    def failure(error)
      Failure.new(error)
    end
  end
end
