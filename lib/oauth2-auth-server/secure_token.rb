module Oauth2
  module Auth
    module Server
      module SecureToken
        def self.generate(bytes = 64)
          ActiveSupport::SecureRandom.base64(bytes)
        end
      end
    end
  end
end