require 'inferno/dsl/oauth_credentials'
require_relative '../../version'
require_relative '../../custom_groups/v1.0.0/capability_statement_group'
require_relative 'patient_group'
require_relative 'list_group'
require_relative 'medication_statement_group'
require_relative 'medication_request_group'
require_relative 'medication_administration_group'
require_relative 'medication_group'
require_relative 'bundle_group'
require_relative 'bundle_transaction_group'

module PacioSMPTestKit
  module PacioSMPV100
    class PacioSMPTestSuite < Inferno::TestSuite
      title 'PACIO SMP Server v1.0.0'
      description %(
        The PACIO SMP Server Test Kit tests server systems for their conformance to the [PACIO SMP
        Implementation Guide](https://build.fhir.org/ig/HL7/smp-ig/branches/mlt-preapply).
      )

      GENERAL_MESSAGE_FILTERS = [].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      id :smp_v100

      fhir_resource_validator do
        igs 'hl7.fhir.us.smp#current', 'hl7.fhir.us.core#6.1.0'
        message_filters = VALIDATION_MESSAGE_FILTERS

        exclude_message do |message|
          message_filters.any? { |filter| filter.match? message.message }
        end
      end

      input :url,
            title: 'FHIR Endpoint',
            description: 'URL of the FHIR endpoint'
      input :smart_auth_info,
            title: 'OAuth Credentials',
            type: :auth_info,
            optional: true

      fhir_client do
        url :url
        auth_info :smart_auth_info
      end

      group from: :smp_v100_capability_statement

      group from: :smp_v100_patient
      group from: :smp_v100_list
      group from: :smp_v100_medication_statement
      group from: :smp_v100_medication_request
      group from: :smp_v100_medication_administration
      group from: :smp_v100_medication
      group from: :smp_v100_bundle
      group from: :smp_v100_bundle_transaction

      links [
        {
          type: 'report_issue',
          label: 'Report Issue',
          url: 'https://github.com/paciowg/pacio-smp-test-kit/issues/'
        },
        {
          type: 'source_code',
          label: 'Open Source',
          url: 'https://github.com/paciowg/pacio-smp-test-kit/'
        },
        {
          type: 'download',
          label: 'Download',
          url: 'https://github.com/paciowg/pacio-smp-test-kit/releases/'
        }
      ]
    end
  end
end
