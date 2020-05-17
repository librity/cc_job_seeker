# frozen_string_literal: true

module FileUploadSupport
  extend self
  extend ActionDispatch::TestProcess

  def png_name
    'test-image.png'
  end

  def png
    upload png_name, 'image/png'
  end

  def jpg_name
    'test-image.jpg'
  end

  def jpg
    upload jpg_name, 'image/jpg'
  end

  private

  def upload name, type
    file_path = Rails.root.join 'spec', 'support', 'assets', name
    fixture_file_upload file_path, type
  end
end
