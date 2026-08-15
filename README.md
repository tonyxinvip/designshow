# designshow

辛海洋的视觉作品。生成艺术、动态图形、交互页面。

**站点** https://tonyxinvip.github.io/designshow/

| 作品 | 发布 | 说明 |
|---|---|---|
| [万华镜生成器](kaleidoscope/) | 2026-08-15 | D<sub>N</sub> 镜像对称 + Droste 递归 + 粒子泼溅，可交互调参，导出 4K PNG |

## 约定

- 每件作品一个目录，网址即 `/designshow/<目录名>/`
- 页面自包含：CSS/JS/媒体全内联，断网能打开，不发任何外部请求
- 页脚只放两样：`作者：辛海洋` 与发布日期
- 推送前必须跑闸门，**不过就不要推**：

```bash
bash scripts/check-publish.sh
```
