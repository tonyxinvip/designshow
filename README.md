# Tony's Trials

辛海洋做的东西。能在浏览器里跑的那种。

**站点** https://tonyxinvip.github.io/designshow/

| 作品 | 发布 | 说明 |
|---|---|---|
| [万华镜生成器](kaleidoscope/) | 2026-08-15 | 镜像对称 + 递归卷心 + 粒子泼溅。参数全露在外面，导出 4K PNG |

## 约定

- 每件作品一个目录，网址即 `/designshow/<目录名>/`
- 页面自包含：CSS/JS/媒体全内联，断网能打开，不发任何外部请求
- 页脚只放两样：`作者：辛海洋` 与发布日期
- 推送前必须跑闸门，**不过就不要推**：

```bash
bash scripts/check-publish.sh
```
