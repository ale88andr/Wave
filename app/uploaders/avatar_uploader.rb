# encoding: utf-8

class AvatarUploader < BaseUploader

  process :resize_to_fit => [200, 200]

  # version :thumb do
  #   process :scale => [50, 50]
  # end

end
