# frozen_string_literal: true

require_relative 'tag'

module HexletCode
  # Select class returns html select field
  class Select
    def self.build(name, value: nil, **attrs)
      collection = attrs.delete(:collection) || []
      attrs_h = { name: name, **attrs }
      is_multiple = attrs.key?(:multiple) && attrs[:multiple] == true

      options = collection.map do |option|
        option_attrs = { value: option }
        option_attrs[:selected] = true if is_multiple ? value.include?(option) : option == value
        option_tag = Tag.build('option', **option_attrs) { option }
        %(\n#{option_tag})
      end.join

      Tag.build('select', **attrs_h) { %(#{options}\n) }
    end
  end
end
