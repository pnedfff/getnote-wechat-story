# GetNote WeChat Story

把个人 Get 笔记、录音、草稿和项目复盘，转成适合微信公众号发布的双端兼容图文故事。

![GetNote WeChat Story infographic](assets/getnote-wechat-story-infographic.png)

## What It Does

GetNote WeChat Story 是一个面向公众号创作者的 AI skill。它先读取作者自己的 Get 笔记，提取真实场景、表达口音和事实证据，再生成一篇适合微信发布的图文文章。

默认采用 `hybrid` 模式：

- 图片层：忙人速读版，只扫图也能抓住主线
- 文字层：完整解释版，有时间再看细节
- 双端兼容：手机端有视觉节奏，电脑端也保留可读正文

## Core Workflow

1. 读取 Get 笔记：搜索录音、草稿、项目复盘、知识库
2. 生成作者画像：提取 `Scene Bank`、`Voice Bank`、`Proof Bank`
3. 写成双层文章：图片层给结论，文字层讲证据和细节
4. 每段一张关键图：每张图承载一个明确判断
5. 保存公众号草稿：21:9 封面、图文正文、发布前 QA

## Output Modes

| Mode | Best For | Body Format |
| --- | --- | --- |
| `hybrid` | 默认，手机和电脑都要好读 | 正文段落 + 段落配图 |
| `mobile-story` | 手机沉浸阅读、长图文章 | 一张或多张竖版长图 |
| `desktop-readable` | 客户转发、归档、搜索 | 文字优先 + 宽幅配图 |

## Install

Clone this skill into your local skills directory:

```bash
git clone https://github.com/pnedfff/getnote-wechat-story.git \
  ~/.agents/skills/getnote-wechat-story
```

## GetNote CLI Setup

This skill works best with the GetNote CLI.

```bash
command -v getnote-cli || command -v getnote
getnote-cli auth status || getnote auth status
```

If the CLI is not installed, install it from:

```text
https://github.com/iswalle/getnote-cli
```

Then authenticate:

```bash
getnote auth login
```

or with an API key:

```bash
getnote auth login --api-key <gk_live_xxx>
```

## Author Grounding

The skill does not hard-code one writing style. It builds a temporary author profile from the current user's notes:

```md
Scene Bank: real scenes, customers, projects, tests
Voice Bank: stance, rhythm, value judgment, reader language
Proof Bank: numbers, standards, tools, risks, cases
```

`references/example-kevin-profile-from-getnote.md` is only an example profile. It should not be applied to other authors unless explicitly requested.

## Design Principles

- Images are not decoration. Each image must carry a conclusion.
- The image-only skim should work: cover + image titles/callouts must explain the article's main argument.
- Text remains searchable and copyable in `hybrid` mode.
- The cover is always `21:9`.
- Publishing defaults to saving a draft, not mass-sending.

## Repository

Public repository:

```text
https://github.com/pnedfff/getnote-wechat-story
```
