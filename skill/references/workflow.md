# End-to-end workflow

## 1. Resolve project and content ID

1. Locate the canonical project root and read its `AGENTS.md`.
2. Resolve the content ID, approved account profile, source Markdown, publishing package, and runtime record.
3. If the content ID or account is ambiguous, stop before external writes and request the missing choice.

## 2. Prepare content

Confirm the package contains:

- one final title plus optional alternatives;
- body text, interaction CTA, and private-message keyword;
- relevant tags grouped by industry, AI, audience, and traffic intent;
- `cover.png` followed by `page1.png` through `page7.png` in that order;
- a manifest that declares filenames and order;
- authenticity and compliance notes.

Keep the final title within 20 Chinese characters. If a platform limit requires a further edit, preserve its target user, conflict, benefit, and topic, then record both the packaged and final title.

Before image generation, compare every page against the approved copy. Do not add headers, footers, sources, pricing, delivery language, or technical jargon unless the approved copy contains them.

## 3. Validate the package

Run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/preflight.ps1 -PackagePath <absolute-package-path>
```

Proceed only when the manifest parses, required files exist, ordered images are 1080x1440 PNG, and the selected browser environment is healthy. Rerun read-only system diagnostics with scoped approval when normal access returns `unknown_due_to_access`.

## 4. Verify the browser and account

Use four observable handshake steps:

1. List open tabs once; retry once after two seconds only if listing fails.
2. Claim the exact Creator Center tab from that fresh list.
3. Read URL and title.
4. Capture a fresh DOM snapshot or screenshot.

Verify the Creator Center URL, editor type, account name, and public account ID before transmission.

## 5. Resume or create the draft

Inspect the editor before modifying it. If thumbnails or fields already match the manifest, preserve them.

For a new image post:

1. Start the browser file-chooser wait before clicking the unique upload control.
2. Select `cover.png`, then content pages in manifest order.
3. Verify the visible thumbnail count and order.
4. Fill the title and confirm the platform character counter accepts it.
5. Fill body, CTA, tags, private-message keyword, and explicitly requested schedule fields.
6. Verify the preview, account, eight-image count, title counter, body counter, warnings, and missing fields.
7. Write `review_required` and hand the visible draft back to the user.

Do not toggle optional declarations, components, collections, locations, or visibility settings unless the content package or user explicitly requires them.

## 6. Human review and final publication

At the review gate, report exactly what is present and any platform-driven edits. Ask for fresh explicit confirmation.

After confirmation:

1. Reclaim the same draft and verify account, title, body, image count, and warnings again.
2. Click Publish once.
3. Verify visible success, the note-management record, or the public post.
4. If the user publishes manually, accept the report but record `publication_confirmation_source: user_report`; leave exact time and link null until confirmed.
5. Update runtime, published registry, task board, and validation tracker.

## 7. Schedule early data tracking

Anchor checkpoints to the exact publication time. If unknown, use the user-confirmation time as a temporary basis and label it.

- 5h: early distribution and click response.
- 12h: save/comment intent and initial private-message conversion.
- 24h: full-day performance and first optimization decision.

Create one follow-up task for each checkpoint. Ensure the tasks are active; suggested cards still require user confirmation.

## 8. Review and improve

At 24h, compare the three snapshots without overwriting earlier rows. Select the next action from the optimization rules in [data-tracking.md](data-tracking.md). Record a learning even when performance is weak; do not rewrite history.
