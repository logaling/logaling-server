module LogalingServer
  class << self
    def data_directory
      File.join(Rails.root, "data.#{Rails.env}")
    end

    def repository_base
      File.join(data_directory, 'repositories')
    end

    def logaling_home
      File.join(data_directory, '.logaling.d')
    end

    def repository
      @@repository ||= Logaling::Repository.new(logaling_home)
    end

    def create_data_directory!
      FileUtils.mkdir_p(repository_base)
      FileUtils.mkdir_p(logaling_home)
    end

    def flush_data_directory!
      FileUtils.rm_rf(repository_base)
      FileUtils.rm_rf(logaling_home)
      create_data_directory!
      @@repository = Logaling::Repository.new(logaling_home)
    end
  end
end
