module PacioSMPTestKit
  class Generator
    module SpecialCases
      # The generator will create optional test groups for these resources. If a
      # client or server supports them, the client or server must pass all of the
      # associated tests. This list is not IG version specific.
      # Each Test Kit Generator must populate this array or set to empty.
      OPTIONAL_RESOURCES = [
        'Bundle',
        'Medication',
        'MedicationAdministration',
        'MedicationRequest'
      ].freeze

      # Identifier for profiles that need input ID
      PROFILES_NEED_ID_INPUT = [
        'bundle',
        'bundle_transaction'
      ]
    end
  end
end