# frozen_string_literal: true

require_relative "graphiql_rack/version"
require_relative "graphiql_rack/app"

module GraphiQLRack
  class Error < StandardError; end

  def self.call(env)
    ::GraphiQLRack::App.call(env)
  rescue StandardError => e
    error = ::GraphiQLRack::Error.new("#{e.message} caused by #{e.class.name}")
    error.set_backtrace(e.backtrace)
    raise error
  end
end
