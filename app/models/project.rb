module Project
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
end
