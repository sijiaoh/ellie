require "open3"

class BackendTask
  def initialize(image:, version:, port:, container_port: nil, volume_path: nil, env: []) # rubocop:disable Metrics/ParameterLists
    @image = image
    @version = version
    @port = port
    @container_port = container_port || port
    @container_name = "#{project_name}-#{image}"
    @env = env
    @volume_path = volume_path
  end

  def start
    status = docker_command "start #{@container_name}"
    if status[:successed]
      print_to_stdout "#{@container_name} running on #{@port}."
    else
      up
    end
  end

  def stop
    status = docker_command "rm -f #{@container_name}"
    if status[:stderr].include? "No such container:"
      print_to_stdout "Container not found."
    else
      print_to_stdout "Removed container."
    end
  end

  def remove
    stop

    status = docker_command "volume rm #{@container_name}"
    if status[:stderr].include? "No such volume:"
      print_to_stdout "Volume not found."
    else
      print_to_stdout "Removed volume."
    end
  end

  private

  def project_name
    Rails.application.class.module_parent.name.downcase
  end

  def print_to_stdout(str)
    p str # rubocop:disable Rails/Output
  end

  def raise_if_status_failed(stderr:, successed:, command:)
    raise StandardError, { command:, stderr: } unless successed
  end

  def docker_command(command)
    o, e, s = Open3.capture3("docker #{command}")
    { stdout: o, stderr: e, status: s, successed: s.success? }
  end

  def up
    command = up_command
    status = docker_command(command)
    raise_if_status_failed(**status.slice(:stderr, :successed), command:)

    print_to_stdout "Created #{@container_name} on #{@port}."
  end

  def image_name
    "#{@image}:#{@version}"
  end

  def up_command
    env = @env.map { |e| ["--env", e] }.flatten

    if @volume_path.present?
      volume = [
        "--volume",
        "#{@container_name}:#{@volume_path}"
      ]
    end

    [
      "run",
      "--name #{@container_name}",
      *env,
      "--publish",
      "#{@port}:#{@container_port}",
      *volume,
      "-d",
      image_name
    ].join(" ")
  end
end
