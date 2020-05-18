# frozen_string_literal: true

module FileUploadSupport
  extend self
  extend ActionDispatch::TestProcess

  def png_name
    'test-image.png'
  end

  def png_path
    file_path png_name
  end

  def png
    upload png_name, 'image/png'
  end

  def jpg_name
    'test-image.jpg'
  end

  def jpg_path
    file_path jpg_name
  end

  def jpg
    upload jpg_name, 'image/jpg'
  end

  private

  def upload name, type
    fixture_file_upload file_path(name), type
  end

  def file_path name
    Rails.root.join 'spec', 'support', 'assets', name
  end
end
