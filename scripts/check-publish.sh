#!/usr/bin/env bash
# designstudio 发布闸门 —— 推送前必须跑，不过就不要推。
# 用法： bash scripts/check-publish.sh
#
# 这些全是「不报错、只是错了」的失效：漏了不会有任何提示，只是页面坏了或泄密了。
# 写在文档里是建议，写进脚本才是约束。
set -u
cd "$(dirname "$0")/.."

RED=$'\033[0;31m'; GRN=$'\033[0;32m'; CYN=$'\033[1;36m'; OFF=$'\033[0m'
FAIL=0
ok(){ printf "  ${GRN}✓${OFF} %s\n" "$1"; }
no(){ printf "  ${RED}✗${OFF} %s\n" "$1"; FAIL=1; }
sec(){ printf "\n${CYN}== %s${OFF}\n" "$1"; }

PAGES=$(find . -name 'index.html' -not -path './.git/*' | sort)
[ -z "$PAGES" ] && { no "一个 index.html 都没有"; exit 1; }

sec "每个页面的形态"
for f in $PAGES; do
  n=${f#./}
  grep -qi '<meta charset="utf-8">' "$f" \
    && ok "$n charset" || no "$n 缺 <meta charset=\"utf-8\">（漏了整页中文变乱码，且构建期零报错）"
  grep -q 'Tony Xin' "$f" \
    && ok "$n byline" || no "$n footer is missing the byline: Tony Xin"
  grep -qE '<time datetime="[0-9]{4}-[0-9]{2}-[0-9]{2}"' "$f" \
    && ok "$n 发布日期" || no "$n 缺 <time datetime=\"YYYY-MM-DD\"> 发布日期"
done

sec "自包含"
for f in $PAGES; do
  n=${f#./}
  # data: 与页面内锚点不算外部请求
  if grep -oE '(src|href)="https?://[^"]+"' "$f" | grep -qv '^href="https://github.com/tonyxinvip/designstudio"'; then
    grep -oE '(src|href)="https?://[^"]+"' "$f" | grep -v 'github.com/tonyxinvip/designstudio' | head -3
    no "$n 有外部请求（断网就坏；字体/CDN/图床一律内联）"
  else
    ok "$n 无外部请求"
  fi
done

sec "密钥与对内材料"
if grep -rInE '(sk-[A-Za-z0-9]{16,}|api[_-]?key["'"'"' :=]+[A-Za-z0-9]{16,}|password["'"'"' :=]+[^"'"'"' ]{6,})' \
     --exclude-dir=.git --exclude=check-publish.sh . >/dev/null 2>&1; then
  no "疑似密钥（静态托管藏不住 key，需要密钥的功能一律不上）"
else ok "无密钥形状命中"; fi

# 排除本脚本自身：它的检查项里就写着这四个字（第一次跑就撞上了）
if grep -rIl '【对内】' --exclude-dir=.git --exclude=check-publish.sh . >/dev/null 2>&1; then
  no "存在标记【对内】的文件"
else ok "无【对内】标记"; fi

# 内部路径引用：公开版里会变成死引用
if grep -rInE '(workspace/|cocorobo-agents|IMPROVEMENTS\.md|shared/knowledge)' \
     --exclude-dir=.git --exclude=check-publish.sh --include='*.html' --include='*.md' . >/dev/null 2>&1; then
  no "引用了内部仓库路径（公开版里是死引用，改写成直接说明）"
else ok "无内部路径引用"; fi

sec "体积与索引"
BIG=$(find . -type f -not -path './.git/*' -size +25M | head -3)
[ -z "$BIG" ] && ok "无超过 25MB 的文件" || { echo "$BIG"; no "有文件超过 25MB（GitHub 单文件上限 100MB，超 25MB 先跟 Tony 说）"; }

for f in $PAGES; do
  d=$(dirname "${f#./}")
  [ "$d" = "." ] && continue
  grep -q "href=\"$d/\"" index.html \
    && ok "$d 已挂在索引页上" || no "$d 做了但首页没链接，等于没发布"
done

printf "\n"
if [ $FAIL -eq 0 ]; then printf "${GRN}✓ 闸门通过${OFF}\n"; else printf "${RED}✗ 闸门未过——上面标 ✗ 的就是要修的${OFF}\n"; fi
exit $FAIL
