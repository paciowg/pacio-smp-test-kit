require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationAdministrationReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct MedicationAdministration resource from MedicationAdministration read interaction'
      description 'A server SHOULD support the MedicationAdministration read interaction.'

      id :smp_v100_medication_administration_read_test

      def resource_type
        'MedicationAdministration'
      end

      def scratch_resources
        scratch[:medication_administration_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'MedicationAdministration'), delayed_reference: true)
      end
    end
  end
end
