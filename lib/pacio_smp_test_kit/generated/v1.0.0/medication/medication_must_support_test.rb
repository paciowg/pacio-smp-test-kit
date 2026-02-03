require_relative '../../../must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationMustSupportTest < Inferno::Test
      include PacioSMPTestKit::MustSupportTest

      title 'All must support elements are provided in the Medication resources returned'

      description %(
        This test will look through the Medication resources
        found previously for the following must support elements:

        * Medication.code
        * Medication.status
      )

      id :smp_v100_medication_must_support_test

      def resource_type
        'Medication'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
