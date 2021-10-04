# frozen_string_literal: true

require_relative 'tag'

module HexletCode
  # Label class returns html label
  class Label
    def self.build(name)
      Tag.build('label', for: name) { name.capitalize }
    end
  end
end
