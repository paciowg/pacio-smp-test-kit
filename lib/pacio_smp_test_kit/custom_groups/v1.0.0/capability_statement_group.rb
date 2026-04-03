require 'tls_test_kit'
require 'pacio_inferno_core/custom_groups/capability_statement/conformance_support_test'
require 'pacio_inferno_core/custom_groups/capability_statement/fhir_version_test'
require 'pacio_inferno_core/custom_groups/capability_statement/json_support_test'
require_relative '../capability_statement/instantiate_test'

module PacioSMPTestKit
  module PacioSMPV100
    class CapabilityStatementGroup < Inferno::TestGroup
      id :smp_v100_capability_statement
      title 'Capability Statement'
      short_description <<~DESC
        'Retrieve information about supported server functionality using the FHIR capabilties interaction.'
      DESC
      description %(
        # Background
        The #{title} Sequence tests a FHIR server's ability to formally describe
        features supported by the API by using the [Capability
        Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource.
        The features described in the Capability Statement must be consistent with
        the required capabilities of a PACIO SMP server.

        The Capability Statement resource allows clients to determine which
        resources are supported by a FHIR Server. Not all servers are expected to
        implement all possible queries and data elements described in the PACIO SMP
        API.

        # Test Methodology

        This test sequence accesses the server endpoint at `/metadata` using a
        `GET` request. It parses the Capability Statement and verifies that:

        * The endpoint is secured by an appropriate cryptographic protocol
        * The resource matches the expected FHIR version defined by the tests
        * The resource is a valid FHIR resource
        * The server claims support for JSON encoding of resources
      )
      run_as_group

      test from: :tls_version_test,
           id: :standalone_auth_tls,
           title: 'FHIR server secured by transport layer security',
           description: %(
             Systems **SHALL** use TLS version 1.2 or higher for all transmissions
             not taking place over a secure network connection.
           ),
           config: {
             options: { minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
           }
      test from: :pacio_inferno_core_conformance_support
      test from: :pacio_inferno_core_fhir_version
      test from: :pacio_inferno_core_json_support
      test from: :smp_instantiate
    end
  end
end
