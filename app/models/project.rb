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
  end
end
