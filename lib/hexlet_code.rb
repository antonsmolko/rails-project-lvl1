# frozen_string_literal: true

require_relative 'hexlet_code/version'

# HexletCode module
module HexletCode
  class Error < StandardError; end

  # Tag module returns html string for tag
  module Tag
    def self.build(tag_name, attributes = {})
      attrs_s = attributes.reduce('') do |memo, (key, value)|
        attr_s = value == true ? key : %(#{key}="#{value}")
        %(#{memo} #{attr_s})
      end

      return %(<#{tag_name}#{attrs_s}>#{yield}</#{tag_name}>) if block_given?

      %(<#{tag_name}#{attrs_s}/>)
    end
  end

  # Form class with form field collection
  class Form
    # Input class returns html input field
    class Input
      def self.build(name, value, type: 'text', **attrs)
        attrs_h = { type: type, name: name, **attrs }
        attrs_h[:value] = value if value

        Tag.build('input', **attrs_h)
      end
    end

    # Textarea class returns html textarea field
    class Textarea
      def self.build(name, value, **attrs)
        attrs_h = { cols: 20, rows: 40, name: name, **attrs }

        Tag.build('textarea', **attrs_h) { value }
      end
    end

    # Select class returns html select field
    class Select
      def self.build(name, value, **attrs)
        collection = attrs.delete(:collection) || []
        attrs_h = { name: name, **attrs }
        options = collection.map do |option|
          option_attrs = { value: option }
          option_attrs[:selected] = true if option == value
          option_tag = Tag.build('option', **option_attrs) { option }
          %(\n#{option_tag})
        end.join

        Tag.build('select', **attrs_h) { %(#{options}\n) }
      end
    end

    # Label class returns html label
    class Label
      def self.build(name)
        Tag.build('label', for: name) { name.capitalize }
      end
    end

    def self.build(action, method, inner)
      Tag.build('form', action: action, method: method) { inner }
    end

    def self.build_group(name, value, **attrs)
      as = attrs.delete(:as)

      control = case as
                when :text then Textarea.build(name, value, attrs)
                when :select then Select.build(name, value, attrs)
                else Input.build(name, value, attrs)
                end

      label = Label.build(name)

      %(#{label}\n#{control})
    end
  end

  # RenderForm class - html form render
  class RenderForm
    attr_accessor :inputs, :user, :url

    def initialize(user, url)
      @user = user.to_h
      @url = url
      @inputs = ''
    end

    def input(name, **attrs)
      return unless @user.key?(name)

      form_group = Form.build_group(name, @user[name], attrs)

      add_input(form_group)
    end

    def submit(value = 'Save')
      submit = Form::Input.build('commit', value, type: 'submit')
      add_input(submit)
    end

    def add_input(tag)
      @inputs += %(\n#{tag})
    end

    def build
      inner = yield self
      Form.build(@url, 'post', %(#{inner}\n))
    end
  end

  def self.form_for(user, url: '#')
    render_form = RenderForm.new(user, url)
    render_form.build { yield render_form }
  end
end
