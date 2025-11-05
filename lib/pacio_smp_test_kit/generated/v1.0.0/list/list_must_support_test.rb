require 'us_core_test_kit/must_support_test'

module QICoreTestKit
  module QICoreV100
    class ListMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the List resources returned'

      description %(
        This test will look through the List resources
        found previously for the following must support elements:

        * List.code
        * List.source
        * List.subject
      )

      id :qi_core_v100_list_must_support_test

      def resource_type
        'List'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:list_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
