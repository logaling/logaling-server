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

  def sync!
    checkout!
    unless with_logaling?
      raise "Project does not have .logaling"
    end
    begin
      LOGALING.register(dot_logaling_path, logaling_name)
    rescue Logaling::GlossaryAlreadyRegistered
      # do nothing
    end
    LOGALING.index
  end

  def remove_repository!
    LOGALING.unregister(logaling_name)
    FileUtils.rm_rf(repository_path)
  end
end
