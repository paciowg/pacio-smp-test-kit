require 'us_core_test_kit/search_test'
require 'us_core_test_kit/search_test_properties'
require_relative '../../../generator/group_metadata'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationAdministrationPatientSearchTest < Inferno::Test
      include USCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationAdministration search by patient'
      description %(
A server SHALL support searching by
patient on the MedicationAdministration resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results. US
Core requires that both forms are supported by US Core responders.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of Pacio SMP v1.0.0.

[Pacio SMP Server CapabilityStatement](/CapabilityStatement-smp-server.html)

      )

      id :smp_v100_medication_administration_patient_search_test
      optional
  

      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= USCoreTestKit::SearchTestProperties.new(
        first_search: true,
        resource_type: 'MedicationAdministration',
        search_param_names: ['patient'],
        saves_delayed_references: true,
        test_reference_variants: true,
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_administration_resources] ||= {}
      end

      run do
        run_search_test 
      end
    end
  end
end
