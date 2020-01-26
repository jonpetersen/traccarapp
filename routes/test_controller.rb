class TestController < Sinatra::Base

  get '/' do
    protected!
    haml :docs, :layout => false
  end

end
