# frozen_string_literal: true

require_relative 'form'

module HexletCode
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

      form_group = Form.build_group(name, value: @user[name], **attrs)

      add_input(form_group)
    end

    def submit(value = 'Save')
      submit = Form.build_submit(value)
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
end
