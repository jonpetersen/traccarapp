# Main initializer to load required libraries
require_relative 'configs/initializer'

# App Router
Traccarapp = Rack::Builder.new do

  # CMS
  # map "/cms" do
  #   map("/")   {run CmsController.new }
  # end

  map("/traccar") {run TraccarController.new }
  map("/docs")    {run DocsController.new }
  map("/test")    {run TestController.new }
  map("/")        {run MainController.new }
  
end

run Traccarapp
