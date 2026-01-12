require_relative '../../../read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class BundleMedicationListMaintenanceReadTest < Inferno::Test
      include PacioSMPTestKit::ReadTest

      title 'Server returns correct Bundle resource from Bundle read interaction'
      description 'A server MAY support the Bundle read interaction.'

      id :smp_v100_bundle_medication_list_maintenance_read_test

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:bundle_medication_list_maintenance_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Bundle'), delayed_reference: true)
      end
    end
  end
end
