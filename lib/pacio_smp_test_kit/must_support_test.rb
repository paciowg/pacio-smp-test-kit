require 'pacio_inferno_core/must_support_test'

module PacioSMPTestKit
  module MustSupportTest
    include PacioInfernoCore::MustSupportTest
    extend PacioInfernoCore::MustSupportTest
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
        slice_value = resolve_path(slice, discriminator[:path]).first

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
