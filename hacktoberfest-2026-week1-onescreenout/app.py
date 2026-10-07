#!/usr/bin/env python3
"""OneScreenOut: a local-AI outdoor micro-expedition generator for Hacktoberfest 2026."""

from __future__ import annotations

import argparse
import json
import sys
import textwrap
import urllib.error
import urllib.request
from pathlib import Path

OLLAMA_URL = "http://localhost:11434/api/generate"
DEFAULT_MODEL = "gemma3:1b"
OUTPUT_FILE = Path(__file__).with_name("quest_card.txt")


def build_prompt(minutes: int, environment: str, energy: str) -> str:
    return f"""
You are OneScreenOut, a local outdoor micro-expedition planner.

Create ONE safe outdoor mission for a person who has {minutes} minutes,
is near a {environment}, and has {energy} energy.

The mission must:
- get the person away from the screen immediately;
- be doable without buying anything;
- focus on noticing the real world with sight, sound, touch, or movement;
- never require entering private property, approaching traffic, touching unknown plants,
  feeding/handling wildlife, climbing, swimming, or doing anything unsafe;
- contain exactly 3 short steps;
- fit on one terminal screen;
- avoid medical, legal, or environmental claims;
- end by telling the user to pocket the phone.

Return ONLY valid JSON with exactly these keys:
{{
  "title": "max 6 words",
  "mission": "one sentence, max 22 words",
  "steps": ["short step 1", "short step 2", "short step 3"],
  "notice": "one sensory thing to notice",
  "safety": "one short safety reminder"
}}
""".strip()


def call_ollama(model: str, prompt: str) -> dict:
    payload = json.dumps(
        {
            "model": model,
            "prompt": prompt,
            "stream": False,
            "format": "json",
            "options": {"temperature": 0.75},
        }
    ).encode("utf-8")

    request = urllib.request.Request(
        OLLAMA_URL,
        data=payload,
        headers={"Content-Type": "application/json"},
        method="POST",
    )

    try:
        with urllib.request.urlopen(request, timeout=120) as response:
            outer = json.loads(response.read().decode("utf-8"))
    except urllib.error.URLError as exc:
        raise RuntimeError(
            "Could not reach local Ollama. Run `ollama serve` and "
            f"`ollama pull {model}` first."
        ) from exc

    raw = outer.get("response", "")
    if not raw:
        raise RuntimeError("Ollama returned an empty response.")

    try:
        quest = json.loads(raw)
    except json.JSONDecodeError as exc:
        raise RuntimeError("The model did not return valid JSON. Try again.") from exc

    required = {"title", "mission", "steps", "notice", "safety"}
    if set(quest) != required or not isinstance(quest.get("steps"), list) or len(quest["steps"]) != 3:
        raise RuntimeError("The model response did not match the required quest-card format.")

    return quest


def sample_quest() -> dict:
    return {
        "title": "Three Textures, Ten Minutes",
        "mission": "Walk outside and find three natural textures you can observe without disturbing anything.",
        "steps": [
            "Find one rough texture and describe it in three words.",
            "Find one smooth texture and notice how light falls across it.",
            "Stand still for 30 seconds and listen for the farthest sound.",
        ],
        "notice": "Look for one detail you would normally walk past.",
        "safety": "Stay in public, familiar areas and keep clear of roads or hazards.",
    }


def render_card(quest: dict, minutes: int, model_label: str) -> str:
    lines = [
        "🌿 OneScreenOut",
        f"Quest: {quest['title']}  •  {minutes} min  •  {model_label}",
        "",
        textwrap.fill(quest["mission"], width=76),
        "",
    ]
    for idx, step in enumerate(quest["steps"], start=1):
        lines.append(f"{idx}. {textwrap.fill(step, width=72)}")
    lines.extend(
        [
            "",
            f"Notice: {quest['notice']}",
            f"Safety: {quest['safety']}",
            "",
            "📵 Pocket your phone now. The app is done; the outside part starts here.",
        ]
    )
    return "\n".join(lines)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate a one-screen outdoor quest with a local open-weight model."
    )
    parser.add_argument("--minutes", type=int, default=15, choices=[5, 10, 15, 20, 30, 45, 60])
    parser.add_argument("--environment", default="campus or neighborhood")
    parser.add_argument("--energy", default="medium", choices=["low", "medium", "high"])
    parser.add_argument("--model", default=DEFAULT_MODEL)
    parser.add_argument(
        "--sample",
        action="store_true",
        help="Show a clearly labeled non-AI sample without calling Ollama.",
    )
    return parser.parse_args()


def main() -> int:
    args = parse_args()

    if args.sample:
        quest = sample_quest()
        label = "SAMPLE (no AI call)"
    else:
        try:
            quest = call_ollama(
                args.model,
                build_prompt(args.minutes, args.environment, args.energy),
            )
        except RuntimeError as exc:
            print(f"Error: {exc}", file=sys.stderr)
            return 1
        label = f"local {args.model}"

    card = render_card(quest, args.minutes, label)
    OUTPUT_FILE.write_text(card + "\n", encoding="utf-8")
    print(card)
    print(f"\nSaved locally to: {OUTPUT_FILE.name}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
