require 'spec_helper'

describe GithubProject, 'using logaling' do
  subject do
    GithubProject.create(:owner => 'logaling', :name => 'logaling-server')
  end

  before do
    subject.stub!(:remote_repository_url)
           .and_return(File.join(Rails.root, '.git'))
  end

  context 'synchronizing with the repository for the first time' do
    before do
      subject.sync!
    end

    it do
      subject.should be_with_logaling
    end
  end

  context 'synchronizing with the repository twice' do
    before do
      subject.sync!
      subject.sync!
    end

    it do
      subject.should be_with_logaling
    end
  end
end
