# encoding: utf-8

class LabelUploader < BaseUploader

  process :resize_to_fit => [45, 45]

end
