module GitBackended
  def checkout!
    raise "not valid" unless valid?

    if File.directory?(repository_path)
      Dir.chdir(repository_path) do
        unless system "git", "reset", "--hard"
          raise "reset failed"
        end
        unless system "git", "pull", "--force"
          raise "pull failed"
        end
      end
    else
      FileUtils.mkdir_p(repository_path)
      Dir.chdir(repository_path) do
        unless system "git", "clone", remote_repository_url, repository_path
          raise "clone failed"
        end
      end
    end
  end
end
