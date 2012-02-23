namespace :loga do
  desc "Sychronize repositories"
  task :sync => :environment do
    GithubProject.all.each do |project|
      $stderr.puts "[#{project.full_name}] synchronizing..."
      project.sync!
      $stderr.puts "[#{project.full_name}] synchronized"
    end
  end

  desc "Execute loga index"
  task :index => :environment do
    LogalingServer.repository.index
  end
end
