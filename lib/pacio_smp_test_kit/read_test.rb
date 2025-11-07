# frozen_string_literal: true

require 'us_core_test_kit/read_test'

module PacioSMPTestKit
  module ReadTest
    include USCoreTestKit::ReadTest
    extend USCoreTestKit::ReadTest

    def perform_read_test(resources, reply_handler = nil, delayed_reference: false, resource_ids: nil)
      if resources.blank? && resource_ids.present?
        resources = resource_ids.split(',').map do |id|
          resource_class.new(id: id.strip)
        end
      end

      super(resources, reply_handler, delayed_reference: delayed_reference)
    end
  end
end
