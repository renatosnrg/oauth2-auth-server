require 'spec_helper'

describe Oauth2::Auth::Server do

  it 'has a non-null VERSION constant' do
    Oauth2::Auth::Server::VERSION.should_not be_nil
  end

end
