# GetNote WeChat Story Checklist

Run this before sending cards to WeChat.

## P0

- Cover exists and is `2100 x 900`.
- Output mode is explicit: `hybrid`, `mobile-story`, or `desktop-readable`.
- In hybrid mode, body contains readable paragraphs plus matching images.
- In mobile-story mode, body cards are `1080 x 1440`.
- Body image count matches the intended outline.
- Every paragraph/image pair has one clear idea.
- Image-only skim works: cover + image titles/callouts communicate the main argument without reading body paragraphs.
- Text is readable on a phone screen.
- Desktop preview does not look like a narrow endless poster unless `mobile-story` was explicitly chosen.
- No title or body text is within 56px of an edge.
- No tiny table, dense code block, or unreadable chart text.
- No emoji icons.
- No repeated image used just to "fill space".
- Body card order is obvious without extra WeChat text.

## P1

- Visual rhythm alternates: light/dark/image/quote/process.
- Alibaba orange is an accent, not the whole page.
- Cover and body cards are separate assets.
- The WeChat title and digest still carry searchable context.
- Image text uses conclusions and decisions, not vague section labels.
- If the article is image-only, accept the accessibility/searchability/desktop-readability tradeoff.

## WeChat Draft QA

- Cover uses `00-cover-21x9.png`, not a body card.
- Hybrid body contains normal text plus ordered paragraph images.
- Mobile-story body may contain one stitched long image.
- No temporary cover image remains in the body.
- Save as draft only; do not publish without explicit confirmation.
