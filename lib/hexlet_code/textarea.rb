# frozen_string_literal: true

require_relative 'tag'

module HexletCode
  # Textarea class returns html textarea field
  class Textarea
    def self.build(name, value: nil, **attrs)
      attrs_h = { cols: 20, rows: 40, name: name, **attrs }

      Tag.build('textarea', **attrs_h) { value }
    end
  end
end
