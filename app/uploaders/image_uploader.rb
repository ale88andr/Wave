# encoding: utf-8

class ImageUploader < BaseUploader

  process :resize_to_fit => [400, 300]

  # version :thumb do
  #   process :resize_to_fit => [40, 30]
  # end

end