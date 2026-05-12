---
name: getnote-wechat-story
description: Load when the user wants to turn GetNote/Get笔记 notes, recordings, drafts, or project reviews into a WeChat Official Account article with author-style grounding, paragraph-matched images, dual-device reading, or draft publishing.
---

# GetNote WeChat Story

Turn an article or outline into a WeChat Official Account draft composed of **readable text plus tightly matched story images**.

This skill is a routed, progressively loaded directory:

- `SKILL.md` = workflow and rules
- `assets/template.html` = single-file deck template
- `references/` = setup, author grounding, layouts, QA, evals, and gotchas
- `scripts/render_cards.sh` = deterministic export to PNG

But the target is different: **not horizontal presentation slides**, and not a purely decorative WeChat rich-text article. The default output is a dual-device article: readable paragraphs for desktop/search/copy, plus story images that preserve the mobile visual rhythm.

## Output Contract

Default output mode: `hybrid`.

- Body = normal WeChat text paragraphs plus paragraph-level images
- Best for both phone and desktop
- Keeps text searchable, copyable, and easier to read on desktop
- Avoids the narrow "one very tall poster" look on desktop
- Uses a two-layer reading model: busy readers can scan the images for the key message; readers with time can read the paragraphs for full context.
- Starts with a `没时间看全文版` skim block before the detailed body unless the user explicitly says not to include it.

Optional output modes:

- `mobile-story`: image-first long visual story for phone reading; use when the user explicitly wants a 公众号长图 or image-only article
- `desktop-readable`: text-first article with wider images; use when the article is mainly for desktop reading, client forwarding, search, or archive

Default image spec:

- Hybrid paragraph image: `1200 x 900` or `1600 x 1200` PNG, ratio `4:3`
- Mobile-story card: `1080 x 1440` PNG, ratio `3:4`
- Mobile-story long image: `1080 x N` PNG, made by vertically stitching all body cards
- Cover card: `2100 x 900` PNG, ratio `21:9`
- Article body: prefer hybrid text + images unless the user explicitly chooses image-only long story
- Each image must be readable on mobile without zoom and not look cramped on desktop
- Each image contains its own short title/callout/visual treatment
- Do not repeat the same background or illustration mechanically

WeChat watermark rule:

- If the account has image watermark enabled and the output mode is `mobile-story`, do **not** upload each body card as a separate image.
- Upload `output/body-long.png` as the body instead, so the watermark appears at most once at the end instead of after every card.
- Keep individual `01-card.png`, `02-card.png`, etc. for QA, revisions, and reuse.
- In `hybrid` mode, accept paragraph image watermarks unless the user explicitly prefers a stitched image-only body. Hybrid mode prioritizes readable text and dual-device layout.

Seamless story rule:

- If `mobile-story` mode feels like hard slide pages, do **not** keep stitching separate cards.
- Switch to a single continuous story canvas such as `story.html`, rendered directly to one `1080 x N` image.
- Remove per-page footers, page numbers, repeated card backgrounds, and hard section boundaries.
- Use a continuous visual device, such as a timeline, road, signal line, pipeline, or workflow thread, to connect text and images.
- QA the long image by checking top, middle, and bottom crops plus a full-height scaled preview before uploading.

Hybrid story rule:

- If `hybrid` mode feels visually fragmented, keep the readable paragraphs and improve the image sequence instead of converting the whole body to one long image.
- Use consistent visual motifs across the paragraph images, but preserve normal WeChat text between them.
- The image layer must work as an executive skim: reading only the cover, image titles, callouts, and visual sequence should reveal the article's main argument.
- The text layer must work as the detailed version: paragraphs provide the scene, reasoning, proof, boundary, and nuance behind each image.

## When To Use

Use this skill when the user wants:

- A WeChat article that reads well on both phone and desktop
- Long-form ideas broken into paragraphs with matching images
- Strong control over typography, rhythm, and visual style
- A style grounded in the author's Get notes, recordings, and real scenes

If the user wants searchable/copyable article text, use `hybrid` or `desktop-readable`, not image-only `mobile-story`.

## Workflow

### Step 0: Ground The Draft In The Author's Notes

When the user asks to use their own writing style, Get notes, recordings, or personal context, ground the article before writing.

Resolve the local GetNote CLI in this order:

1. `$GETNOTE_CLI`
2. `getnote-cli` from `PATH`
3. `$HOME/.local/bin/getnote-cli`
4. `/Users/kevin/.local/bin/getnote-cli` as Kevin's local fallback

```bash
getnote-cli search "<topic> <industry> <scene> 写作风格 口音 观点" -o json
```

Read only the most relevant notes. Extract three things into `outline.md`:

- Scene bank: real field, customer, product, meeting, testing, or delivery details
- Voice bank: the author's stance, rhythm, value judgment, and target reader language
- Proof bank: specific standards, numbers, components, risks, bugs, or constraints

For author-style grounding, always read:

- `references/getnote-cli-setup.md` when GetNote CLI is missing or unauthenticated
- `references/author-style-grounding.md`
- `references/paragraph-image-story-workflow.md`
- `references/built-in-image-generation.md` when the article needs AI-generated paragraph images

Before implementation or publishing, check:

- `references/gotchas.md` for repeated failure modes
- `references/checklist.md` for QA
- `references/built-in-image-generation.md` for image generation, text overlay, and preview readback checks

When changing this skill, check:

- `references/evals.md` for positive/negative trigger cases

Read `references/example-kevin-profile-from-getnote.md` only as an example for how to build a reusable profile from GetNote material, or when the author explicitly wants Kevin's style. For a new author, create the profile in the project `outline.md` first; only promote it to a reusable reference when the user asks to save that author's style.

Before searching notes:

```bash
getnote-cli auth status || getnote auth status
```

If the CLI is missing or not authenticated, guide the user through `references/getnote-cli-setup.md` before generating the article. Do not silently fall back to a generic style unless the user explicitly asks to continue without GetNote grounding.

### Step 1: Choose Output Mode And Shape The Article

Choose the output mode:

- `hybrid` by default: paragraph text + one image after each paragraph
- `mobile-story`: image-only or image-first long story when requested
- `desktop-readable`: text-first layout with fewer, wider images

Group the article into **meaning units**, not every sentence.

Recommended image count:

- 1000 Chinese characters with paragraph-image mode: 5 images, one per 180-220 character paragraph
- 600-1000 Chinese characters: 4-6 images
- 1000-1800 Chinese characters: 6-9 images
- 1800+ Chinese characters: ask whether to split into a series

Card types:

1. Cover: title, hook, strong visual
2. Problem: field pain or contradiction
3. Context: why this matters now
4. Mechanism: workflow, architecture, or cause-effect
5. Evidence: data, comparison, checklist, example
6. Boundary: what not to overclaim
7. Decision: framework, questions, next step
8. Closing: final line or takeaway

Keep each image focused:

- Big title: 6-14 Chinese characters if possible
- Body/callout text inside image: 12-40 Chinese characters
- No dense paragraphs
- No small table text
- Prefer one idea per image
- The image must answer "what should a busy reader remember from this paragraph?"

Paragraph-image mode:

- Use when the user asks for `1000字以内`, `每200字一个段落`, or `每段一个带文字AI生图`.
- Write 5 meaningful paragraphs, each about 180-220 Chinese characters, total under 1000 Chinese characters unless the user says otherwise.
- Before the detailed paragraphs, include a `没时间看全文版` block with 5 short items. Each item must match one paragraph image and be readable without opening the full article.
- Each detailed paragraph section must have a visible colored heading, not plain body text. Use Alibaba orange as the primary accent and add restrained secondary accents so the article does not feel monotonous.
- In `hybrid` mode, put the paragraph as normal WeChat text, then insert exactly one tightly related image. The image is not a divider, not a generic decoration, and not a repeated background.
- Each image must contain baked-in text: one short title of 6-12 Chinese characters plus at most one subtitle or callout of 12-20 Chinese characters.
- The 5 image titles/callouts must form a readable mini-article by themselves.
- The five visual beats should usually be: field hook, hardware/mechanism, workflow/action, boundary/risk, decision/closing.
- If using `mobile-story` and the result feels like a stack of separate slide pages, switch to seamless story mode and connect the five beats with one continuous visual thread.

### Step 2: Create Project Folder

Use this structure:

```text
writing-workspace/getnote-wechat-story/<slug>/
├── index.html
├── article.md
├── images/
├── output/
└── outline.md
```

Copy the template:

```bash
mkdir -p "writing-workspace/getnote-wechat-story/<slug>/images" "writing-workspace/getnote-wechat-story/<slug>/output"
cp "/Users/kevin/.agents/skills/getnote-wechat-story/assets/template.html" "writing-workspace/getnote-wechat-story/<slug>/index.html"
```

### Step 3: Fill The HTML Deck

Open `assets/template.html` and edit only inside `<main id="deck">`.

Use existing classes from the template. Do not invent many new classes unless the template is also updated.

Common layouts are in `references/layouts.md`:

- `cover`
- `split`
- `big-number`
- `process`
- `quote`
- `checklist`
- `image-focus`
- `closing`

Style rules:

- Use Alibaba orange `#ff6a00` as the default accent unless the user asks otherwise.
- Avoid one-note orange pages: use off-white, charcoal, steel gray, and orange accents.
- Do not use emoji as icons.
- Do not put tiny text into generated images.
- Treat images as argument carriers, following the baoyu Type x Style approach: choose `scene`, `flowchart`, `comparison`, `framework`, `timeline`, or `infographic` based on what the paragraph needs to explain.
- For technical/industrial posts, default to `editorial + blueprint` rather than cute, decorative, or generic stock-style visuals.
- If the user asks for built-in image generation, generate the paragraph images with the built-in image tool and write exact prompts first. Do not replace requested AI-generated images with unrelated web images.
- Do not substitute code-drawn placeholder cards for AI images. If exact Chinese text is required, generate a meaningful raster scene with the built-in image model first, then apply deterministic local text overlay for typography fidelity.
- The cover must be 21:9 and separate from body cards.
- Do not place large cover text in the lower-left/bottom safe zone. WeChat cover previews can overlay the article title there, causing duplicate or overlapping titles.
- Prefer a clean visual cover with only a small top-right label/subtitle, or leave all title text to WeChat's title field.

### Step 4: Export PNG Cards

Render all `.wechat-slide` cards:

```bash
/Users/kevin/.agents/skills/getnote-wechat-story/scripts/render_cards.sh \
  "writing-workspace/getnote-wechat-story/<slug>/index.html"
```

The script writes:

```text
output/00-cover-21x9.png
output/01-card.png
output/02-card.png
...
output/body-long.png
```

If Chrome is unavailable, stop and tell the user. Do not hand-wave export.

For seamless story mode, render the continuous canvas directly:

```bash
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
"$CHROME" --headless=new --disable-gpu --hide-scrollbars \
  --force-device-scale-factor=1 \
  --window-size=1080,<height> \
  --screenshot="output/body-story-long.png" \
  "file://$PWD/story.html"
```

### Step 5: Visual QA

Before publishing, read `references/checklist.md` and verify:

- In `hybrid` mode, paragraph images are wide enough for desktop and readable on phone; prefer `1200 x 900` or `1600 x 1200`
- In `mobile-story` mode, all body cards are `1080 x 1440`
- Cover is `2100 x 900`
- Text is readable on mobile
- No text touches edges
- Footers and bottom labels are fully visible; inspect the bottom 80px of every body card.
- No repeated irrelevant visuals
- No card is mostly empty unless intentionally used as a pause
- In `hybrid` mode, the WeChat body text carries the article; images amplify and clarify it.
- In `hybrid` mode, scan only the images before publishing. If the main argument is unclear without reading paragraphs, rewrite the image titles/callouts.
- In `mobile-story` mode, the image body can stand alone without extra WeChat text.

Use image viewing or browser screenshots when available.

### Step 6: Send To WeChat Draft

Use `baoyu-post-to-wechat` or `wechat-publisher` only after PNG export is correct.

Recommended WeChat body:

- Title field = article title
- Digest field = one-line summary
- Cover = `output/00-cover-21x9.png`
- Body = article paragraphs plus matching paragraph images by default (`hybrid`)
- Body = `output/body-long.png` only for `mobile-story`
- For paragraph-image story mode, Body = `output/body-story-long.png` when generated, because it keeps visual continuity and avoids per-image watermark repetition.

Only use image-only body cards when the user explicitly wants separate images, visual-first phone reading, or the account watermark/display tradeoff is acceptable.

If automating the WeChat backend:

For `hybrid`:

1. Insert the article paragraphs as normal WeChat body text.
2. Insert each paragraph image immediately after its matching paragraph.
3. Upload `00-cover-21x9.png` only as a temporary body image so it appears in "从正文选择".
4. Open the cover picker, select the 21:9 temporary image, click `下一步`, then click the crop dialog's `确认`.
5. After the cover preview appears, remove the temporary 21:9 image from the body.
6. Click the visible `保存为草稿` button, not a hidden `继续保存` node or a generic DOM match. Treat the click itself as a required step.
7. After the click, reattach to the active WeChat editor/list page if navigation or session invalidation occurs, then verify: visible title editor, hidden title field, side-card title, empty/default author, text paragraphs, paragraph images, cover preview, and no 21:9 temporary image remains in the body.
8. Fetch the temporary preview URL for the saved draft and verify the server-rendered preview, not only the editor DOM or save-history timestamp.

For `mobile-story`:

1. Upload `body-long.png` or `body-story-long.png` as the article body.
2. Upload `00-cover-21x9.png` only as a temporary body image so it appears in "从正文选择".
3. Open the cover picker, select the 21:9 temporary image, click `下一步`, then click the crop dialog's `确认`.
4. After the cover preview appears, remove the temporary 21:9 image from the body.
5. Click the visible `保存为草稿` button, then reattach if the page/session changes.
6. Fetch the temporary preview URL and verify: body image count is `1`, cover preview is visible, and no 21:9 temporary image remains in the body.

Do not click publish/mass-send without explicit confirmation.

Publishing guardrails borrowed from `baoyu-post-to-wechat`:

- Prefer draft save over publish unless the user explicitly says to publish.
- Verify visible title editor, hidden title field, side-card title, digest, cover preview, body image count, and temporary cover cleanup before reporting success.
- A save-history timestamp alone is insufficient. Final success requires server-side temporary preview readback after the save click.
- Use the visible `保存为草稿` control and click it as a real user action. If the browser target/session becomes stale after save, reattach before verifying.
- When WeChat cover selection opens a crop dialog, click the dialog confirmation button; selecting the image is not enough.
- If the draft was deleted or appmsg id changed, create a new draft instead of trying to patch the old one.

## Practical Defaults

General defaults:

- Output mode: `hybrid`
- Paragraph image size: `1200x900` or `1600x1200`
- Mobile-story card size: `1080x1440`
- Reading model: image layer = key takeaways, text layer = full explanation
- Background: warm paper or very light gray
- Accent: Alibaba orange
- Typography: heavy sans title, readable sans body, mono for code/model names
- Visual language: should follow the author's domain, not a generic tech template
- Writing rhythm: each card should feel like one thought, not a poster stuffed with copy

For Kevin-style tech/industrial example posts, additionally use grounded field scenes, industrial editorial visuals, schematic overlays, and short, direct, risk-aware paragraph rhythm.

## Learned Source

This skill was inspired by `op7418/guizang-ppt-skill`:

- single-file HTML as source of truth
- reusable template + layouts + checklist
- strict visual QA before delivery

It also incorporates selected patterns from Kevin's local baoyu skills:

- `baoyu-article-illustrator`: Type x Style illustration planning, core-argument extraction, and avoiding decorative images
- `baoyu-cover-image`: cover text density, mood, aspect-ratio discipline, and visual-safe composition
- `baoyu-post-to-wechat`: draft save workflow, cover handling, metadata checks, and publishing guardrails

This skill changes the target format to dual-device WeChat story articles, adds a hard 21:9 cover rule, and adds GetNote-based author grounding. The Kevin industrial AI profile is included only as an example of how author grounding should look.

## Maintenance

- Treat every repeated failure as a gotcha and add it to `references/gotchas.md`.
- If the skill triggers when it should not, tighten the frontmatter description and add a negative eval.
- If the skill fails to trigger when it should, add real user wording to the description and add a positive eval.
- Keep heavy explanations out of `SKILL.md`; move them to one-hop files in `references/`.
