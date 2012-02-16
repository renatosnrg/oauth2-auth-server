module OAuth2
  module Auth
    module Server
      module Models
        class Client < ActiveRecord::Base
          has_many :access_tokens

          before_validation :setup, :on => :create
          validates :name, :redirect_uri, :secret, :presence => true
          validates :identifier, :presence => true, :uniqueness => true

          private

          def setup
            self.identifier = SecureToken.generate(16)
            self.secret = SecureToken.generate
          end
        end
      end
    end
  end
end
