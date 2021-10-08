# frozen_string_literal: true

# HexletCode module
module HexletCode
  autoload :Tag, 'hexlet_code/tag'
  autoload :Label, 'hexlet_code/label'

  # Form class with form field collection
  class Form
    def build(action, method, inner)
      Tag.build('form', action: action, method: method) { %(\n#{inner}\n) }
    end

    def build_group(attrs)
      name = attrs.delete(:name)
      type = attrs.delete(:as) || :string

      input_klass = "#{type.to_s.capitalize}Input"
      klass = Object.const_get "HexletCode::Inputs::#{input_klass}"

      group = []
      group << Label.build(name) unless %w[submit reset hidden button].include?(attrs[:type])

      group << klass.new(name, **attrs).build

      group.join("\n")
    end
  end
end
