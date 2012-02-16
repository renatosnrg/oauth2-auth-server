# require 'action_dispatch/routing/mapper'

module OAuth2
  module Auth
    module Server
      module ActionDispatch::Routing
        class Mapper
          def oauth2_token_endpoint(path = 'oauth2/token')
            post path, :to => proc { |env| Endpoints::Token.new.call(env) }
          end
        end
      end
    end
  end
end