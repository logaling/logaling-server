require 'spec_helper'

describe GithubProject do
  before do
    # FIXME: Because fail 'git clone' on travis, so this line is commentted out.
    #  see:
    #  http://stackoverflow.com/questions/4770532/error-when-cloning-git-shallow-repository
    #subject.stub!(:remote_repository_url)
    #       .and_return(File.join(Rails.root, '.git'))
  end

  describe 'using logaling' do
    subject do
      GithubProject.new(:owner => 'logaling', :name => 'logaling-server')
    end

    it do
      subject.should be_valid
    end

    it 'should have local repository after validation' do
      subject.valid?
      subject.should be_cloned
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

  describe 'not using logaling' do
    subject do
      GithubProject.new(:owner => 'logaling', :name => 'logaling-server')
    end

    before do
      subject.stub!(:with_logaling?).and_return(false)
    end

    it do
      subject.should_not be_valid
    end

    it 'should not have local repository after validation' do
      subject.valid?
      subject.should_not be_cloned
    end
  end
end
