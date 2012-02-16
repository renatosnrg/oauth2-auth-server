require 'rails'
require 'rack/oauth2'
require 'oauth2-auth-server/version'

module OAuth2
  module Auth
    module Server
      autoload :SecureToken, 'oauth2-auth-server/secure_token'

      module Endpoints
        autoload :Authorize, 'oauth2-auth-server/endpoints/authorize'
        autoload :Token, 'oauth2-auth-server/endpoints/token'
      end

      module Controllers
        autoload :Helpers, 'oauth2-auth-server/controllers/helpers'
      end

      module Models
        autoload :AccessToken, 'oauth2-auth-server/models/access_token'
        autoload :Client, 'oauth2-auth-server/models/client'
      end

      mattr_accessor :default_lifetime
      @@default_lifetime = nil

      def self.setup
        yield self
      end

      def self.use_middleware(type)
        token_type = case type
          when :bearer then Rack::OAuth2::Server::Resource::Bearer
          else raise("Token type '#{type}' is not supported")
        end
        Rails.application.config.middleware.use token_type, 'Rack::OAuth2 Protected Resources' do |req|
          AccessToken.valid.find_by_token(req.access_token) || req.invalid_token!
        end
      end

      def self.include_helpers
        ActiveSupport.on_load(:action_controller) do
          include Controllers::Helpers
        end
      end
    end
  end
end

require 'oauth2-auth-server/rails'
