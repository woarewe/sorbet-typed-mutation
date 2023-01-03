# typed: strict
# frozen_string_literal: true

module Types
  class Password < String
    extend T::Sig

    extend Result

    private_class_method :new

    Error = Class.new(StandardError)
    EmptyValueError = Class.new(Error)

    sig { params(value: String).returns(T.attached_class) }
    def self.build!(value)
      value = value.strip
      validate_presence!(value)

      new(value)
    end

    sig do
      params(value: String).returns(
        T.any(Result::Success[T.attached_class], Result::Failure[EmptyValueError])
      )
    end
    def self.build(value)
      success(build!(value))
    rescue EmptyValueError => error
      failure(error)
    end

    sig { params(value: String).void }
    def self.validate_presence!(value)
      raise EmptyValueError if value.empty?
    end
  end
end
