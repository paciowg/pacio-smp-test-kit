require_relative 'ig_metadata'
require_relative 'group_metadata_extractor'

module PacioSMPTestKit
  class Generator
    class IGMetadataExtractor
      attr_accessor :ig_resources, :metadata

      def initialize(ig_resources)
        self.ig_resources = ig_resources
        self.metadata = IGMetadata.new
      end

      def extract
        add_metadata_from_ig
        add_metadata_from_resources
        metadata
      end

      def add_metadata_from_ig
        metadata.ig_version = "v#{ig_resources.ig.version}".delete('-ballot')
      end

      def resources_in_capability_statement
        ig_resources.capability_statement.rest.first.resource
      end

      def smp_resources_in_capability_statement
        resources_in_capability_statement.filter do |resource|
          resource.supportedProfile.any? { |sp| sp.start_with?('http://hl7.org/fhir/us/smp') }
        end
      end

      def add_metadata_from_resources
        metadata.groups =
          smp_resources_in_capability_statement.flat_map do |resource|
            resource.supportedProfile&.map do |supported_profile|
              GroupMetadataExtractor.new(resource, supported_profile, metadata, ig_resources).group_metadata
            end
          end.compact
      end
    end
  end
end
