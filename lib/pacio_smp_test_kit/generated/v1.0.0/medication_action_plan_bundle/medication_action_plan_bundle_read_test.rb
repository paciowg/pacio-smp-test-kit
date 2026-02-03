require_relative '../../../read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationActionPlanBundleReadTest < Inferno::Test
      include PacioSMPTestKit::ReadTest

      title 'Server returns correct Bundle resource from Bundle read interaction'
      description 'A server MAY support the Bundle read interaction.'

      id :smp_v100_medication_action_plan_bundle_read_test

      input :medication_action_plan_bundle_resource_ids,
            title: 'ID(s) for Bundle Medication Action Plan resources present on the server.',
            description: %(
              Comma separated list of Bundle Medication Action Plan ids that in sum contain
              all MUST SUPPORT elements
            ),
            optional: true

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:medication_action_plan_bundle_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources, resource_ids: medication_action_plan_bundle_resource_ids)
      end
    end
  end
end
