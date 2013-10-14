# encoding: utf-8

class LogoUploader < CarrierWave::Uploader::Base

  # Include MiniMagick support:
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :resize_to_fit => [100, 100]

end
