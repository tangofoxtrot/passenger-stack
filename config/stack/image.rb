package :rmagick, :provides => :image_processor do
  description 'RMagick and all its libraries'
  apt %w(imagemagick libmagick9-dev gs-common)
  
  verify do
    has_executable 'convert'
  end

  gem 'rmagick'
  
  verify do
    has_gem 'rmagick'
  end
  
  requires :ruby_enterprise
end
 