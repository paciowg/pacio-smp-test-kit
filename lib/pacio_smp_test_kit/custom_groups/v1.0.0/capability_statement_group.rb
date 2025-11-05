require 'tls_test_kit'
require_relative '../capability_statement/conformance_support_test'
require_relative '../capability_statement/fhir_version_test'
# require_relative '../capability_statement/json_support_test'
# require_relative '../capability_statement/profile_support_test'
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
        the required capabilities of a US Core server.

        The Capability Statement resource allows clients to determine which
        resources are supported by a FHIR Server. Not all servers are expected to
        implement all possible queries and data elements described in the US Core
        API. For example, the US Core Implementation Guide requires that the
        Patient resource and only one additional resource profile from the US Core
        Profiles.

        # Test Methodology

        This test sequence accesses the server endpoint at `/metadata` using a
        `GET` request. It parses the Capability Statement and verifies that:

        * The endpoint is secured by an appropriate cryptographic protocol
        * The resource matches the expected FHIR version defined by the tests
        * The resource is a valid FHIR resource
        * The server claims support for JSON encoding of resources
        * The server claims support for the Patient resource and one other
          resource
      )
      run_as_group

      PROFILES = {
        'Bundle' => [
          'http://hl7.org/fhir/us/smp/StructureDefinition/smp-bundle',
          'http://hl7.org/fhir/us/smp/StructureDefinition/smp-bundle-transaction'
        ].freeze,
        'Medication' => [
          'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication'
        ].freeze,
        'List' => [
          'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication-list'
        ].freeze,
        'MedicationAdministration' => [
          'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medicationadministration'
        ].freeze,
        'MedicationStatement' => [
          'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medicationstatement'
        ].freeze
      }.freeze

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
      test from: :smp_conformance_support
      test from: :smp_fhir_version
      # test from: :smp_json_support
      test from: :smp_instantiate
      # test from: :smp_profile_support do
      #   config(
      #     options: { smp_profiles: PROFILES.values.flatten }
      #   )
      # end
    end
  end
end
