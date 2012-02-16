require 'active_record/connection_adapters/abstract/schema_definitions'

module Oauth2
  module Auth
    module Server
      module Schema

        def oauth2_client
          string :identifier, :secret, :name, :redirect_uri, :null => false
        end

        def oauth2_access_token
          belongs_to :client

          string :token, :null => false
          string :scope
          datetime :expires_at
        end

      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, Oauth2::Auth::Server::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, Oauth2::Auth::Server::Schema