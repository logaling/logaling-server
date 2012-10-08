#coding: utf-8
class UserGlossary < ActiveRecord::Base
  class << self
    def find_by_term_and_user(term, user)
      return nil unless term.owner?(user)
      user.user_glossaries.with_name(term.glossary_name_without_user_id)
                          .of_bilingualr_pair(term.source_language, term.target_language)
                          .first
    end
  end

  attr_accessor :original_user_glossary_id

  attr_accessible :name, :source_language, :target_language, :description, :original_user_glossary_id

  belongs_to :user

  validates_presence_of :name, :source_language, :target_language, :user_id
  validates_uniqueness_of :name, scope: [:user_id, :source_language, :target_language]
  validate :original_user_glossary_id_must_exist,
    if: "original_user_glossary_id.present?",
    on: :create

  validates_each :source_language, :target_language do |record, attr, value|
    unless ISO_639.find_by_code(value)
      record.errors.add attr, 'には言語名コードを指定して下さい'
    end
  end

  after_create :create_personal_project!
  after_destroy :remove_personal_project!

  scope :with_name, lambda {|name|
    where(name: name)
  }

  scope :of_bilingualr_pair, lambda {|source_language, target_language|
    where(source_language: source_language, target_language: target_language)
  }

  def glossary_name
    "%05d-%s" % [user_id, name]
  end

  def add!(term)
    raise ArgumentError unless term.valid?

    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.add(term.source_term, term.target_term, term.note)
    glossary.index!

  rescue Logaling::TermError
    term.errors.add(:source_term, "term '#{term.source_term}: #{term.target_term}' already exists in '#{name}'")
    raise ArgumentError
  end

  def update(term, new_term)
    return if term == new_term
    raise ArgumentError unless new_term.valid?

    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.update(term.source_term, term.target_term, new_term.target_term, new_term.note)
    glossary.index!

  rescue Logaling::TermError
    term.errors.add(:target_term, "term '#{term.source_term}: #{new_term.target_term}' already exists in '#{name}'")
    raise ArgumentError
  end

  def delete(term)
    raise ArgumentError unless term.valid?

    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.delete(term.source_term, term.target_term)
    glossary.index!

  rescue Logaling::TermError
    term.errors.add(:target_term, "term '#{term.source_term}: #{term.target_term}' doesn't exists in '#{name}'")
    raise ArgumentError
  end

  def find_bilingual_pair(soruce_term, target_term)
    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary

    glossary.find_bilingual_pairs(soruce_term, target_term).first
  end

  def terms(annotation=nil)
    glossary = find_glossary
    raise Logaling::GlossaryNotFound unless glossary
    terms = glossary.terms(annotation).map { |term_attrs| GlossaryEntry.new(term_attrs) }
  end

  def set_original_user_glossary_id(user_glossary_id)
    if UserGlossary.find_by_id(user_glossary_id).present?
      @original_user_glossary_id = user_glossary_id
    end
  end

  def find_glossary
    LogalingServer.repository.find_glossary(glossary_name, source_language, target_language)
  end

  private
  def original_user_glossary_id_must_exist
    unless UserGlossary.find_by_id(@original_user_glossary_id).present?
      errors.add :original_user_glossary_id, "の指定が正しくありません"
    end
  end

  def create_personal_project!
    LogalingServer.repository.create_personal_project(glossary_name, source_language, target_language)
    copy_from_original_user_glossary!
  end

  def copy_from_original_user_glossary!
    if original_user_glossary_id.present?
      src_glossary = UserGlossary.find(original_user_glossary_id).find_glossary
      dest_glossary = find_glossary
      dest_glossary.merge!(src_glossary)
      dest_glossary.index!
    end
  end

  def remove_personal_project!
    LogalingServer.repository.remove_personal_project(glossary_name, source_language, target_language)
    LogalingServer.repository.index
  end
end
