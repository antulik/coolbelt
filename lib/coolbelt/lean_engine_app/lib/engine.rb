module LeanEngineApp
  def self.models_paths
    app_paths("app/models")
  end

  def self.components_paths
    app_paths("app/components")
  end

  def self.app_paths(path)
    Rails.root.glob("apps/*/#{path}")
  end

  def self.load_engines
    Rails.root.glob("apps/*/lib/engine.rb").each do |path|
      require(path.to_s)
    end
  end

  class Engine < Rails::Engine
    config.before_configuration do
      LeanEngineApp.load_engines
    end

    config.before_initialize do
      LeanEngineApp.app_paths("test/components/previews").each do |path|
        config.view_component.preview_paths << path.to_s
      end

      config.action_mailer.preview_paths.concat(LeanEngineApp.app_paths("test/mailers/previews"))

      if config.respond_to?(:factory_bot)
        config.factory_bot.definition_file_paths += LeanEngineApp.app_paths("test/factories")
      end
    end

    # initializer "lean_engine.set_code_stats_path" do
    #   Rails::CodeStatistics::DIRECTORIES.each do |name, folder|
    #     LeanEngineApp.app_paths(folder).each do |path|
    #       prefix = path.relative_path_from(Rails.root).each_filename.to_a.second
    #
    #       Rails::CodeStatistics.register_directory("#{prefix} #{name}", path)
    #     end
    #   end
    # end
  end
end
