require_relative '../../../read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class BundleTransactionReadTest < Inferno::Test
      include PacioSMPTestKit::ReadTest

      title 'Server returns correct Bundle resource from Bundle read interaction'
      description 'A server MAY support the Bundle read interaction.'

      id :smp_v100_bundle_transaction_read_test

      input :bundle_transaction_resource_ids,
            title: 'ID(s) for Bundle Medication List Maintenance resources present on the server.',
            description: %(
              Comma separated list of Bundle Medication List Maintenance ids that in sum contain
              all MUST SUPPORT elements
            ),
            optional: true

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:bundle_transaction_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources, resource_ids: bundle_transaction_resource_ids)
      end
    end
  end
end
