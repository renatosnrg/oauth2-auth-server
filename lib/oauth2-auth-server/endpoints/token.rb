module OAuth2
  module Auth
    module Server
      module Endpoints
        class Token

          def call(env)
            authenticator.call(env)
          end

          private

          def authenticator
            Rack::OAuth2::Server::Token.new do |req, res|
              client = Client.find_by_identifier(req.client_id) || req.invalid_client!
              client.secret == req.client_secret || req.invalid_client!
              case req.grant_type
                when :authorization_code
                  req.unsupported_grant_type!
                when :password
                  req.unsupported_grant_type!
                when :client_credentials
                  # scope is a list of space delimited scopes. Rack::OAuth2 converts to an array.
                  res.access_token = client.access_tokens.create(:scope => req.scope).to_bearer_token
                when :refresh_token
                  req.unsupported_grant_type!
                else
                  # NOTE: extended assertion grant_types are not supported yet.
                  req.unsupported_grant_type!
              end
            end
          end

        end
      end
    end
  end
end