require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct Medication resource from Medication read interaction'
      description 'A server SHOULD support the Medication read interaction.'

      id :smp_v100_medication_read_test
      def resource_type
        'Medication'
      end

      def scratch_resources
        scratch[:medication_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Medication'), delayed_reference: true)
      end
    end
  end
end
