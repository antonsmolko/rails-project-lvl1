# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode module
module HexletCode
  autoload :RenderForm, 'hexlet_code/render_form'

  @inputs = []
  @entity = nil

  def self.input(name, **attrs)
    return unless @entity.key?(name)

    @inputs << { name: name, value: @entity[name], **attrs }
  end

  def self.submit(value = 'Save')
    @inputs << { name: 'commit', value: value, type: 'submit' }
  end

  def self.form_for(entity, url: '#')
    @entity = entity.to_h
    @inputs = []

    yield self

    RenderForm.build(@inputs, 'post', url)
  end
end
