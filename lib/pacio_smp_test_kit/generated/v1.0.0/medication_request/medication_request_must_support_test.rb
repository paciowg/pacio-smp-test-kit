require 'us_core_test_kit/must_support_test'

module QICoreTestKit
  module QICoreV100
    class MedicationRequestMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationRequest resources returned'

      description %(
        This test will look through the MedicationRequest resources
        found previously for the following must support elements:

        * MedicationRequest.authoredOn
        * MedicationRequest.category
        * MedicationRequest.category:us-core
        * MedicationRequest.dispenseRequest
        * MedicationRequest.dispenseRequest.numberOfRepeatsAllowed
        * MedicationRequest.dispenseRequest.quantity
        * MedicationRequest.dosageInstruction
        * MedicationRequest.dosageInstruction.doseAndRate
        * MedicationRequest.dosageInstruction.doseAndRate.doseQuantity
        * MedicationRequest.dosageInstruction.text
        * MedicationRequest.dosageInstruction.timing
        * MedicationRequest.encounter
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.reportedBoolean
        * MedicationRequest.reportedReference
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject
      )

      id :qi_core_v100_medication_request_must_support_test

      def resource_type
        'MedicationRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
