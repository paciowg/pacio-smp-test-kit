module PacioSMPTestKit
  class Generator
    module Naming
      IG_LINKS = {
        'v1.0.0' => 'http://hl7.org/fhir/us/smp/STU1'
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

          group_metadata.name
            .delete_prefix('smp_')
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
