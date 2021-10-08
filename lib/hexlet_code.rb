# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode module
module HexletCode
  autoload :GenerateForm, 'hexlet_code/generate_form'
  autoload :RenderForm, 'hexlet_code/render_form'

  def self.form_for(entity, url: '#')
    form_generator = GenerateForm.new(entity.to_h)

    yield form_generator

    RenderForm.build(form_generator.inputs, 'post', url)
  end
end
