# frozen_string_literal: true

# HexletCode module
module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  # Label class returns html label
  class Label
    def self.build(name)
      Tag.build('label', for: name) { name.capitalize }
    end
  end
end
