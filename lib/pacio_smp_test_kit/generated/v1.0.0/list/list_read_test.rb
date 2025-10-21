require_relative '../../../read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class ListReadTest < Inferno::Test
      include PacioSMPTestKit::ReadTest

      title 'Server returns correct List resource from List read interaction'
      description 'A server SHALL support the List read interaction.'

      id :smp_v100_list_read_test

      def resource_type
        'List'
      end

      def scratch_resources
        scratch[:list_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
