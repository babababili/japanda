require 'japanda'
require 'rest-client'

Dir["#{Dir.pwd}/lib/japanda/canvas_factory/*.rb"].each { |f| require f }
Dir["#{Dir.pwd}/lib/japanda/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.before(:all) do
    config.include Japanda
    config.include CanvasFactory

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'
  end
end