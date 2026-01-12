require 'us_core_test_kit/must_support_test'

module PacioSMPTestKit
  module MustSupportTest
    include USCoreTestKit::MustSupportTest
    extend USCoreTestKit::MustSupportTest 
  end
end

# Monkey Patch matching_type_slice? to handle discriminator.path
# Github Issue: https://github.com/inferno-framework/inferno-core/issues/754
module Inferno
  module DSL
    module FHIRResourceNavigation

      # @private
      def matching_type_slice?(slice, discriminator)
        # Monkey Patch: apply discriminator.path if specified
        slice_value = discriminator[:path].present? ? slice.send(discriminator[:path]) : slice

        case discriminator[:code]
        when 'Date'
          begin
            Date.parse(slice_value)
          rescue ArgumentError
            false
          end
        when 'DateTime'
          begin
            DateTime.parse(slice_value)
          rescue ArgumentError
            false
          end
        when 'String'
          slice_value.is_a? String
        else
          slice_value.is_a? FHIR.const_get(discriminator[:code])
        end
      end
    end
  end
end