require "rails/generators/erb/scaffold/scaffold_generator"

module RailsTemplate
  module Generators
    class ScaffoldGenerator < Erb::Generators::ScaffoldGenerator
      source_root File.expand_path("templates", __dir__)

      def create_root_folder
        empty_directory File.join("app/views", controller_file_path)
      end

      def copy_view_files
        views.each do |view|
          formats.each do |format|
            filename = filename_with_extensions(view, format)
            template filename, File.join("app/views", controller_file_path, filename)
          end
        end

        template "partial_index.html.erb",
                 File.join("app/views", controller_file_path, "_#{singular_table_name}_index.html.erb")
        template "partial.html.erb", File.join("app/views", controller_file_path, "_#{singular_table_name}.html.erb")
      end

      def copy_policy_file
        template "policy.rb.erb.tt",
                 File.join("app/policies", controller_class_path, "#{singular_table_name}_policy.rb")
      end

      private

      def view_i18n_scope
        @view_i18n_scope ||= route_url.tr("/", ".").gsub(/\A./, "")
      end

      def views
        paths = Dir[File.join(File.expand_path("templates", __dir__), "/*.html.erb.tt")]
        names = paths.map do |path|
          File.basename(path, ".html.erb.tt")
        end

        reject_list = %w[partial_index partial]
        names.reject do |name|
          reject_list.include? name
        end
      end
    end
  end
end

# For annotate command Zeitwerk::NameError error.
module Generators
  module RailsTemplate
    module Scaffold
      class ScaffoldGenerator # rubocop:disable Lint/EmptyClass
      end
    end
  end
end
