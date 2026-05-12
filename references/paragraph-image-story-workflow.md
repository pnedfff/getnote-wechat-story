# Paragraph Image Story Workflow

Use this workflow for dual-device WeChat posts where each paragraph has a tightly matched AI image.

## Target Shape

- Article body: under 1000 Chinese characters.
- Text rhythm: 5 paragraphs, about 180-220 Chinese characters each.
- Visual rhythm: 5 images, each mapped to one paragraph.
- First-screen skim: a `没时间看全文版` block with 5 short text items, mapped one-to-one to the 5 paragraph images.
- Section rhythm: each detailed paragraph starts with a colored heading. Use Alibaba orange as the anchor color and 2-4 restrained secondary accents across the five headings.
- Default article layout: normal text paragraph, then its matching image.
- Each image includes readable Chinese text baked into the image.
- Reading model: image layer = key takeaways for busy readers; text layer = detailed explanation for readers with time.
- Cover remains separate at 21:9 and should avoid lower-left title collision in WeChat.

## Draft Structure

Create this table in `outline.md` before rendering:

| Beat | Paragraph Role | Quick Point | Paragraph Draft | Image Text | Image Prompt |
| --- | --- | --- | --- | --- | --- |
| 1 | Field hook | One-sentence skim item | A real user/site question | Short title + callout | Scene with device and field constraint |
| 2 | Mechanism | One-sentence skim item | The hardware or system reason | Short title + callout | Product/mechanism close-up |
| 3 | Action | One-sentence skim item | How the workflow runs | Short title + callout | Step-by-step operation scene |
| 4 | Boundary | One-sentence skim item | What not to overclaim | Short title + callout | Risk, testing, or comparison scene |
| 5 | Decision | One-sentence skim item | Who should do a POC and why | Short title + callout | Decision/checklist/closing scene |

## 没时间看全文版

Before the full body, write a short skim block:

```md
## 没时间看全文版

1. **断网也要识别**：无人机先在机上看懂现场。
2. **32FPS 是门槛**：优化链路比模型名更重要。
3. **现场先筛一遍**：少传无效视频，多传目标线索。
4. **不要神化模型**：夜间烟雾还要多传感器验证。
5. **从拍摄到闭环**：能触发行动才算应急工具。
```

Rules:

- Exactly one item per paragraph image.
- Each item has a bold 6-12 Chinese character conclusion and a 12-28 Chinese character explanation.
- The 5 items must be understandable before reading the paragraphs.
- The items must not introduce claims that are absent from the detailed body.
- In `hybrid` mode, this block is normal WeChat text, not an image, so it remains searchable and copyable.

## Dual-Audience Content Review

Before finalizing the article text, run four separate review passes:

- `过于偏技术` review: keep enough concrete terms, metrics, hardware names, and constraints that an industry reader does not feel talked down to, but explain what the key term changes in practice instead of stacking jargon.
- `现场感` review: every article should contain real field conditions such as weak network, weather, terrain, operator delay, command pressure, or what the drone sees first. Avoid floating above the site as pure architecture talk.
- `活人感` review: include at least one human point of view such as operator, commander, rescuer, inspector, or customer-side decision. The article should sound like someone who has seen the workflow, not a detached encyclopedia entry.
- `AI味` review: remove vague abstract phrasing like generic trend talk, solution talk, and future talk when a more concrete action, tradeoff, or consequence is available.

When balancing insider and ordinary-reader needs:

- Keep the specialist nouns that carry real meaning, but translate them into one sentence of practical consequence.
- After each technical claim, ask "so what changes on site?"
- A non-specialist should be able to answer "what is this for?" after the first two paragraphs.
- A specialist should be able to answer "is this technically grounded?" without feeling that the article hand-waved the core mechanism.

## Colored Section Headings

For the five detailed sections, do not leave headings as plain black paragraphs. Use a compact editorial style:

- Add a colored left rule or colored number marker.
- Keep Alibaba orange `#ff6a00` as the dominant brand accent.
- Use secondary accents such as teal, blue, amber, or steel gray to avoid a flat single-color rhythm.
- Keep heading text short enough to scan on mobile.
- Verify by screenshot or DOM readback after saving the WeChat draft.

## Image Prompt Rules

Each prompt should specify:

- Format: hybrid default `1200x900` or `1600x1200`, WeChat editorial image, text-safe layout.
- Use vertical `1080x1440` only for mobile-story/image-only mode.
- Palette: Alibaba orange `#ff6a00` accent, off-white background, charcoal text, steel gray industrial details.
- Subject: the exact paragraph scene, device, customer, or workflow.
- Text: one title of 6-12 Chinese characters and one subtitle/callout of 12-20 Chinese characters.
- Style: grounded industrial editorial, realistic rugged terminal, schematic overlays, clear hierarchy.
- Text policy: if exact Chinese text matters, ask the image model for a text-free scene and apply the exact title/callout locally after generation.
- Validation policy: reject placeholder cards and any generated image that does not visually support its paragraph.

## Skimmable Image Layer

Before generating images, write a 5-line "image-only read". It should match the `没时间看全文版` block but can be shorter for visual titles:

```md
## Image-Only Read
1. <image title + key callout>
2. <image title + key callout>
3. <image title + key callout>
4. <image title + key callout>
5. <image title + key callout>
```

This 5-line sequence must communicate the article's main argument without the paragraphs. If it reads like disconnected labels, rewrite it before generating images.

Image text rules:

- Title = conclusion, not topic label. Prefer "断网也要回答" over "本地AI".
- Callout = the reason, boundary, or action behind the conclusion.
- Avoid vague titles such as "行业趋势", "解决方案", "未来已来".
- Use numbers, constraints, and decisions when available.
- Keep the image layer honest: do not overclaim beyond the paragraph.

Avoid:

- Reusing the same field scene five times.
- Abstract glowing brains, generic robots, random server rooms, or unrelated city skylines.
- Small dense text inside the image.
- Text near the bottom edge, because WeChat display and stitching can crop visually.

## Story Continuity

If using mobile-story mode and the images feel like unrelated slide pages:

- Render as a continuous `story.html` long image instead of separate cards.
- Use one visual connector across all beats, such as orange signal line, rescue route, circuit trace, or command timeline.
- Remove repeated watermarks, page numbers, and repeated footer labels.
- Keep only one optional account mark at the final bottom area.

## QA

Before saving a WeChat draft:

- Check each paragraph has exactly one matching visual.
- Check every visual says something the paragraph actually says.
- Read only the image titles/callouts. The main argument should still be clear.
- In hybrid mode, preview both phone-width and desktop-width reading flow.
- In mobile-story mode, inspect top, middle, and bottom crops of the long image.
- Confirm no text is cut off after stitching or upload.
- Confirm the WeChat draft body image count is `1` only when using image-only mobile-story with account watermark enabled.
