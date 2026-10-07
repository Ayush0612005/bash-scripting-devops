# 🌿 OneScreenOut: the local AI that gives you one screen, then tells you to leave it

*This is a submission for the Hacktoberfest Open-Source AI Challenge Week 1: Touch Grass.*

## What I Built

I built **OneScreenOut**, a tiny local-AI CLI with one deliberate constraint: the entire useful interaction should fit on one screen.

You give it three pieces of context:

- how much time you have,
- what kind of place is around you,
- and your energy level.

A local **Gemma 3** model running through **Ollama** turns that into one safe outdoor micro-expedition with exactly three short steps, one sensory cue, and one safety reminder.

Then the program ends with the most important instruction:

> 📵 Pocket your phone now. The app is done; the outside part starts here.

I wanted the AI to be a launchpad into the real world rather than another feed that tries to keep the user engaged.

## Demo

Run:

```bash
ollama pull gemma3:1b
python app.py --minutes 15 --environment "college campus" --energy medium
```

The output is intentionally compact:

```text
🌿 OneScreenOut
Quest: <generated title>  •  15 min  •  local gemma3:1b

<one-sentence mission>

1. <step one>
2. <step two>
3. <step three>

Notice: <one sensory cue>
Safety: <one safety reminder>

📵 Pocket your phone now. The app is done; the outside part starts here.
```

There is also a clearly labeled `--sample` mode for checking the interface without pretending that static text came from AI.

## Code

GitHub:
https://github.com/Ayush0612005/bash-scripting-devops/tree/main/hacktoberfest-2026-week1-onescreenout

## How I Built It

The app is deliberately small:

- Python standard library for the CLI and HTTP request.
- Ollama on localhost for inference.
- Gemma 3 as the default open-weight model.
- JSON-constrained model output so the field card stays predictable and short.
- Prompt guardrails that avoid private property, traffic, unknown plants, wildlife contact, climbing, swimming, and other risky activities.

There are no hosted AI API keys and no user prompt is sent to a proprietary model service by the application.

The model is the core of the project: it adapts the outdoor mission to the user's time, surroundings, and energy. The surrounding Python code is mainly there to constrain that model output into a one-screen experience.

## Why Does Open Innovation Matter?

Open innovation matters here because the central promise is privacy, control, and the freedom to stop using the screen.

With an open-weight model running locally, I can inspect and change the prompt, swap models, tune the behavior, and keep the user's context on their own machine. I do not need a paid closed-model API to make the experience work.

That also makes the idea easier for other developers to fork. Someone could change the model, add accessibility-focused mission types, localize the prompts, or adapt the safety rules for a different environment.

For this project, open AI is not just a cost choice. It is what makes a short, private, offline-first interaction possible.

## What I Learned

The interesting design challenge was not “how do I make the AI say more?” It was the opposite: how do I constrain the model to say just enough that the user can close the laptop and go do something real?

That led to the strict JSON shape, the three-step limit, and the one-screen output.

#devchallenge #hf26challenge #opensource #ai
