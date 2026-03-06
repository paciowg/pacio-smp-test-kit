require 'pacio_inferno_core/validation_test'

module PacioSMPTestKit
  module PacioSMPV100
    class MedicationActionPlanBundleValidationTest < Inferno::Test
      include PacioInfernoCore::ValidationTest

      id :smp_v100_medication_action_plan_bundle_validation_test

      title <<~DESC
        Bundle resources returned during previous tests conform to the Standardized Medication Profile - Bundle Medication Action Plan
      DESC

      description %(
This test verifies resources returned from the first search conform to
the [Standardized Medication Profile - Bundle Medication Action Plan](http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication-action-plan-bundle).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'Bundle'
      end

      def scratch_resources
        scratch[:medication_action_plan_bundle_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/smp/StructureDefinition/smp-medication-action-plan-bundle',
                                '1.0.0')
      end
    end
  end
end
