# 🌿 OneScreenOut

> Hacktoberfest 2026 — Open-Source AI Challenge, Week 1: **Touch Grass**

OneScreenOut is a tiny offline-first CLI that uses a **local open-weight Gemma model through Ollama** to generate a single outdoor micro-expedition. The design rule is simple: **the screen should be the shortest part of the experience**.

You give it a time budget, your surroundings, and your energy level. The local model returns one compact field card with exactly three steps. The program saves the card locally, prints it once, and ends with a reminder to pocket your phone.

## Why this fits “Touch Grass”

Most AI products are optimized to keep the conversation going. OneScreenOut does the opposite:

1. Ask for one useful plan.
2. Generate it locally.
3. Leave the screen.
4. Go outside.

The model is not decoration: it is the component that turns the user's context into a safe, varied real-world mission.

## Open-source AI core

- **Model:** Gemma 3 (default: `gemma3:1b`)
- **Runtime:** Ollama
- **Inference:** Localhost only (`http://localhost:11434`)
- **Cloud API keys:** None
- **App dependencies:** Python standard library only

After the model has been downloaded once, the quest-generation path can run without sending the user's prompt to a hosted AI service.

## Quick start

### 1. Install Ollama

Install Ollama for your operating system, then start it.

### 2. Pull the model

```bash
ollama pull gemma3:1b
```

### 3. Run OneScreenOut

```bash
python app.py --minutes 15 --environment "college campus" --energy medium
```

Example shape:

```text
🌿 OneScreenOut
Quest: Three Textures, Ten Minutes  •  15 min  •  local gemma3:1b

Walk outside and complete one small observation mission.

1. ...
2. ...
3. ...

Notice: ...
Safety: ...

📵 Pocket your phone now. The app is done; the outside part starts here.
```

The generated card is also written to `quest_card.txt`.

## Sample mode

To inspect the UI without running a model:

```bash
python app.py --sample
```

Sample mode is explicitly labeled **SAMPLE (no AI call)** so it cannot be confused with model output.

## Safety design

The prompt tells the model not to send users onto private property, toward traffic, into water, climbing, touching unknown plants, or approaching/feeding wildlife. It also asks for public, familiar, low-risk activities and includes a short safety reminder on every card.

## Project structure

```text
.
├── app.py
├── README.md
├── DEV_SUBMISSION.md
└── LICENSE
```

## Why open innovation matters

A local open-weight model makes the core idea possible without turning an outdoor break into another cloud data flow. The user can inspect the prompt, swap the model, change the guardrails, and run the inference on their own machine. There is no paid proprietary model API required for the experience.

That matters for this project because the product promise is not “chat with AI longer.” It is “use AI briefly, then go experience the world.”

## Hacktoberfest

Built during the October 5–11, 2026 Week 1 challenge window for the DEV Hacktoberfest Open-Source AI Challenge: **Touch Grass**.

