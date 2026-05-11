# Paragraph Image Story Workflow

Use this workflow for dual-device WeChat posts where each paragraph has a tightly matched AI image.

## Target Shape

- Article body: under 1000 Chinese characters.
- Text rhythm: 5 paragraphs, about 180-220 Chinese characters each.
- Visual rhythm: 5 images, each mapped to one paragraph.
- Default article layout: normal text paragraph, then its matching image.
- Each image includes readable Chinese text baked into the image.
- Cover remains separate at 21:9 and should avoid lower-left title collision in WeChat.

## Draft Structure

Create this table in `outline.md` before rendering:

| Beat | Paragraph Role | Paragraph Draft | Image Text | Image Prompt |
| --- | --- | --- | --- | --- |
| 1 | Field hook | A real user/site question | Short title + callout | Scene with device and field constraint |
| 2 | Mechanism | The hardware or system reason | Short title + callout | Product/mechanism close-up |
| 3 | Action | How the workflow runs | Short title + callout | Step-by-step operation scene |
| 4 | Boundary | What not to overclaim | Short title + callout | Risk, testing, or comparison scene |
| 5 | Decision | Who should do a POC and why | Short title + callout | Decision/checklist/closing scene |

## Image Prompt Rules

Each prompt should specify:

- Format: hybrid default `1200x900` or `1600x1200`, WeChat editorial image, text-safe layout.
- Use vertical `1080x1440` only for mobile-story/image-only mode.
- Palette: Alibaba orange `#ff6a00` accent, off-white background, charcoal text, steel gray industrial details.
- Subject: the exact paragraph scene, device, customer, or workflow.
- Text: one title of 6-12 Chinese characters and one subtitle/callout of 12-20 Chinese characters.
- Style: grounded industrial editorial, realistic rugged terminal, schematic overlays, clear hierarchy.

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
- In hybrid mode, preview both phone-width and desktop-width reading flow.
- In mobile-story mode, inspect top, middle, and bottom crops of the long image.
- Confirm no text is cut off after stitching or upload.
- Confirm the WeChat draft body image count is `1` only when using image-only mobile-story with account watermark enabled.
