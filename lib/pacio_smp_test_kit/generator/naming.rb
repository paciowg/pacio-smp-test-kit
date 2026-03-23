module PacioSMPTestKit
  class Generator
    module Naming
      IG_LINKS = {
        'v1.0.0' => 'https://build.fhir.org/ig/HL7/smp-ig/branches/mlt-preapply'
      }.freeze

      class << self
        def resources_with_multiple_profiles
          ['Bundle']
        end

        def prefix
          'smp'
        end

        def module_name
          'PacioSMP'
        end

        def long_name
          'PACIO SMP'
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          group_metadata.name
            .delete_prefix("#{prefix.downcase}_")
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
