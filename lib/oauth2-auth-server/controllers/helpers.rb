module OAuth2
  module Auth
    module Server
      module Controllers
        module Helpers
          extend ActiveSupport::Concern

          included do
            helper_method :current_token, :current_client
          end

          def current_token
            @current_token
          end

          def current_client
            @current_client
          end

          def require_oauth_token(options = {})
            @current_token = request.env[Rack::OAuth2::Server::Resource::ACCESS_TOKEN]
            @current_client = @current_token.client if @current_token
            raise Rack::OAuth2::Server::Resource::Bearer::Unauthorized unless @current_token
            raise Rack::OAuth2::Server::Resource::Bearer::Forbidden.new(:insufficient_scope) unless @current_token.has_scope?(options[:scope])
          end

          module ClassMethods
            def oauth_filter(options = {})
              scope = options.delete(:scope)
              before_filter options do |controller|
                controller.require_oauth_token(:scope => scope)
              end
            end
          end

        end
      end
    end
  end
end