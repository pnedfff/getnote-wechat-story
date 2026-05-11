# Gotchas

Update this whenever the agent repeats a mistake.

## Routing And Grounding

- Do not apply Kevin's style to another author. `example-kevin-profile-from-getnote.md` is an example, not a default.
- Do not claim author-style grounding if GetNote search or note reading failed.
- If GetNote CLI is missing or unauthenticated, guide setup first or ask whether to continue without note grounding.
- `getnote` and `getnote-cli` may both be valid command names. Resolve the binary before writing commands.

## Article Shape

- Default is `hybrid`, not image-only. Keep readable body text unless the user explicitly asks for a long image.
- Do not forget the first-screen `没时间看全文版` skim block. It is separate from the image-only read and should appear in the WeChat body unless explicitly omitted.
- Busy-reader image layer must stand alone. If the image titles are just section labels, rewrite them as conclusions.
- Each paragraph gets one meaningful image, not one image per sentence or line.
- Do not let paragraph images become decorative stock visuals. They must carry the paragraph's core judgment.

## Visuals

- Cover is always separate from body and uses `2100 x 900`.
- Avoid large cover text in the lower-left/bottom zone; WeChat overlays title text there.
- Alibaba orange is an accent, not a full-page color wash.
- Do not create fake "AI images" with only rectangles, circles, and text. If the user asked for generated images, the base visual must come from the built-in image model or an approved official image provider.
- For Chinese text inside generated visuals, prefer model-generated scene plus deterministic local text overlay. Validate the final rendered PNG, not just the prompt.
- Do not put tiny tables, dense code, or long paragraphs inside generated images.
- For `hybrid`, prefer `1200 x 900` or `1600 x 1200`; for `mobile-story`, use `1080 x 1440`.

## WeChat Drafting

- Leave the author field empty unless the user explicitly asks for an author name.
- Save as draft only. Do not publish or mass-send without explicit confirmation.
- Do not claim a draft is complete until a temporary preview/readback verifies paragraph count, image count, and required text snippets.
- Selecting a cover image is not enough; if WeChat opens a crop dialog, click its confirmation button.
- Remove temporary 21:9 cover images from the body after cover selection.
- If the old draft was deleted or the appmsg id changed, create a new draft instead of patching a stale id.

## Repository Hygiene

- Do not commit GetNote credentials, WeChat tokens, generated article outputs, browser profiles, or temporary drafts.
- README can be user-facing, but skill execution rules should live in `SKILL.md` and `references/`.
