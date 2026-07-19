---
name: xhs-growth-operations
description: "Run a daily, review-gated Xiaohongshu growth loop: learn from real post data, turn one verified insight into plain-language image content, validate an 8-image package, fill a Creator Center draft, stop for human publication, and track 5h, 12h, and 24h results. Use when Codex must prepare, upload, resume, diagnose, learn from, score, retain, or eliminate Xiaohongshu content without batch-producing future days, fabricating cases or metrics, or clicking final Publish without fresh approval."
---

# Xiaohongshu Growth Operations

Operate one day and one content ID as a traceable learning loop. Keep the final Publish action under human control, use only verified facts, and make every image understandable in three seconds.

## Non-negotiable operating rule

- Generate full content, images, and a publishing task only for the current operating day.
- Do not pre-generate tomorrow's post or a 30-day publishing inventory.
- Keep future ideas only as unexpanded hypotheses; they must not contain finished copy, images, or publishing packages.
- Require the previous post's 24-hour review, or a clearly labeled incomplete-data exception, before selecting today's strategy.
- Change one primary variable per daily experiment so the result remains interpretable.

## Load the right references

- Read [references/workflow.md](references/workflow.md) before starting or resuming any content ID.
- Read [references/content-rules.md](references/content-rules.md) before writing, revising, or validating content.
- Read [references/record-schema.md](references/record-schema.md) before creating or updating runtime, publishing, or incident records.
- Read [references/recovery-rules.md](references/recovery-rules.md) after any package, browser, upload, login, CAPTCHA, account, or page-state failure.
- Read [references/data-tracking.md](references/data-tracking.md) after publication or when reviewing 5h, 12h, or 24h data.
- Read [references/daily-growth-loop.md](references/daily-growth-loop.md) before choosing or generating today's content.

## Required capabilities

1. Use the Xiaohongshu publishing-package skill, when available, to assemble text and ordered 1080x1440 PNG assets.
2. Use the selected browser-control skill for URL, account, DOM, upload, form filling, screenshots, and verification. Read that browser skill before acting.
3. Use Windows computer control only for a native file picker after the browser has verified the exact Creator Center URL. Never use desktop control to replace a failed browser-page channel.
4. Use the automation tool for scheduled 5h, 12h, and 24h follow-ups. Do not claim monitoring exists until the task is actually active or the user has confirmed a suggested automation card.

## Mandatory gates

- Run `scripts/preflight.ps1` against the absolute package path before controlling the editor.
- Confirm the live account name and public account ID against the approved local profile.
- Require explicit authorization before uploading the named package to the named account.
- Preserve correct partial work and resume from the last verified checkpoint.
- Stop at `review_required` before final Publish.
- Click Publish only after fresh explicit confirmation at the final review state.
- Mark `published` only after visible success or a clear user report; record the confirmation source.

## Content and audience rules

- Write from a knowledge-sharing perspective: begin with a specific, source-verified result or a familiar work scenario, not a generic AI concept, product pitch, or industry report.
- Use plain workplace language. Translate technical terms into the practical work they help complete.
- For this operating system, keep the final Xiaohongshu title within 20 Chinese characters.
- Give each image one message only. Once the image copy has been approved, do not silently rewrite it during design, packaging, or upload.
- Keep sources, case verification notes, pricing, delivery language, and implementation disclaimers in the internal asset record; do not add them to the public post unless the user explicitly requests them.
- End with one concrete discussion question, not a sales promise. Do not offer pricing or delivery in ordinary comment replies.

## State machine

Use exactly these forward states:

`input_received -> content_ready -> package_validated -> environment_ready -> page_verified -> assets_uploaded -> form_filled -> review_required -> published -> tracking_5h -> tracking_12h -> tracking_24h -> reviewed`

The next day's `input_received` may begin only after `reviewed`, unless the prior 24-hour metric is unavailable. For an exception, record the missing source and use `provisional_strategy` rather than claiming a final conclusion.

On failure, retain the last completed state and add `blocked_stage`, `error_code`, direct evidence, retry count, transmission status, and next action.

## Truth and privacy rules

- Label simulated scenarios and methods; never present them as real customer cases.
- Never invent views, clicks, likes, saves, comments, private messages, qualified leads, opportunities, revenue, dates, times, or links.
- Leave unavailable values blank and explain why.
- Never store passwords, cookies, tokens, OTPs, browser profiles, session exports, private-message identities, or customer personal data.
- Never bypass CAPTCHA, risk controls, rate limits, authentication, platform warnings, or browser safety controls.
- Never use private or reverse-engineered publishing APIs.

## Completion report

Report the content ID, account, final title, image count, completed state, exact records updated, observed warnings, publication confirmation source, next checkpoint, and any user action still required.
