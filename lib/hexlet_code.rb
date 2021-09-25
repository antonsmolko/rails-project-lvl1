# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  module Tag
    def self.build(name, attributes = {})
      attrs = attributes.reduce('') { |memo, (key, value)| %(#{memo} #{key}="#{value}")}
      single_template = ->(name, attrs) { "<#{name}#{attrs}/>" }
      pair_template = ->(name, attrs, body) { "<#{name}#{attrs}>#{body}</#{name}>" }

      return pair_template.call(name, attrs, yield) if block_given?
      single_template.call(name, attrs)
    end
  end
end
