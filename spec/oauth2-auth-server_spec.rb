require 'spec_helper'

describe OAuth2::Auth::Server do

  it 'has a non-null VERSION constant' do
    OAuth2::Auth::Server::VERSION.should_not be_nil
  end

end
