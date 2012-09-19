#coding: utf-8
class Term
  include ActiveAttr::Model

  attribute :source_term, type: String, default: ''
  attribute :target_term, type: String, default: ''
  attribute :note, type: String, default: ''

  validates_presence_of :source_term, :target_term

  def self.set_value(hash_value)
    hash = hash_value.with_indifferent_access
    term = Term.new
    self.attributes.each do |key, value|
      term[key] = hash[key] if hash[key].present?
    end
    term
  end
end
