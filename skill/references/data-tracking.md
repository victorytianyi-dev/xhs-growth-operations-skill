# Data tracking and optimization

## Checkpoint fields

Record one row per content ID and checkpoint:

| Field | Rule |
|---|---|
| Content ID | Stable key shared by assets, publishing, validation, and leads |
| Final title | Exact title actually published |
| Publication date/time | Exact value when available; otherwise label temporary basis |
| Checkpoint | `5h`, `12h`, or `24h` |
| Exposure | Platform-reported impressions only |
| Clicks | Platform-reported cover/entry clicks only; blank if unavailable |
| Likes, saves, comments | Platform counts at observation time |
| Private messages | Messages attributable to the post when verifiable |
| Qualified inquiries | User described industry or task and accepted follow-up |
| Opportunities | Responsible person, need, and next commercial step are confirmed |
| Notes | Data source, access limitation, anomaly, or observation |

Never calculate a missing platform metric from another metric.

## Derived rates

Calculate only when both inputs exist:

- Click rate = clicks / exposure.
- Engagement rate = (likes + saves + comments) / exposure.
- Save rate = saves / exposure.
- Private-message rate = private messages / exposure.
- Qualified-lead rate = qualified inquiries / private messages.

Label derived rates and retain the raw counts.

## Optimization rules

- Low exposure: test title and cover first; do not rewrite the content model yet.
- Exposure present but clicks low: strengthen cover contrast, target-user cue, conflict, and benefit.
- Clicks present but saves low: add a checklist, steps, template, or reusable framework.
- Saves high but private messages low: improve CTA specificity and the value promised for the keyword.
- Private messages high: preserve the content model, audience, pain point, and CTA; create a controlled variant.
- Comments repeat one question: add it to the pain-point database and next content batch.
- Qualified inquiries high: prioritize the matching diagnosis and follow-up workflow.
- No metric is available: record the access limitation; do not output a performance conclusion.

## Checkpoint interpretation

- 5h identifies immediate packaging signals, not final success.
- 12h helps distinguish passive saves from active questions.
- 24h is the first decision point for replication, conversion changes, or packaging tests.

Do not delete or overwrite an earlier checkpoint. Append and compare.
