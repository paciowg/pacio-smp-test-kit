require_relative '../../../read_test'

module PacioSMPTestKit
  module PacioSMPV100
    class DetectedIssueReadTest < Inferno::Test
      include PacioSMPTestKit::ReadTest

      title 'Server returns correct DetectedIssue resource from DetectedIssue read interaction'
      description 'A server SHOULD support the DetectedIssue read interaction.'

      id :smp_v100_detected_issue_read_test

      def resource_type
        'DetectedIssue'
      end

      def scratch_resources
        scratch[:detected_issue_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
