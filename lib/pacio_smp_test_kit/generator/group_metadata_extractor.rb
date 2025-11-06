require 'us_core_test_kit/generator/group_metadata_extractor'

require_relative 'group_metadata'
require_relative 'ig_metadata'
require_relative 'must_support_metadata_extractor'
require_relative 'search_metadata_extractor'
require_relative 'naming'

module PacioSMPTestKit
  class Generator
    class GroupMetadataExtractor < USCoreTestKit::Generator::GroupMetadataExtractor
      def group_metadata
        @group_metadata ||=
          GroupMetadata.new(group_metadata_hash)
      end

      def group_metadata_hash
        @group_metadata_hash ||=
          {
            name:,
            class_name:,
            version:,
            reformatted_version:,
            resource:,
            profile_url:,
            profile_name:,
            profile_version:,
            title:,
            short_description:,
            interactions:,
            operations:,
            searches:,
            search_definitions:,
            must_supports:,
            mandatory_elements:,
            bindings:,
            references:,
            resource_conformance_expectation:
          }

        @group_metadata_hash
      end


      def class_name
        base_name
          .split('-')
          .map(&:capitalize)
          .join
          .gsub('SMP', "SMP#{ig_metadata.reformatted_version}")
          .concat('Sequence')
      end

      def search_metadata_extractor
        @search_metadata_extractor ||= SearchMetadataExtractor.new(
          resource_capabilities,
          ig_resources,
          profile_elements,
          {
            resource: resource,
            profile_url: profile_url,
            must_supports: must_supports
          }
        )
      end

      def must_support_metadata_extractor
        @must_support_metadata_extractor ||=
          MustSupportMetadataExtractor.new(profile_elements, profile, resource, ig_resources)
      end
      
      def references
        @references ||=
          profile_elements
            .select { |element| element.type&.any? { |t| t.code == 'Reference' } }
            .map do |reference_definition|
              reference_type = reference_definition.type.find { |t| t.code == 'Reference' }
              {
                path: reference_definition.path,
                profiles: reference_type.targetProfile
              }
            end
      end
    end
  end
end
