# ADR 0001: Model-Invoked Side-Answer Contract and Single-Screen Bound

**Status:** accepted · **Date:** 2026-11-12

## Context

During active coding sessions, developers frequently ask quick tangent questions ("quick question", "by the way", "what is X?") to verify their understanding mid-build. Without a dedicated discipline, LLM coding agents default to writing multi-paragraph explanations, restating the question, re-summarizing the entire conversation history, and dropping the thread of the active build.

## Decision

We design `learn-as-you-go` around seven load-bearing constraints from the Matt Pocock `/writing-for-agents` lens:

1. **Model-invoked, not user-invoked.** The whole point is "quick question without interrupting." Forcing the human to type `/learn-as-you-go` every time defeats the quickness. The frontmatter description costs one sentence of context load per turn; the token savings from not over-contextualizing every side-answer dwarf it.
2. **"Under a screen" is the completion criterion.** It is checkable, exhaustive, and forces the brevity that vague bounds ("keep it short") fail to enforce. One screen is a hard edge.
3. **"Answer first" is a leading word.** It recruits the model's pretraining priors about directness without spelling out "do not preamble, do not restate, do not hedge" as three separate rules. One token does the work of three.
4. **"Return explicitly" is the load-bearing rule.** Without it, a side-answer is a derail. With it, the skill is a detour that closes. The return line (`Back to <task>. <next step>`) is the contract: the main task resumes, or the side-answer failed.
5. **"Over-contextualizing" as an anti-pattern names the disease.** Existing assistants burn context window capacity by re-explaining the whole conversation. Naming the failure mode explicitly gives the agent a sharp target to avoid.
6. **Zero `/writing-shape` dependency.** The bullet-vs-prose rule ("Bullets for parallel items, prose for argument") is inlined as one line. A cross-skill pointer would cost context load on every invocation for a rule that takes eight words to state directly.
7. **The `When not to use` section is the honesty check.** A side-answer skill that fires on real architectural decisions, bug diagnoses, or codebase lookups is worse than no skill. Explicitly routing those back to the main flow protects build quality.

## Consequences

- `learn-as-you-go` remains a single-file, zero-dependency Markdown skill with `disable-model-invocation` omitted so the agent fires it automatically on tangent triggers.
- Every side-answer must end with `**Back to <task>.** <next step>` or it violates the completion criterion.
