require 'us_core_test_kit/must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class BundleTransactionMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Bundle resources returned'

      description %(
        This test will look through the Bundle resources
        found previously for the following must support elements:

        * Bundle.entry
        * Bundle.entry.request
        * Bundle.entry:list
        * Bundle.entry:list.request
        * Bundle.entry:medication
        * Bundle.entry:medication.request
        * Bundle.entry:medicationadministration
        * Bundle.entry:medicationadministration.request
        * Bundle.entry:medicationdispense
        * Bundle.entry:medicationdispense.request
        * Bundle.entry:medicationrequest
        * Bundle.entry:medicationrequest.request
        * Bundle.entry:medicationstatement
        * Bundle.entry:medicationstatement.request
        * Bundle.entry:patient
        * Bundle.entry:patient.request
        * Bundle.total
        * Bundle.type
      )

      id :smp_v100_bundle_transaction_must_support_test

      def resource_type
        'Bundle'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:bundle_transaction_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
