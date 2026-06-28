# curso-interactivo

Curso interactivo local HTML para aprender a crear CRM hotelero con IA

> **Education / Tutoring** — Tutor → explain → quiz → grade, over per-learner mastery memory with an abstain-not-hallucinate policy.
>
> Generated with [`create-agent-harness`](https://github.com/ruvnet/agent-harness-generator). WASM kernel, multi-host support, witness-signed releases.

## Install

```bash
npm install -g curso-interactivo
curso-interactivo init
curso-interactivo doctor
```

## Agents

| Agent | Role |
|---|---|
| `tutor` | Picks the next concept to teach from the learner's mastery map. |
| `explainer` | Explains the picked concept at the right depth. |
| `quiz-master` | Generates calibrated quiz items. |
| `grader` | Grades open-ended responses against the hidden rubric. |

This harness ships with the **hermes** adapter.

## License

MIT
