# GetNote WeChat Story Checklist

Run this before sending cards to WeChat.

## P0

- Cover exists and is `2100 x 900`.
- Output mode is explicit: `hybrid`, `mobile-story`, or `desktop-readable`.
- Author is left empty unless the user explicitly requests an author name.
- A `没时间看全文版` block exists before the detailed body unless explicitly omitted by the user.
- `没时间看全文版` contains exactly one item per paragraph image.
- In hybrid mode, body contains readable paragraphs plus matching images.
- Detailed body sections have colored headings. Alibaba orange is present, and secondary accents create rhythm without overwhelming the article.
- In mobile-story mode, body cards are `1080 x 1440`.
- Body image count matches the intended outline.
- Quick-point count, paragraph count, and body-image count match.
- Every paragraph/image pair has one clear idea.
- Image-only skim works: cover + image titles/callouts communicate the main argument without reading body paragraphs.
- Text is readable on a phone screen.
- Desktop preview does not look like a narrow endless poster unless `mobile-story` was explicitly chosen.
- Industry readers can identify the real system, constraints, and boundary conditions without feeling the article is technically hollow.
- Ordinary readers can answer what the system is for and what changes in the field after reading the skim block and first two sections.
- The article includes at least one concrete field condition and at least one human actor or operator perspective.
- The article does not drift into generic AI language when a concrete workflow, tradeoff, or consequence can be named.
- No title or body text is within 56px of an edge.
- No tiny table, dense code block, or unreadable chart text.
- No emoji icons.
- No repeated image used just to "fill space".
- No code-only placeholder cards. Paragraph images must use generated raster scenes or real relevant visuals, with any local text overlay applied only for text fidelity.
- Body card order is obvious without extra WeChat text.

## P1

- Visual rhythm alternates: light/dark/image/quote/process.
- Alibaba orange is an accent, not the whole page.
- Generated image prompts are saved in `outline.md` or a prompt file before generation.
- Cover and body cards are separate assets.
- The WeChat title and digest still carry searchable context.
- Image text uses conclusions and decisions, not vague section labels.
- If the article is image-only, accept the accessibility/searchability/desktop-readability tradeoff.

## WeChat Draft QA

- Cover uses `00-cover-21x9.png`, not a body card.
- Hybrid body contains normal text plus ordered paragraph images.
- Temporary preview/readback verifies the visible title editor, hidden title field, and side-card title all equal the article title.
- Temporary preview/readback verifies author is empty unless the user explicitly supplied one.
- Temporary preview/readback verifies body image count, paragraph presence, and target word count.
- Temporary preview/readback or screenshot verifies colored section headings are visible in the body, not collapsed into unstyled plain text.
- Numbered section headings preserve a visible gap between the sequence and the title in the WeChat preview, e.g. `01　标题`. Use a preview-stable separator, not a normal collapsible space.
- Mobile-story body may contain one stitched long image.
- No temporary cover image remains in the body.
- Save as draft only; do not publish without explicit confirmation. Filling the editor is not completion until the visible `保存为草稿` button was clicked and a temporary preview/readback confirms the saved server version.
