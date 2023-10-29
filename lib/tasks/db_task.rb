require "./lib/tasks/backend_task"

class DbTask < BackendTask
  def initialize
    database_config = Rails.configuration.database_configuration[Rails.env]
    super(
      image: "postgres",
      version: "15.4",
      port: database_config["port"],
      container_port: "5432",
      volume_path: "/var/lib/postgresql",
      env: [
        "POSTGRES_PASSWORD=#{database_config['password']}"
      ]
    )
  end
end
