module Oauth2
  module Auth
    module Server
      module Models
        class AccessToken < ActiveRecord::Base
          cattr_accessor :default_lifetime
          self.default_lifetime = Oauth2::Auth::Server.default_lifetime

          belongs_to :client

          before_validation :setup, :on => :create
          before_validation :scope_to_string
          validates :client, :presence => true
          validates :token, :presence => true, :uniqueness => true

          scope :valid, lambda {
            where("expires_at is null or expires_at >= :date", :date => Time.now.utc)
          }

          def expires_in
            (expires_at - Time.now.utc).to_i if expires_at
          end

          def expired!
            self.expires_at = Time.now.utc
            self.save!
          end

          def has_scope?(scope)
            scope = Array(scope)
            scope.collect! {|a| a.to_s }
            current_scope = scope_to_array
            (scope - current_scope).empty?
          end

          def to_bearer_token
            Rack::OAuth2::AccessToken::Bearer.new(
              :access_token => self.token,
              :expires_in => self.expires_in,
              :scope => self.scope
            )
          end

          private

          def setup
            self.token = SecureToken.generate
            self.expires_at ||= self.default_lifetime.from_now if self.default_lifetime
          end

          def scope_to_string
            self.scope = self.scope.join(' ') if self.scope.is_a?(Array)
          end

          def scope_to_array
            (self.scope.split(' ') if self.scope.is_a?(String)) or []
          end
        end
      end
    end
  end
end