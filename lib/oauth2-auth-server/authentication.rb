module Oauth2
  module Auth
    module Server
      module Authentication

        def self.included(base)
          base.send(:include, Authentication::HelperMethods)
          base.send(:include, Authentication::ControllerMethods)
        end

        def self.extended(base)
          base.send(:extend, Authentication::ClassMethods)
        end

        module HelperMethods
          def current_token
            @current_token
          end

          def current_client
            @current_client
          end
        end

        module ControllerMethods
          def require_oauth_token(options = {})
            @current_token = request.env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
            raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized unless @current_token
            raise Rack::OAuth2::Server::Resource::Bearer::Forbidden.new(:insufficient_scope) unless @current_token.has_scope?(options[:scope])
          end

          def require_oauth_client_token(options = {})
            require_oauth_token(options)
            raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized.new(:invalid_token, 'Client token is required') if @current_token.user
            @current_client = @current_token.client
          end
        end

        module ClassMethods
          def oauth_required(options = {})
            scope = options.delete(:scope)
            before_filter options do |controller|
              controller.require_oauth_token(:scope => scope)
            end
          end

          def oauth_client_required(options = {})
            scope = options.delete(:scope)
            before_filter options do |controller|
              controller.require_oauth_client_token(:scope => scope)
            end
          end
        end

      end
    end
  end
end