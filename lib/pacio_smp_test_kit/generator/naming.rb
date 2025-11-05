module PacioSMPTestKit
  class Generator
    module Naming
      # From SMP
      BUNDLE_MEDICATION_LIST = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-bundle'
      BUNDLE_MEDICATION_LIST_MAINTENANCE = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-bundle-transaction'
      MEDICATION = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication'
      MEDICATION_LIST = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication-list'
      MEDICATION_ADMINISTRATION = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medicationadministration'
      MEDICATION_STATEMENT = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medicationstatement'
      PARAMETER_QUERY = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-parameters-query'
      PARAMETER_RESPONSE = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-parameters-response'
      PARAMETER_SUBMIT = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-parameters-submit'
      PARAMETER_OUTCOME = 'http://hl7.org/fhir/us/smp/StructureDefinition/smp-parameters-outcome'
      
      # From US Core
      MEDICATION_REQUEST = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationrequest'
      PATIENT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'

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

          # case group_metadata.profile_url
          # when BUNDLE_MEDICATION_LIST
          #   return 'bundle_medication_list'
          # when BUNDLE_MEDICATION_LIST_MAINTENANCE
          #   return 'bundle_medication_list_maintenance'
          # end

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
