require "./lib/tasks/backend_task"

class DbTask < BackendTask
  def initialize
    database_config = Rails.configuration.database_configuration[Rails.env]
    super(
      image: "mysql",
      version: "8.0",
      port: database_config["port"],
      container_port: "3306",
      volume_path: "/var/lib/mysql",
      env: [
        "MYSQL_ROOT_HOST=%",
        "MYSQL_ROOT_PASSWORD=#{database_config['password']}"
      ]
    )
  end

  private

  def image_name
    is_arm = RUBY_PLATFORM.start_with? "arm"
    image = is_arm ? "mysql/mysql-server" : "mysql"

    return "#{image}:8.0" if is_arm && @version == "8"

    "#{image}:#{@version}"
  end
end
