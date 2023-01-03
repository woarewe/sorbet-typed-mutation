# typed: strict

class Mutation
  extend T::Sig

  sig { params(input: T::Hash[Symbol, String]).returns(T::Hash[Symbol, String]) }
  def resolve(input)
    build_payload(input) do |payload|
      execute_service(payload)
    end
  end

  private

  sig do
    params(
      input: T::Hash[Symbol, String],
      block: T.proc.params(arg0: Types::Student).returns(
        T::Hash[Symbol, String]
      )
    ).returns(
      T::Hash[Symbol, String]
    )
  end
  def build_payload(input, &block)
    name, errors = get_name(input)
    login, errors = get_login(input, errors)
    password, errors = get_password(input, errors)

    if name && login && password
      return block.call Types::Student.new(
        name:,
        login:,
        password:
      )
    else
      { errors: }
    end
  end


  sig do
    params(
      input: T::Hash[Symbol, String],
      errors: T::Hash[Symbol, String]
    ).returns(
      [
        T.nilable(Types::Name),
        T::Hash[Symbol, String],
      ]
    )
  end
  def get_name(input, errors = {})
    [Types::Name.build!(input.fetch(:name)), errors]
  rescue KeyError
    [nil, errors.merge(name: 'Value is not provided')]
  rescue Types::Name::EmptyValueError
    [nil, errors.merge(name: 'Value is empty')]
  end

  sig do
    params(
      input: T::Hash[Symbol, String],
      errors: T::Hash[Symbol, String]
    ).returns(
      [
        T.nilable(Types::Login),
        T::Hash[Symbol, String],
      ]
    )
  end
  def get_login(input, errors = {})
    [Types::Login.build!(input.fetch(:login)), errors]
  rescue KeyError
    [nil, errors.merge(login: 'Value is not provided')]
  rescue Types::Login::EmptyValueError
    [nil, errors.merge(login: 'Value is empty')]
  end

  sig do
    params(
      input: T::Hash[Symbol, String],
      errors: T::Hash[Symbol, String]
    ).returns(
      [
        T.nilable(Types::Password),
        T::Hash[Symbol, String],
      ]
    )
  end
  def get_password(input, errors = {})
    [Types::Password.build!(input.fetch(:password)), errors]
  rescue KeyError
    [nil, errors.merge(password: 'Value is not provided')]
  rescue Types::Password::EmptyValueError
    [nil, errors.merge(password: 'Value is empty')]
  end

  sig { params(payload: Types::Student).returns(T::Hash[Symbol, String]) }
  def execute_service(payload)
    result = Service.new.call(payload)
    case result
    when Types::Result::Success
      { value: result.value.serialize }
    when Types::Result::Failure
      error = result.error
      case error
      when Service::LoginDuplicateError
        { errors: { login: 'Duplicated' } }
      when Service::NetworkError
        { errors: { other: 'Network error' } }
      end
    end
  end
end
