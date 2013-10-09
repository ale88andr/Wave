# encoding: utf-8

class LogoUploader < BaseUploader

  process :resize_to_fit => [100, 100]

end
