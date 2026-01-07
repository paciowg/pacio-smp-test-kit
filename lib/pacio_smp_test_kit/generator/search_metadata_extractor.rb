require 'us_core_test_kit/generator/search_metadata_extractor'
require_relative 'search_definition_metadata_extractor'

module PacioSMPTestKit
  class Generator
    class SearchMetadataExtractor < USCoreTestKit::Generator::SearchMetadataExtractor
      def basic_searches
        result = super
        
        case resource_capabilities.type
        when 'Patient'
          if result.none? { |p| p[:names] == ['_id'] }
            result << { names: ['_id'], expectation: 'SHALL' } 
          end
        when 'List'
          result.clear
          result << { names: ['patient', 'code'], expectation: 'SHALL' }     
        when 'MedicationAdministration', 'MedicationRequest', 'MedicationStatement'
          if result.none? { |p| p[:names] == ['patient'] }
            result << { names: ['patient'], expectation: 'SHALL' }
          end
        end
        
        result
      end

      def search_definitions
        search_param_names.each_with_object({}) do |name, definitions|
          definitions[name.to_sym] =
            SearchDefinitionMetadataExtractor.new(name, ig_resources, profile_elements,
                                                  group_metadata).search_definition
        end
      end
    end
  end
end
