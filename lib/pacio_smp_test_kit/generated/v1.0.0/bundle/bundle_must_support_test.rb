require 'us_core_test_kit/must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class BundleMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Bundle resources returned'

      description %(
        This test will look through the Bundle resources
        found previously for the following must support elements:

        * Bundle.entry
        * Bundle.entry:list
        * Bundle.entry:list.resource
        * Bundle.entry:medication
        * Bundle.entry:medicationadministration
        * Bundle.entry:medicationdispense
        * Bundle.entry:medicationrequest
        * Bundle.entry:medicationstatement
        * Bundle.entry:patient
        * Bundle.entry:patient.resource
        * Bundle.entry:practitioner
        * Bundle.entry:practitionerrole
        * Bundle.total
        * Bundle.type
      )

      id :smp_v100_bundle_must_support_test

      def resource_type
        'Bundle'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:bundle_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
