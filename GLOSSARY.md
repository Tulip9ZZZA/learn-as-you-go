# Learn As You Go Glossary

Ubiquitous language for the `learn-as-you-go` Agent Skill repository, governed by the `/domain-modeling` and `/writing-for-agents` rules.

## Language

**Side-answer**:
A bounded, under-one-screen reply to a tangent question asked mid-build that answers first, grounds any new term in the current task, cites one source pointer, and closes with an explicit return line.
_Avoid_: Tangent chat, mini-lesson, deep dive, Q&A detour

**Main task**:
The active build, refactor, debug loop, or spec slice the human and agent were executing before the tangent question arrived.
_Avoid_: Parent thread, primary workflow, backlog item

**Return line**:
The mandatory closing line of a side-answer (`Back to <task>. <next step>`) that restores focus to the main task and names its immediate next action.
_Avoid_: Sign-off, transition sentence, wrap-up

**Grounding line**:
A single sentence inside a side-answer that ties a newly introduced concept directly to a concrete module, seam, or step in the active main task.
_Avoid_: Background section, textbook definition, glossary dump

**Source pointer**:
A single verifiable reference (file path, URL, commit SHA, or prior conversation turn) supporting a factual claim in a side-answer.
_Avoid_: Bibliography, reference list, footnote wall

**Context load**:
The permanent token and attention cost of always-loaded steering material (such as a skill's frontmatter description or an `AGENTS.md` line) on every turn of a session.
_Avoid_: Prompt size, system overhead
