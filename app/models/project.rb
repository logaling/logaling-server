module Project
  def self.included(klass)
    klass.set_callback :destroy, :before, :remove_repository!
  end

  def dot_logaling_path
    File.join(repository_path, '.logaling')
  end

  def with_logaling?
    File.directory?(dot_logaling_path)
  end

  def register!
    begin
      LogalingServer.repository.register(dot_logaling_path, logaling_name)
    rescue Logaling::GlossaryAlreadyRegistered
      # do nothing
    end
    LogalingServer.repository.index
  end

  def sync!
    checkout!
    unless with_logaling?
      raise "Project does not have .logaling"
    end
    register!
  end

  def remove_repository!
    LogalingServer.repository.unregister(logaling_name)
    FileUtils.rm_rf(repository_path)
  end
end
