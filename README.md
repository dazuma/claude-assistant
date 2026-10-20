# Claude-assistant repo creator

This is a simple personal assistant agent based on Claude Code. This agent is
meant for interactive one-off tasks and conversations and short-term projects.

I use it instead of Claude chat to research information, investigate issues
with my local computer, and perform one-off tasks or short-term projects that
don't need a full repo directory. For example, I use it often with Matt Pocock's
`teach` skill.

The current repo is a "creator" repo. It provides the tools to create and
update an actual assistant agent project.

## Installation

To create an agent, you will need the following installed:

* Claude Code
* Ruby (2.7 or later)
* The [Toys](https://rubygems.org/gems/toys) gem

Clone this repository, then in the repository root directory:

```
toys create path/to/agent
```

Where `path/to/agent` is the file path to where you want your agent directory
to live. (The directory does not need to exist yet.)

## Using the agent

The agent is basically just a Claude Code project with a particular setup:

* The auto-memory directory points into the repo itself, and is stored in git.
  This lets you introspect and edit the memories at any time.
* There is a directory that records a history of sessions done in the repo.
  This isn't actually used for anything yet, but I suspect it will be useful
  later.
* A built-in skill `record-session` kicks off the history recording and
  triggers writing of any pending memories.
* In many cases, a session doesn't need to record any files in the repo, but
  for tasks that do, they can create subdirectories.
