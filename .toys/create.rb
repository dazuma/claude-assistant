# frozen_string_literal: true

desc "Create an assistant project"

required_arg :dest_directory
flag :yes
flag :update

include :fileutils
include :exec
include :terminal

def run
  if update
    @updated = false
    update_files
    finish_update
  else
    create_dir
    install_files
    init_config
    finish_create
  end
end

def update_files
  update_one("root-claude.md", "CLAUDE.md")
  update_one("toys/update.rb", ".toys/update.rb")
  update_one("skills/record-session/SKILL.md", ".claude/skills/record-session/SKILL.md")
end

def update_one(from, to)
  from_path = ::File.join(context_directory, "files", from)
  to_path = ::File.join(dest_directory, to)
  from_content = ::File.read(from_path)
  to_content = ::File.file?(to_path) ? ::File.read(to_path) : ""
  if from_content == to_content
    puts "No change to #{to_path}."
    return
  end
  puts "Updating #{to_path}..."
  mkdir_p(::File.dirname(to_path))
  ::File.write(to_path, from_content)
  exec(["git", "add", to], e: true, chdir: dest_directory)
  @updated = true
end

def finish_update
  if @updated
    puts "Committing updates..."
    exec(["git", "commit", "-m", "Updated assistant project from claude-assistant"], e: true, chdir: dest_directory)
  else
    puts "No updates needed."
  end
  puts "Done.", :bold
end

def create_dir
  mkdir_p(dest_directory)
  set(:dest_directory, ::File.realpath(dest_directory))
  puts "Initializing repo..."
  check_exists(::File.join(dest_directory, ".git"))
  exec(["git", "init"], e: true, chdir: dest_directory)
end

def install_files
  install_one("root-claude.md", "CLAUDE.md")
  install_one("toys", ".toys")
  install_one("skills", ".claude/skills")
  install_one("memory", "memory")
  install_one("history", "history")
  install_one("subprojects", "subprojects")
end

def init_config
  require "json"
  puts "Configuring..."
  config = {
    "autoMemoryDirectory" => ::File.join(dest_directory, "memory")
  }
  config_json = ::JSON.pretty_generate(config)
  path = ".claude/settings.json"
  ::File.write(::File.join(dest_directory, path), config_json)
  exec(["git", "add", path], e: true, chdir: dest_directory)
end

def finish_create
  puts "Creating initial commit..."
  exec(["git", "commit", "-m", "Set up assistant project from claude-assistant"], e: true, chdir: dest_directory)
  puts "Done.", :bold
end

def install_one(from, to)
  from_path = ::File.join(context_directory, "files", from)
  to_path = ::File.join(dest_directory, to)
  puts "Copying to #{to_path}..."
  check_exists(to_path)
  mkdir_p(::File.dirname(to_path))
  cp_r(from_path, to_path)
  exec(["git", "add", to], e: true, chdir: dest_directory)
end

def check_exists(path)
  return unless ::File.exist?(path) || ::File.symlink?(path)
  if yes || confirm("#{path} exists. Replace? ", default: true)
    rm_rf(path)
  else
    puts("Aborted", :red)
    exit(1)
  end
end
