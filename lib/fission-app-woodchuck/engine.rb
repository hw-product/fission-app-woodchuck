module FissionApp
  module Woodchuck
    class Engine < ::Rails::Engine

      # Ensure woodchuck is registered as a valid product. Register
      # permission to allow access.
      config.to_prepare do |config|
        product = Fission::Data::Models::Product.find_or_create(:name => 'Woodchucks')
        feature = Fission::Data::Models::ProductFeature.find_or_create(
          :name => 'full_access',
          :product_id => product.id
        )
        unless(feature.permissions_dataset.where(:name => 'woodchuck_full_access').count > 0)
          feature.add_permission(
            :name => 'woodchuck_full_access',
            :pattern => '/woodchuck.*'
          )
        end
      end

      # @return [Array<Fission::Data::Models::Product>]
      def fission_product
        [Fission::Data::Models::Product.find_by_internal_name('woodchucks')]
      end

      # @return [Hash]
      def fission_navigation
        {
          'Woodchucks' => {
            'Logs' => Rails.application.routes.url_for(:controller => :woodchucks, :action => :index, :only_path => true)
          }.with_indifferent_access
        }.with_indifferent_access
      end

      def fission_dashboard
        {
          :woodchuck_dashboard => 'Woodchucks'
        }
      end

    end
  end
end
