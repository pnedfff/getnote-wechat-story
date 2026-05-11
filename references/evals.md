# Evals

Use these when changing the skill description or workflow.

## Positive Trigger Cases

The skill should load when the user says:

- "根据我的 Get 笔记写一篇公众号文章，每段配图。"
- "把这段录音整理成公众号图文故事。"
- "做一篇双端兼容公众号，忙人扫图也能看懂。"
- "用我的写作风格重写成微信文章。"
- "读取她的 Get 笔记，生成她自己的文章风格。"
- "做 1000 字以内，5 段，每段一张关键图。"
- "更新公众号草稿，封面 21:9，正文图文混排。"

Expected behavior:

- Resolve and verify GetNote CLI when author grounding is requested.
- Build an author profile before writing.
- Default to `hybrid` unless the user explicitly asks for image-only long image.
- Make the image layer skimmable by itself.
- Save draft only unless the user explicitly asks to publish.

## Negative Trigger Cases

The skill should not load when the user says:

- "帮我查一下 GetNote CLI 怎么安装。" Use GetNote/auth/search skills or answer directly.
- "把这张图片压缩一下。" Use image compression/editing tools.
- "生成普通横版 PPT。" Use a slide/presentation skill.
- "写一篇纯文字博客，不需要公众号和配图。"
- "发一封邮件给客户。"
- "给 GitHub 仓库写 README。" Use general coding/docs workflow unless the README is for this skill.

Expected behavior:

- Do not force WeChat format onto non-WeChat tasks.
- Do not read GetNote unless the user wants author grounding or notes-based writing.
- Do not turn desktop-readable articles into image-only long posters by default.

## Quality Evals

For a generated article, check:

- The first 5 image titles/callouts form a coherent mini-article.
- Every image corresponds to exactly one paragraph's core conclusion.
- The text layer adds evidence and nuance beyond the image layer.
- The cover avoids lower-left title collision.
- The body works on both mobile and desktop.
- No claim says GetNote was read unless note search actually succeeded.

