# typed: strict
# frozen_string_literal: true

module Types
  module Result
    class Failure
      extend T::Sig
      extend T::Generic

      ErrorType = type_member

      sig { returns(ErrorType) }
      attr_reader :error

      sig { params(error: ErrorType).void }
      def initialize(error)
        @error = error
      end
    end
  end
end
