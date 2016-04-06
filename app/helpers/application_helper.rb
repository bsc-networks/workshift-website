module ApplicationHelper
    def webpack_bundle_tag(bundle)
      # src =
      #   if false and Rails.configuration.webpack[:use_manifest]
      #     manifest = Rails.configuration.webpack[:asset_manifest]
      #     filename = manifest[bundle]
    
      #     "#{compute_asset_host}/assets/#{filename}"
      #   else
      #     "#{compute_asset_host}/assets/#{bundle}-bundle"
      #   end
      src = "#{compute_asset_host}/assets/#{bundle}"
      javascript_include_tag(src)
    end


    def webpack_manifest_script
      return '' unless Rails.configuration.webpack[:use_manifest]
      javascript_tag "window.webpackManifest = #{Rails.configuration.webpack[:common_manifest]}"
    end
end
