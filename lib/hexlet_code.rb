# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode module
module HexletCode
  class Error < StandardError; end

  # Tag module returns html string for tag
  module Tag
    def self.build(tag_name, attributes = {})
      attr_s = attributes.reduce("") { |memo, (key, value)| %(#{memo} #{key}="#{value}") }
      single_template = ->(name, attrs) { "<#{name}#{attrs}/>" }
      pair_template = ->(name, attrs, body) { "<#{name}#{attrs}>#{body}</#{name}>" }

      return pair_template.call(tag_name, attr_s, yield) if block_given?

      single_template.call(tag_name, attr_s)
    end
  end

  def self.form_for(user, url: "#")
    get_form = lambda { |f|
      %(<form action="#{url}" method="post">#{user.name}#{f}</form>)
    }

    get_form.call("form")
  end
end
