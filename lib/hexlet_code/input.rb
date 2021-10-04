# frozen_string_literal: true

require_relative 'tag'

module HexletCode
  # Input class returns html input field
  class Input
    def self.build(name, value: nil, type: 'text', **attrs)
      attrs_h = { type: type, name: name, **attrs }
      attrs_h[:value] = value if value

      Tag.build('input', **attrs_h)
    end
  end
end
