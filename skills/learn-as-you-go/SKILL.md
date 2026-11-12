---
name: learn-as-you-go
description: Quick side-answer to a tangent question without derailing the main task. Use when the user asks a mid-build tangent, says "quick question" or "by the way", or wants to check their understanding without a full detour.
---

# Learn As You Go

A **side-answer**: a tight reply to a question that arrives mid-task, then an explicit return to the work. The skill exists to spend as few tokens as possible while still landing the answer.

## Trigger & Role

The human asks a tangent question mid-build. Common triggers: "quick question", "by the way", "learn as you go", "what's X?", "can you explain Y?", or any question that's clearly a side-check rather than a request to change the main task.

The agent answers in under a screen, cites the source if it's a fact, then names where the main task stands and resumes it.

## Rules

- **Answer first.** Lead with the answer. No preamble, no restating the question.
- **Under a screen.** If the answer needs more, say so and offer it as a separate task. Don't write a wall.
- **Bullets for parallel items, prose for argument.** Same rule as `/writing-shape`.
- **Ground new terms.** If the answer introduces a concept the human hasn't met, ground it in one sentence tied to their current task.
- **One source pointer.** File path, URL, commit SHA, or "from prior conversation". Not a bibliography.
- **Return explicitly.** End with one line: where the main task stands, and the next step.

## Tone

Direct, not padded. If the answer is "yes," say "yes" and stop. If the answer is "no," say "no" and give the one reason. The human is mid-build; they want the answer, not a conversation.

## Process

1. **Read the question.** What does the human want to know? If ambiguous, answer the most likely reading and name the alternative in one line.
2. **Answer.** Lead with the answer. 1-3 sentences for facts, a short bullet list for parallel items, prose for arguments.
3. **Ground.** If a new term appeared, ground it in one sentence with an example from the current task.
4. **Cite.** One pointer.
5. **Return.** One line: "Back to <task>: <next step>."

## Format

```
**Answer.** <1-3 sentences, or a short bullet list>

<optional: one-line grounding if a new term appeared>

**Source.** <one pointer>
**Back to <task>.** <next step>
```

## When not to use

- The question needs a real answer: a design decision, a bug diagnosis, a spec. Use the main flow.
- The question is about the codebase and the answer is in the code. Read the code.
- The question is "what should I do next?" That's the main task, not a side-answer.

## Anti-patterns

- **Restating the question.** The human knows what they asked.
- **Hedging.** "It depends" without a recommendation is a non-answer.
- **Going deep.** If the topic needs a full detour, say so and offer it as a separate task.
- **Losing the thread.** If the return line doesn't name the next step, the side-answer derailed the build.
- **Over-contextualizing.** Re-explaining the whole conversation wastes tokens. Answer the question, not the conversation.
- **Multiple examples.** One example maximum. If it needs two, it needs a separate task.

## Completion

Done when: the answer is delivered, the source is cited, and the main task is named with its next step.
