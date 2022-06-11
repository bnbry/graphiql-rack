# encoding: UTF-8

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "standard/rake"

task default: %i[spec standard]

desc "Build the static GraphiQL Page"
task :build do
  require "fileutils"
  require "json"

  BUILD_DIR = "./bld"
  SOURCE_FILE_HTML = "./src/base.html"
  STATIC_FILE_HTML = "./lib/graphiql_rack/static.html"
  ASSETS = [
    { type: "style",  name: "./bld/node_modules/graphiql/graphiql.css" },
    { type: "script", name: "./bld/node_modules/react/umd/react.development.js" },
    { type: "script", name: "./bld/node_modules/react-dom/umd/react-dom.production.min.js" },
    { type: "script", name: "./bld/node_modules/graphiql/graphiql.js" },
  ]

  def reset_files
    FileUtils.rm_rf(BUILD_DIR)
    FileUtils.mkdir_p(BUILD_DIR)
    FileUtils.rm_rf(STATIC_FILE_HTML)
    FileUtils.touch(STATIC_FILE_HTML)
  end

  def fetch_dependencies
    FileUtils.cd(BUILD_DIR) do
      sh("npm init --force")
      sh("npm install react react-dom graphiql")
    end
  end

  def build_static_file
    first_html, last_html = File.read(SOURCE_FILE_HTML).split("<!-- REPLACE_ASSETS -->\n")

    assets = ASSETS.map do |file|
      <<~BLOCK
        <#{file[:type]}>
          #{File.read(file[:name])}
        </#{file[:type]}>
      BLOCK
    end

    File.write(STATIC_FILE_HTML, [first_html, assets, last_html].flatten.join)
  end

  def clear_dependencies
    FileUtils.rm_rf(BUILD_DIR)
  end

  reset_files
  fetch_dependencies
  build_static_file
  clear_dependencies
end
