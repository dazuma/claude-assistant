---
name: record-session
description: Records the current session in the history and memories.
disable-model-invocation: true
---

# Record the current session

This skill is invoked explicitly by the user when the session is expected to
end imminently. The goal is to:

- Summarize the session to a unique file in the `history/` directory.
- Trigger recording of any relevant memories from this session.

## Steps

### 1. Get the current time

Get the current local timestamp, which you will use in subsequent steps.

### 2. Record history

Create a markdown file, in the `history/` directory, with a name of the form
`YYYYMMDD-HHMMSS-topic-title.md`. The file name includes the timestamp you
obtained in step 1, and a few words (reasonable for a file name length)
identifying the general topic of the session.

The file content should consist of front matter, surrounded by `---` delimiters,
followed by markdown content.

The front matter should include the `session_id:` key, recording the current
session UUID (from `$CLAUDE_CODE_SESSION_ID`). If the UUID is not available,
leave out the field entirely.

The markdown content should contain a brief summary of what was discussed or
accomplished in *the current session*. It should *not* contain a full session
transcript, but should record at least:

- The key questions that drove the session. (This may or may not be what was
  asked in the initial prompt.)
- The key conclusions, results, or learnings from the session.
- Links to any key resources or artifacts found, consulted, or created during
  the session. These may be repo-relative links to files/directories within
  this project, absolute links to non-project files, or URLs.

The length of the file content should be between one paragraph and one page,
depending on the length and complexity of the session. It is expected that most
files will be less than half a page.

If this skill has been invoked previously in this session, it will have written
a history file previously. Search the history directory for the current session
UUID in the front matter to be sure. If a previous history file exists, delete
it and replace it with a new file, which should summarize the entire session,
not just what happened since the previous invocation.

### 3. Record memories

The user expects to end the session imminently, so any pending memory updates
that are appropriate to do for the current session should be performed now.
This may involve changes under the `memory/` directory, and/or changes to
`CLAUDE.md` files in subproject directories.

Note that it is not a requirement to make any memory updates. If no updates are
warranted based on your instructions for auto-memory, just do nothing for this
step.

### 4. Git commit

Make a git commit with the changes done to history and memories by this skill.
The commit message should take the following form, using the timestamp you
obtained in step 1. Note the timestamp format here is different from what you
used in the history file name.

    Recorded session at YYYY-MM-DD HH:MM:SS on "the session topic"

It is okay if this commit sweeps in other uncommitted changes to `CLAUDE.md`
files.

### 5. Report results

Report to the user:

- The name of the history file written (and the old file removed, if any.)
- A summary of the memory updates performed, or, if no memories were modified,
  a note saying so.
- The commit message for the new commit.
