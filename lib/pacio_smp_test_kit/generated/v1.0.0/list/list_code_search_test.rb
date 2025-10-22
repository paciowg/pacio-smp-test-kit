require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioSMPTestKit
  module PacioSMPV100
    class ListCodeSearchTest < Inferno::Test
      include PacioSMPTestKit::SearchTest

      title 'Server returns valid results for List search by code'
      description %(
A server SHALL support searching by
code on the List resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[Pacio SMP Server CapabilityStatement](http://hl7.org/fhir/us/smp/STU1/CapabilityStatement-smp-server.html)

      )

      id :smp_v100_list_code_search_test
      optional
  

      def self.properties
        @properties ||= SearchTestProperties.new(
        resource_type: 'List',
        search_param_names: ['code'],
        token_search_params: ['code']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:list_resources] ||= {}
      end

      run do
        run_search_test 
      end
    end
  end
end
