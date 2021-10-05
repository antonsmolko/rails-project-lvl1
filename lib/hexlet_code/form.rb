# frozen_string_literal: true

# HexletCode module
module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Label, 'hexlet_code/label'

  # Form class with form field collection
  class Form
    def initialize(inputs)
      @inputs = inputs
    end

    def build(action, method, inner)
      Tag.build('form', action: action, method: method) { %(\n#{inner}\n) }
    end

    def build_group(attrs)
      name = attrs.delete(:name)
      as = attrs.delete(:as)

      group = []
      group << Label.build(name) unless %w[submit reset hidden button].include?(attrs[:type])
      group << case as
               when :text then @inputs::Textarea.new(name, **attrs).build
               when :select then @inputs::Select.new(name, **attrs).build
               else @inputs::Base.new(name, **attrs).build
               end

      group.join("\n")
    end
  end
end
