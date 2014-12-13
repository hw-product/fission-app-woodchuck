$LOAD_PATH.unshift File.expand_path(File.dirname(__FILE__)) + '/lib/'
require 'fission-app-woodchuck/version'
Gem::Specification.new do |s|
  s.name = 'fission-app-woodchuck'
  s.version = FissionApp::Woodchuck::VERSION.version
  s.summary = 'Fission App Woodchuck'
  s.author = 'Heavywater'
  s.email = 'fission@hw-ops.com'
  s.homepage = 'http://github.com/heavywater/fission-app-woodchuck'
  s.description = 'Fission application woodchuck integration'
  s.require_path = 'lib'
  s.files = Dir['{lib,app,config}/**/**/*'] + %w(fission-app-woodchuck.gemspec CHANGELOG.md)
end
