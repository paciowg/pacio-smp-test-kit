require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationStatementReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct MedicationStatement resource from MedicationStatement read interaction'
      description 'A server SHALL support the MedicationStatement read interaction.'

      id :smp_v100_medication_statement_read_test

      def resource_type
        'MedicationStatement'
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
