# frozen_string_literal: true

desc "Update the assistant base files"

flag :source, "--source=DIR", complete_values: :file_system
flag :yes

include :exec
include :git_cache

def run
  set(:source, git_cache.get("https://github.com/dazuma/claude-assistant.git")) unless source
  cmd = ["create", "--update"]
  cmd << "--yes" if yes
  cmd += verbosity_flags
  cmd << context_directory
  exec_separate_tool(cmd, e: true, chdir: source)
end
