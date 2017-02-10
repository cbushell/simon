class SimonConfig

  def initialize(dir)
    @configs = {}

    Dir['config/*.json'].each do |file_name|
      config = JSON.parse(File.read(file_name))
      @configs[config_name_as_url(config['name'])] = config
    end
  end

  def config_for(url_path)
    @configs[url_path]
  end

  def config_names
    @configs.values.collect { |config| config['name'] }
  end

  private

  def config_name_as_url(config_name)
    config_name.downcase.gsub(/\s/, '')
  end

end