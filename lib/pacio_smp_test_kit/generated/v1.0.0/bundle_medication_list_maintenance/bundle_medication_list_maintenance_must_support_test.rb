require_relative '../../../must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class BundleMedicationListMaintenanceMustSupportTest < Inferno::Test
      include PacioSMPTestKit::MustSupportTest

      title 'All must support elements are provided in the Bundle resources returned'

      description %(
        This test will look through the Bundle resources
        found previously for the following must support elements:

        * Bundle.entry
        * Bundle.entry.request
        * Bundle.entry:List
        * Bundle.entry:List.request
        * Bundle.entry:Medication
        * Bundle.entry:Medication.request
        * Bundle.entry:MedicationAdministration
        * Bundle.entry:MedicationAdministration.request
        * Bundle.entry:MedicationDispense
        * Bundle.entry:MedicationDispense.request
        * Bundle.entry:MedicationRequest
        * Bundle.entry:MedicationRequest.request
        * Bundle.entry:MedicationStatement
        * Bundle.entry:MedicationStatement.request
        * Bundle.entry:Patient
        * Bundle.entry:Patient.request
        * Bundle.total
        * Bundle.type
      )

      id :smp_v100_bundle_medication_list_maintenance_must_support_test

      def resource_type
        'Bundle'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:bundle_medication_list_maintenance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
