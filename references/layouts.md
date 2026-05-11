# GetNote WeChat Story Layouts

Use these layouts inside `<main id="deck">` in `assets/template.html`.

## Cover

```html
<section class="wechat-cover" style="--cover-image:url('images/00-cover.jpg')">
  <div>
    <div class="kicker">AI TOOL RADAR</div>
    <h1 class="cover-title">断网以后，终端还能回答吗？</h1>
    <p class="cover-body">RK3588 + RKLLM 的端侧推理落地笔记。</p>
  </div>
</section>
```

## Split

```html
<section class="wechat-slide">
  <div>
    <div class="kicker">02 / Context</div>
    <h2 class="title">标题放这里</h2>
    <div class="accent-bar"></div>
    <p class="body">正文控制在 40 到 120 个中文字符。一个卡片只讲一个意思。</p>
  </div>
  <div class="image-frame"><img src="images/02-scene.jpg" alt=""></div>
  <div class="foot"><span>栏目</span><span>02</span></div>
</section>
```

## Big Number

```html
<section class="wechat-slide dark">
  <div>
    <div class="kicker">03 / Signal</div>
    <div class="stat">6 TOPS</div>
    <p class="body">数字要大，解释要短。不要把表格塞进图片页。</p>
  </div>
  <div class="foot"><span>Data Card</span><span>03</span></div>
</section>
```

## Process

```html
<section class="wechat-slide">
  <div>
    <div class="kicker">04 / Workflow</div>
    <h2 class="title">三步跑通</h2>
  </div>
  <div class="steps">
    <div class="step">
      <div class="step-nb">1</div>
      <div><div class="step-title">转换</div><div class="step-desc">在主机侧完成模型转换。</div></div>
    </div>
    <div class="step">
      <div class="step-nb">2</div>
      <div><div class="step-title">部署</div><div class="step-desc">把模型放进边缘终端。</div></div>
    </div>
    <div class="step">
      <div class="step-nb">3</div>
      <div><div class="step-title">调用</div><div class="step-desc">让业务应用连本地接口。</div></div>
    </div>
  </div>
  <div class="foot"><span>Workflow</span><span>04</span></div>
</section>
```

## Quote

```html
<section class="wechat-slide dark">
  <div class="quote">断网以后，终端还能继续工作。</div>
  <p class="body">这句话不酷，但在很多现场，它就是产品价值本身。</p>
  <div class="foot"><span>Takeaway</span><span>08</span></div>
</section>
```

## Checklist

```html
<section class="wechat-slide">
  <div>
    <div class="kicker">06 / Decision</div>
    <h2 class="title">先问三个问题</h2>
  </div>
  <div class="steps">
    <div class="step"><div class="step-nb">✓</div><div><div class="step-title">真的会断网吗？</div></div></div>
    <div class="step"><div class="step-nb">✓</div><div><div class="step-title">任务偏标准流程吗？</div></div></div>
    <div class="step"><div class="step-nb">✓</div><div><div class="step-title">终端已在 RK3588 路线上吗？</div></div></div>
  </div>
  <div class="foot"><span>POC Decision</span><span>06</span></div>
</section>
```
