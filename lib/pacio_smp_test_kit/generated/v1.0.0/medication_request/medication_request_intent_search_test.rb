require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationRequestIntentSearchTest < Inferno::Test
      include PacioSMPTestKit::SearchTest

      title 'Server returns valid results for MedicationRequest search by intent'
      description %(
A server SHOULD support searching by
intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PACIO SMP Server CapabilityStatement](/CapabilityStatement-smp-server.html)

      )

      id :smp_v100_medication_request_intent_search_test
      optional

      def self.properties
        @properties ||= PacioInfernoCore::SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          search_param_names: ['intent'],
          possible_status_search: true,
          test_medication_inclusion: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
