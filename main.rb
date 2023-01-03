require 'bundler/setup'

Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.push_dir('./lib')
loader.setup

Types::Student.new(
  name: 'John',
  login: 'sadfa',
  password: 'John'
)
