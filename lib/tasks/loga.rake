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

  desc "Import external glossaries"
  task :import => :environment do
    require 'logaling/external_glossary'
    Logaling::ExternalGlossary.load
    glossaries = Logaling::ExternalGlossary.list
    supported_glossaries = glossaries - [Logaling::Tmx]
    supported_glossaries.each do |glossary_class|
      LogalingServer.repository.import glossary_class.new
    end
    LogalingServer.repository.index
  end
end
