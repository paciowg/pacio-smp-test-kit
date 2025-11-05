require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationRequestReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct MedicationRequest resource from MedicationRequest read interaction'
      description 'A server SHOULD support the MedicationRequest read interaction.'

      id :smp_v100_medication_request_read_test
      def resource_type
        'MedicationRequest'
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
