# typed: strict
# frozen_string_literal: true

module Types
  module Result
    class Success
      extend T::Sig
      extend T::Generic

      ValueType = type_member

      sig { returns(ValueType) }
      attr_reader :value

      sig { params(value: ValueType).void }
      def initialize(value)
        @value = value
      end
    end
  end
end
