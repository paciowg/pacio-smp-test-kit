require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class BundleReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct Bundle resource from Bundle read interaction'
      description 'A server MAY support the Bundle read interaction.'

      id :smp_v100_bundle_read_test

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:bundle_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Bundle'), delayed_reference: true)
      end
    end
  end
end
