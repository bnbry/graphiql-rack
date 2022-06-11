# frozen_string_literal: true

require "rack"
require "erb"

module GraphiQLRack
  class App
    DEFAULT_CONFIG = {
      endpoint: "/graphql"
    }
    FILE_NAME = "static.html"

    def self.call(env)
      new.call(env)
    end

    def initialize
      @static = File.read(File.join([File.dirname(__FILE__), FILE_NAME]))
    end

    def call(env)
      config = env.fetch("action_dispatch.request.path_parameters", DEFAULT_CONFIG)
      @static.gsub!("REPLACE_ENDPOINT", config[:endpoint])
      [200, { "Content-Type" => "text/html" }, [@static]]
    end
  end
end
