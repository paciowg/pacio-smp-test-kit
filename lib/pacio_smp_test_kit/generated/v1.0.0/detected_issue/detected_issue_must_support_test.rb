require_relative '../../../must_support_test'

module PacioSMPTestKit
  module PacioSMPV100
    class DetectedIssueMustSupportTest < Inferno::Test
      include PacioSMPTestKit::MustSupportTest

      title 'All must support elements are provided in the DetectedIssue resources returned'

      description %(
        This test will look through the DetectedIssue resources
        found previously for the following must support elements:

        * DetectedIssue.code
        * DetectedIssue.detail
      )

      id :smp_v100_detected_issue_must_support_test

      def resource_type
        'DetectedIssue'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:detected_issue_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
