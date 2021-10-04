# frozen_string_literal: true

require_relative 'tag'
require_relative 'input'
require_relative 'select'
require_relative 'textarea'
require_relative 'label'

module HexletCode
  # Form class with form field collection
  class Form
    def self.build(action, method, inner)
      Tag.build('form', action: action, method: method) { inner }
    end

    def self.build_group(name, **attrs)
      as = attrs.delete(:as)

      control = case as
                when :text then Textarea.build(name, **attrs)
                when :select then Select.build(name, **attrs)
                else Input.build(name, **attrs)
                end

      label = Label.build(name)

      %(#{label}\n#{control})
    end

    def self.build_submit(value)
      Input.build('commit', value: value, type: 'submit')
    end
  end
end
