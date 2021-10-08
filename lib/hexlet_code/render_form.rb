# frozen_string_literal: true

# HexletCode module
module HexletCode
  autoload :Form, 'hexlet_code/form'
  autoload :Inputs, 'hexlet_code/inputs'

  # RenderForm class - html form render
  class RenderForm
    def self.build(inputs, method, url)
      form = Form.new

      inner = inputs.map { |attrs| form.build_group(attrs) }.join("\n")

      form.build(url, method, inner)
    end
  end
end
