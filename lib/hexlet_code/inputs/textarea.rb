# frozen_string_literal: true

require_relative 'base'

# HexletCode module
module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  module Inputs
    # Textarea class returns html textarea field
    class Textarea < Base
      def build
        attrs_h = { cols: 20, rows: 40, name: @name, **@attrs }

        HexletCode::Tag.build('textarea', **attrs_h) { @value }
      end
    end
  end
end
