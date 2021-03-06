#coding: utf-8
class User < ActiveRecord::Base
  class << self
    def create_with_omniauth!(auth)
      create! do |user|
        user.provider = auth[:provider]
        user.uid      = auth[:uid]
        user.name     = auth[:info][:name]
      end
    end
  end

  attr_accessible :name, :provider, :uid

  has_many :user_glossaries, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :github_projects, :through => :memberships, :uniq => true
  has_one :user_config, :dependent => :destroy

  validates_presence_of :name, :uid, :provider
  validates_uniqueness_of :name
  validates_format_of :name, with: /^[a-zA-Z0-9_-]+$/,
                             message: "には英数字とハイフン (-)、アンダースコア (_) が使えます"

  def to_param
    name
  end

  def priority_glossary
    user_config ? user_config.glossary : nil
  end

  def own?(user_glossary)
    user_glossaries.include?(user_glossary)
  end

  def find_glossary(glossary_id)
    name, bilingualr_pair = glossary_id.split('/', 2)
    source_language, target_language = bilingualr_pair.split('-', 2)
    glossary = user_glossaries.with_name(name).of_bilingualr_pair(source_language, target_language).first
    unless glossary
      raise ActiveRecord::RecordNotFound
    end
    glossary
  end
end
