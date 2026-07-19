# Recovery rules

## Failure matrix

| Error code | Evidence | Retry | Required next action |
|---|---|---:|---|
| `PACKAGE_INVALID` | Manifest parse, missing file, wrong order or dimensions | 0 | Repair and revalidate the package |
| `CHROME_DISCOVERY_FAILED` | Open-tab listing fails twice | 1 | Run official Chrome diagnostics |
| `STALE_TAB_CLAIM` | Old tab claim times out; blank and fresh target tabs work | 0 | Continue on a fresh target tab and mark the incident recovered |
| `CHROME_CLAIM_TIMEOUT` | Old tab, blank isolation, and fresh target all fail | 0 | Restart Chrome/Codex once; repair the plugin only if repeated |
| `PAGE_CONTROL_TIMEOUT` | Claimed page cannot return URL, title, or snapshot | 0 | Record incident and repair the browser channel |
| `URL_CONTEXT_UNVERIFIED` | Desktop control cannot verify browser URL | 0 | Stop desktop control and return to the browser channel |
| `FILE_URL_ACCESS_DISABLED` | File chooser rejects local paths | 1 | Enable extension file-URL access and retry once |
| `UPLOAD_PARTIAL` | Thumbnail count/order differs from manifest | 0 | Preserve and reconcile the visible partial draft |
| `AUTH_REQUIRED` | Login is visible | 0 | Ask the user to authenticate manually |
| `CAPTCHA_OR_RISK_CONTROL` | CAPTCHA or safety prompt is visible | 0 | Hand off to the user; never bypass |
| `ACCOUNT_MISMATCH` | Live identity differs from approved profile | 0 | Stop and obtain explicit account confirmation |
| `TITLE_LIMIT` | Platform counter exceeds its maximum | 1 | Shorten while preserving audience, conflict, benefit, and topic; record both titles |
| `TRACKING_ACCESS_BLOCKED` | Analytics requires login, permission, or unavailable page | 0 | Leave metrics blank and notify the user |

## Browser recovery sequence

1. Preserve the last verified tab and runtime checkpoint.
2. Run official read-only Chrome diagnostics.
3. If only one existing tab times out, claim or create `about:blank` and read its URL/DOM.
4. If blank succeeds, create a new target tab and navigate once to the exact Creator Center URL.
5. Continue on the fresh tab only after URL, title, DOM, and account are verified.
6. Reinstall or repair the Chrome plugin only when blank isolation or a fresh target also fails after one restart.

An old tab can be stale even when the extension, native host, and Chrome process are healthy. Do not misdiagnose a single-tab claim timeout as an installation failure.

## Partial draft recovery

Preserve correct fields and thumbnails. Resume from the last completed checkpoint. Never blindly re-upload images or overwrite verified text.

## Hard stops

Stop for account mismatch, authentication, CAPTCHA, risk control, content warning, unverified case claims, or missing final-publish approval.
