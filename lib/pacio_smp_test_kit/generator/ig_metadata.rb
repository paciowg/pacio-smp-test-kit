module PacioSMPTestKit
  class Generator
    class IGMetadata
      attr_accessor :ig_version, :groups

      def reformatted_version
        @reformatted_version ||= ig_version.delete('.').gsub('-', '_')
      end

      def ordered_groups
        @ordered_groups ||=
          [patient_group] + other_groups
      end

      def patient_group
        @patient_group ||=
          groups.find { |group| group.resource == 'Patient' }
      end
      
      def other_groups
        @other_groups ||= groups - [patient_group]
      end

      def to_hash
        {
          ig_version:,
          groups: groups.map(&:to_hash)
        }
      end
    end
  end
end
