# CLAUDE.md

## Purpose

This directory is a workspace for conversations, small research projects, and
one-off tasks done by a human user in collaboration with Claude Code. Within
this workspace, Claude will act as the user's personal assistant, answering
questions, gathering and analyzing information, and performing other ad-hoc
tasks and small projects.

## Directories

- `memory/` : The `autoMemoryDirectory` setting points here, so memories are
  tracked in git. (Some memories are redirected to `CLAUDE.md` files.) See the
  Memory Management section below.
- `history/` : Past conversations are summarized in files in this directory.
  See the History section below.
- `subprojects/` : Durable subprojects occupy subdirectories under this
  directory. See the Subprojects section below.

## Memory Management

This project may host a number of distinct and unrelated tasks and
conversations over time, and preferences established for one may not apply to
another. Thus, memories should primarily record overall preference and profile
information about the *user* that would plausibly apply across multiple distinct
conversations, tasks, and subprojects.

Information specific to a particular task or subproject (such as ongoing project
status) should generally *not* be stored as memories. Information related to a
durable subproject located under the `subprojects/` directory should be written
to the `CLAUDE.md` within that subproject. Information specific to a single
conversation or task not associated with a subproject directory should generally
not be recorded at all unless it would plausibly affect future tasks. Ask the
user if you encounter a situation where it is unclear what to do.

Note that all memories are tracked by git, either in the `memory/` directory or
in subproject  `CLAUDE.md` files. If you write a memory mid-session, please
commit it at that time (confirming with the user before doing so). It is okay
if this commit sweeps in other uncommitted changes to `CLAUDE.md` files.

The `CLAUDE.md` file at the root of this repository (i.e. this current file) is
managed, and may be overwritten. Do not edit it.

## History

Summaries of sessions in this project are recorded in markdown files in the
`history/` directory. This enables searches of previous sessions as context for
future sessions. Each summary contains the key questions and conclusions from
the session, plus links to relevant resources and artifacts. We do not have a
particular use case for reading history yet. For now, you do not need to search
or read history unless asked explicitly.

Note that a history file should be created *only when explicitly requested*.
The user will explicitly invoke the `record-session` skill to create the file.

## Subprojects

Durable subprojects occupy directories under the `subprojects/` directory. Tasks
or ongoing subprojects that produce durable artifacts such as scripts, markdown
files, and other assets, should store them in such a subdirectory. Always
confirm with the user before starting a subproject directory.

Any scripts stored in a subproject should be written in Ruby unless otherwise
directed.
