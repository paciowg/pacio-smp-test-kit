require_relative '../../../must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationActionPlanBundleMustSupportTest < Inferno::Test
      include PacioSMPTestKit::MustSupportTest

      title 'All must support elements are provided in the Bundle resources returned'

      description %(
        This test will look through the Bundle resources
        found previously for the following must support elements:

        * Bundle.entry
        * Bundle.entry:patient
        * Bundle.entry:patient.resource
        * Bundle.entry:smp-map-composition
      )

      id :smp_v100_medication_action_plan_bundle_must_support_test

      def resource_type
        'Bundle'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_action_plan_bundle_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
