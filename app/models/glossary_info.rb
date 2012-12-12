#coding: utf-8

class GlossaryInfo
  class << self
    #extected_format: "(project_name)/(source_language)-(target_language)"
    def new_by_formatted_string(formatted_string)
      project_name, bilingual_pair = formatted_string.split('/', 2)
      source_language, target_language = bilingual_pair.split('-', 2)
      new(project_name: project_name, source_language: source_language, target_language: target_language)
    end
  end
  include ActiveAttr::Model

  attribute :project_name,    type: String, default: ''
  attribute :source_language, type: String, default: ''
  attribute :target_language, type: String, default: ''
end
