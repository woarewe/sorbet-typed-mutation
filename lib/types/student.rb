# typed: strict

module Types
  class Student < T::Struct
    const :name, Name
    const :login, Login
    const :password, Password
  end
end
