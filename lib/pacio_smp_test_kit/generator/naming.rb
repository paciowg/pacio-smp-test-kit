module PacioSMPTestKit
  class Generator
    module Naming
      SHORT_NAME = 'SMP'.freeze
      # From SMP
      BUNDLE_MEDICATION_LIST = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-bundle'
      BUNDLE_MEDICATION_LIST_MAINTENANCE = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-bundle-transaction'

      IG_LINKS = {
        'v1.0.0' => 'https://build.fhir.org/ig/HL7/smp-ig/branches/mlt-preapply'
      }.freeze

      class << self
        def resources_with_multiple_profiles
          ['Bundle']
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          case group_metadata.profile_url
          when BUNDLE_MEDICATION_LIST
            return 'bundle_medication_list'
          when BUNDLE_MEDICATION_LIST_MAINTENANCE
            return 'bundle_medication_list_maintenance'
          end

          group_metadata.name
            .delete_prefix("#{SHORT_NAME.downcase}_")
            .underscore
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end

        def ig_link(version)
          IG_LINKS[version]
        end
      end
    end
  end
end
