# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/render_form'

# HexletCode module
module HexletCode
  def self.form_for(user, url: '#')
    render_form = RenderForm.new(user, url)
    render_form.build { yield render_form }
  end
end
