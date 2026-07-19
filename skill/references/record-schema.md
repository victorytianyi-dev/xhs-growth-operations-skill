# Record schema

## Runtime JSON

Maintain one file per content ID with:

- `schema_version`
- `content_id`
- `state`
- `blocked_stage`
- `error_code`
- `account_name`
- `account_id`
- `evidence[]`
- `retry_count`
- `transmission_status`
- `packaged_title`
- `final_title`
- `image_count`
- `body_character_count`
- `final_publish_clicked`
- `publication_confirmation_source`
- `publication_date`
- `publication_time`
- `publication_url`
- `tracking_schedule_basis`
- `tracking_checkpoints[]`
- `next_action`
- `updated_at`

Use null for unknown scalar values. Never use a plausible placeholder as a fact.

## Publishing records

Update these logical records after publication:

1. Published registry: content ID, actual title, date/time, link or local evidence, tracking state, review state.
2. Daily task board: date, content ID, status, responsible party, 5h/12h/24h feedback state.
3. Validation tracker: append one row for each checkpoint with raw metrics.
4. Learning notes: recurring questions, customer concerns, new pain points, and next content direction.

## Incident record

Record:

- timestamp and content ID;
- approved account name and public account ID;
- last completed state and blocked stage;
- error code and direct visible evidence;
- checks performed and retry count;
- next safe action;
- whether assets or text were transmitted.

Never record credentials, cookies, tokens, OTPs, customer identities, browser profile paths, or browsing history.

## Transmission status

Use factual values such as:

- `not_started`
- `assets_uploaded`
- `draft_complete_waiting_for_human_review`
- `published_confirmed_visibly`
- `published_confirmed_by_user`
- `tracking_complete_5h`
- `tracking_complete_12h`
- `tracking_complete_24h`
