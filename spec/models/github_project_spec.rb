require 'spec_helper'

describe GithubProject do
  def archived_test_repository_path(repository_name)
    File.join(File.expand_path(File.dirname(__FILE__)), "..", "data", "#{repository_name}.tar.gz")
  end

  def decompress_test_repository(repository_name)
    dest_dir = Dir.mktmpdir
    system "tar", "xfz", archived_test_repository_path(repository_name), "-C", dest_dir
    File.join(dest_dir, repository_name)
  end

  before do
    test_repository_path = decompress_test_repository("test_repository_using_logaling")
    subject.stub!(:remote_repository_url)
           .and_return(File.join(test_repository_path, '.git'))
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
