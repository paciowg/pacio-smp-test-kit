require 'pacio_inferno_core/generator/group_metadata'

module PacioSMPTestKit
  class Generator
    class GroupMetadata < PacioInfernoCore::Generator::GroupMetadata
      def non_uscdi_resource?
        false
      end
    end
  end
end
