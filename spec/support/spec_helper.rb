#frozen_string_literal: true

module SpecHelper
  extend self

  # Requires supporting ruby files with custom matchers and macros, etc, in spec/support/ and its subdirectories.
  def load_support_files(*engines)
    each_engine(engines) do |engine_root_path|
      support_files_path = engine_root_path.join('spec/support/**/*.rb')
      Dir[support_files_path].each {|f| require f }
    end
  end

  # Requires factories for an engine in spec/factories/ and loads its definitions.
  def load_factories(*engines)
    each_engine(engines) do |engine_root_path|
      factories_path = engine_root_path.join('spec/factories')
      FactoryBot.definition_file_paths += Dir[factories_path]
    end
    FactoryBot.find_definitions
  end

  private

  def each_engine(engines = [])
    engines.each do |engine|
      engine_name = "#{engine.to_s.classify}::Engine".constantize
      yield engine_name.root
    end
  end
end