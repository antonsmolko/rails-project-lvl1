# frozen_string_literal: true

require_relative "test_helper"

class HexletCodeTest < Minitest::Test
  def test_that_it_has_a_version
    refute_nil ::HexletCode::VERSION
  end

  User = Struct.new :name, :job, :gender, keyword_init: true

  def test_form_generator
    user = User.new name: "rob", job: "hexlet", gender: "m"
    expected = File.open(File.expand_path("../test/expected.html", __dir__), "r").read

    form = HexletCode.form_for user do |f|
      f.input :name
      f.input :job, as: :text
      f.input :gender, as: :select, collection: %w[m f]
      f.submit
    end

    assert_equal expected, form
  end
end
