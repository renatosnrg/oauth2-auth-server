require 'active_record/connection_adapters/abstract/schema_definitions'

module OAuth2
  module Auth
    module Server
      module Schema

        # Helper to create clients schema:
        #
        #   create_table :clients do |t|
        #     t.oauth2_client
        #     t.timestamps :null => false
        #   end
        #
        def oauth2_client
          string :identifier, :secret, :name, :redirect_uri, :null => false
        end

        # Helper to create access_tokens schema:
        #
        #   create_table :access_tokens do |t|
        #     t.oauth2_access_token
        #     t.timestamps :null => false
        #   end
        #
        def oauth2_access_token
          belongs_to :client, :null => false

          string :token, :null => false
          string :scope
          datetime :expires_at
        end

      end
    end
  end
end

ActiveRecord::ConnectionAdapters::Table.send :include, OAuth2::Auth::Server::Schema
ActiveRecord::ConnectionAdapters::TableDefinition.send :include, OAuth2::Auth::Server::Schema