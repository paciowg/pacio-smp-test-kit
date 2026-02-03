module PacioSMPTestKit
  class InstantiateTest < Inferno::Test
    id :smp_instantiate
    title 'Server instantiates PACIO SMP Server'
    description %(
        This test inspects the CapabilityStatement returned by the server to
        verify that the server instantiates http://hl7.org/fhir/us/smp/CapabilityStatement/smp-server
      )
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)
      capability_statement = resource

      include_us_core = capability_statement.instantiates&.any? do |url|
        url.split('|').first == 'http://hl7.org/fhir/us/smp/CapabilityStatement/smp-server'
      end

      assert include_us_core,
             "Server CapabilityStatement.instantiates does not include 'http://hl7.org/fhir/us/smp/CapabilityStatement/smp-server'"
    end
  end
end
