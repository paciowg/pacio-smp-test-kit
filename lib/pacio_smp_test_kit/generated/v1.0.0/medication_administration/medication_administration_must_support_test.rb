require 'us_core_test_kit/must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationAdministrationMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationAdministration resources returned'

      description %(
        This test will look through the MedicationAdministration resources
        found previously for the following must support elements:


      )

      id :smp_v100_medication_administration_must_support_test

      def resource_type
        'MedicationAdministration'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_administration_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
