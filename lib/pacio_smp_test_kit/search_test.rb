require 'us_core_test_kit/search_test'

module PacioSMPTestKit
  module SearchTest
    include USCoreTestKit::SearchTest
    extend USCoreTestKit::SearchTest

    def search_param_value(name, resource, include_system: false)
      paths = search_param_paths(name)
      search_value = nil
      paths.each do |path|
        element = find_a_value_at(resource, path) { |element| element_has_valid_value?(element, include_system) }

        search_value =
          case element
          when FHIR::Period
            if element.start.present?
              'gt' + (DateTime.xmlschema(element.start) - 1).xmlschema
            else
              end_datetime = get_fhir_datetime_range(element.end)[:end]
              'lt' + (end_datetime + 1).xmlschema
            end
          when FHIR::Reference
            element.reference
          when FHIR::CodeableConcept
            coding = prefer_well_known_code_system(element, include_system)
            include_system ? "#{coding.system}|#{coding.code}" : coding.code
          when FHIR::Identifier
            include_system ? "#{element.system}|#{element.value}" : element.value
          when FHIR::Coding
            include_system ? "#{element.system}|#{element.code}" : element.code
          when FHIR::HumanName
            element.family || element.given&.first || element.text
          when FHIR::Address
            element.text || element.city || element.state || element.postalCode || element.country
          when Inferno::DSL::PrimitiveType
            element.value
          else
            if metadata.version != 'v3.1.1' &&
               metadata.search_definitions[name.to_sym][:type] == 'date' &&
               params_with_comparators&.include?(name)
              # convert date search to greath-than comparator search with correct precision
              # For all date search parameters:
              #   Patient.birthDate does not mandate comparators so cannot be converted
              #   Goal.target-date has day precision
              #   All others have second + time offset precision
              if /^\d{4}(-\d{2})?$/.match?(element) || # YYYY or YYYY-MM
                 (/^\d{4}-\d{2}-\d{2}$/.match?(element) && resource_type != 'Goal') # YYY-MM-DD AND Resource is NOT Goal
                "gt#{(DateTime.xmlschema(element) - 1).xmlschema}"
              else
                element
              end
            else
              element
            end
          end

        break if search_value.present?
      end

      search_value&.gsub(',', '\\,')
    end

  end
end
