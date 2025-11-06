require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class PatientReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :smp_v100_patient_read_test

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
