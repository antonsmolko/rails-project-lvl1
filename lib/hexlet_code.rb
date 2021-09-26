# frozen_string_literal: true

require_relative "hexlet_code/version"

# HexletCode module
module HexletCode
  class Error < StandardError; end

  attr  :inputs, :user, :url

  @inputs = ""
  @user = nil
  @url = nil

  # Tag module returns html string for tag
  module Tag
    def self.build_input(name, value)
      attrs = { type: "text", name: name }
      attrs[:value] = value if value
      Tag.build("input", **attrs)
    end

    def self.build_textarea(name, value)
      attrs = { cols: 20, rows: 40, name: name }
      Tag.build("textarea", **attrs) { value }
    end

    def self.build_select(name, value, collection = [])
      attrs = { name: name }
      options = collection.map do |option|
        option_attrs = { value: option }
        option_attrs[:selected] = true if option == value
        option_tag = Tag.build("option", **option_attrs) { option }
        "\n  #{option_tag}"
      end.join
      Tag.build("select", **attrs) { options }
    end

    def self.build(tag_name, attributes = {})
      attrs_s = attributes.reduce("") do |memo, (key, value)|
        attr_s = value == true ? key : %(#{key}="#{value}")
        %(#{memo} #{attr_s})
      end

      return %(<#{tag_name}#{attrs_s}>#{yield}</#{tag_name}>) if block_given?

      %(<#{tag_name}#{attrs_s}/>)
    end
  end

  def self.form_for(user, url: "#")
    @user = user.to_h
    @url = url

    yield self

    %(<form action="#{url}" method="post">#{@inputs}</form>)
  end

  def self.input(name, as: :input, collection: [])
    return unless @user.key?(name)

    case as
    when :input then tag = Tag.build_input(name, @user[name])
    when :text then tag = Tag.build_textarea(name, @user[name])
    when :select then tag = Tag.build_select(name, @user[name], collection)
    else raise ArgumentError, %(Wrong input type: "#{as}")
    end

    add_input(tag)
  end

  def self.submit(value = "Save")
    tag = Tag.build_input("commit", value, type: "submit")
    add_input(tag)
  end

  def self.add_input(tag)
    @inputs += %("\n  #{tag}")
  end
end
