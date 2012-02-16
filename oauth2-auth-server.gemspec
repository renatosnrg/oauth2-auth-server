# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "oauth2-auth-server/version"

Gem::Specification.new do |s|
  s.name        = "oauth2-auth-server"
  s.version     = OAuth2::Auth::Server::VERSION
  s.authors     = ["Renato Neves"]
  s.email       = ["renatosn_rg@yahoo.com.br"]
  s.homepage    = ""
  s.summary     = %q{An implementation of OAuth2 Authorization Server}
  s.description = %q{An implementation of OAuth2 Authorization Server}

  s.rubyforge_project = "oauth2-auth-server"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("rack-oauth2", "~> 0.14.0")
end
