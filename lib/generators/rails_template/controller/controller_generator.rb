require "rails/generators/erb/controller/controller_generator"

module RailsTemplate
  module Generators
    class ControllerGenerator < Erb::Generators::ControllerGenerator
      source_root File.expand_path("templates", __dir__)
    end
  end
end

# For annotate command Zeitwerk::NameError error.
module Generators
  module RailsTemplate
    module Controller
      class ControllerGenerator # rubocop:disable Lint/EmptyClass
      end
    end
  end
end
