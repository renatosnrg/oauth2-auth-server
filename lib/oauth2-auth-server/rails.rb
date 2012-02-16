require 'oauth2-auth-server/schema'
require 'oauth2-auth-server/routes'

module OAuth2
  module Auth
    module Server
      class Engine < ::Rails::Engine
        initializer "oauth2-auth-server.include_helpers" do
          OAuth2::Auth::Server.include_helpers
        end
      end
    end
  end
end