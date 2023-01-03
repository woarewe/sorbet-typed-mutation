require 'bundler/setup'

Bundler.require(:default)

loader = Zeitwerk::Loader.new
loader.push_dir('./lib')
loader.setup

p Mutation.new.resolve({})
p Mutation.new.resolve({ name: 'abc', login: 'abc', password: 'asdf' })
