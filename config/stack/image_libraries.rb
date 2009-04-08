package :imagemagick, :provides => :image_libraries do
  description 'Imagick Magick'
  apt %w(imagemagick libmagick9-dev gs-common)
  
  verify do
    has_executable 'convert'
  end
  
  requires :ruby_enterprise
end