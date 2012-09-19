#coding: utf-8
class Term
  class << self
    def set_value(hash_value)
      hash = hash_value.with_indifferent_access
      term = Term.new
      self.attributes.each do |key, value|
        term[key] = hash[key] if hash[key].present?
      end
      term
    end

    def find(id)
      source_term, target_term = id_to_source_term_and_target_term(id)
      Term.new do |t|
        t.source_term = source_term
        t.target_term = target_term
      end
    end

    def id_to_source_term_and_target_term(id)
      id.split("source:")[1].split(" target:", 2)
    end
  end
  include ActiveAttr::Model

  attribute :source_term, type: String, default: ''
  attribute :target_term, type: String, default: ''
  attribute :note, type: String, default: ''

  validates_presence_of :source_term, :target_term

  def id
    "source:#{source_term} target:#{target_term}"
  end
end
