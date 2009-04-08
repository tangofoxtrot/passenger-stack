package :rmagick, :provides => :image_processor do
  gem 'rmagick'
  
  verify do
    has_gem 'rmagick'
  end
  
  requires :ruby_enterprise
end
 