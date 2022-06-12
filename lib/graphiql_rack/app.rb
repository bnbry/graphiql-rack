# frozen_string_literal: true

module GraphiQLRack
  class App
    DEFAULT_CONFIG = {
      endpoint: "/graphql"
    }
    FILE_NAME = "static.html"
    RAILS_PARAMS = "action_dispatch.request.path_parameters"

    def self.call(env)
      body = File.read(File.join([File.dirname(__FILE__), FILE_NAME]))
      config = env.fetch(RAILS_PARAMS, DEFAULT_CONFIG)
      body.gsub!("REPLACE_ENDPOINT", config[:endpoint])

      [200, { "Content-Type" => "text/html" }, [body]]
    end
  end
end
