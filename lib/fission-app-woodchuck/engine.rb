module FissionApp
  module Woodchuck
    class Engine < ::Rails::Engine

      # Ensure woodchuck is registered as a valid product. Register
      # permission to allow access.
      config.to_prepare do |config|
        product = Fission::Data::Models::Product.find_or_create(:name => 'Woodchucks')
        feature = Fission::Data::Models::ProductFeature.find_or_create(
          :name => 'View System Logs',
          :product_id => product.id
        )
        permission = Fission::Data::Models::Permission.find_or_create(
          :name => 'Woodchuck logs view access',
          :pattern => '/woodchuck.*'
        )
        unless(feature.permissions.include?(permission))
          feature.add_permission(permission)
        end
      end

      # @return [Array<Fission::Data::Models::Product>]
      def fission_product
        [Fission::Data::Models::Product.find_by_internal_name('woodchucks')]
      end

      # @return [Hash]
      def fission_navigation(*_)
        Smash.new(
          'Woodchucks' => Smash.new(
            'Logs' => Rails.application.routes.url_helpers.woodchucks_path
          )
        )
      end

      def fission_dashboard(*_)
        Smash.new(
          :woodchuck_dashboard => Smash.new(
            :title => 'Woodchucks',
            :url => Rails.application.routes.url_helpers.woodchucks_path
          )
        )
      end

    end
  end
end
