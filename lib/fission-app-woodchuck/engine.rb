module FissonApp
  module Woodchuck
    class Engine < ::Rails::Engine

      # Ensure woodchuck is registered as a valid product. Register
      # permission to allow access.
      config.to_prepare do |config|
        product = Fission::Data::Models::Product.find_or_create(:name => 'woodchuck')
        unless(product.permissions_dataset.where(:name => 'woodchuck_base').count > 0)
          product.add_permission(
            :name => 'woodchuck_base',
            :pattern => '/woodchuck.*'
          )
        end
      end

    end
  end
end
