#coding: utf-8
module LogalingServer
  class Term
    include ActiveAttr::Model

    attribute :source_term, type: String, default: ''
    attribute :target_term, type: String, default: ''
    attribute :note, type: String, default: ''

    validates_presence_of :source_term, :target_term
  end
end

