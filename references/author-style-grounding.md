# Author Style Grounding

Use this reference when the article should sound like the current author, not like a generic assistant.

## Goal

Build a temporary author profile from the user's Get notes, recordings, drafts, or knowledge base before writing the article.

The profile should make the article reflect:

- What the author has actually seen
- What the author repeatedly cares about
- How the author explains things
- What the author's readers expect from them

## GetNote Search Pattern

Search by topic plus style signals:

```bash
getnote-cli search "<topic> <domain> 写作风格 口音 观点 场景 录音" -o json
getnote-cli search "<topic> 客户 问题 方案 风险 复盘" -o json
```

If `getnote-cli` is not in `PATH`, try `$HOME/.local/bin/getnote-cli`.

Read 3-6 relevant notes at most. Prefer notes with:

- Recorder summaries
- "我的发言回顾"
- Real customer or project details
- Repeated opinions or value judgments
- Drafts that already sound like the author

## Profile Schema

Create this section in the project `outline.md`:

```md
## Author Profile

Name: <author name or current user>
Domain: <what they actually work on>
Reader: <who they are writing for>

Scene Bank:
- <real scene/detail>
- <real scene/detail>
- <real scene/detail>

Voice Bank:
- Sentence rhythm:
- Default stance:
- Favorite evidence:
- Emotional temperature:
- Words/phrases to reuse carefully:

Proof Bank:
- <numbers, standards, tools, products, failures, cases>

Avoid:
- <generic expressions>
- <topics or tones that do not fit this author>
```

## Style Transfer Rules

- Transfer stance, rhythm, scenes, and evidence. Do not imitate private speech quirks too literally.
- Use the author's real domain details before using internet-generic examples.
- Keep one paragraph to one judgment.
- Preserve the author's boundary sense: what they would not overclaim matters as much as what they would claim.
- If notes conflict, prefer the newest notes or the notes closest to the article topic.

## When To Save A Reusable Profile

Do not automatically create a permanent reference for every user.

Save a reusable profile only when:

- The user asks to save this style
- The author will be used repeatedly
- At least 3 notes support the profile

Suggested path:

```text
references/<author-slug>-profile-from-getnote.md
```

Do not overwrite another author's profile.
