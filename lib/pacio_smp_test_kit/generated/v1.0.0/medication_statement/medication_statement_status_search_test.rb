require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationStatementStatusSearchTest < Inferno::Test
      include PacioSMPTestKit::SearchTest

      title 'Server returns valid results for MedicationStatement search by status'
      description %(
A server SHOULD support searching by
status on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PACIO SMP Server CapabilityStatement](/CapabilityStatement-smp-server.html)

      )

      id :smp_v100_medication_statement_status_search_test
      optional

      def self.properties
        @properties ||= USCoreTestKit::SearchTestProperties.new(
          resource_type: 'MedicationStatement',
          search_param_names: ['status']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
