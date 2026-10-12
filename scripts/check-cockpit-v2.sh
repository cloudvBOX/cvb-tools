#!/bin/sh
# Gate Cockpit v2 / DS v2 (cvb-tools).
# Falha quando um arquivo de UI versionado usa as cores de interação da v1:
#   - ciano da marca  #55FCFF  (rgb 85,252,255)
#   - teal da v1      #006D6F  (rgb 0,109,111)
# Se TOKEN_FILES (lista separada por espaço) apontar para arquivo(s) de tema/tokens,
# também falha com literal de cor (hex, rgb/rgba, hsl/hsla) em UI fora deles.
# Este repositório não tem arquivo de tema: TOKEN_FILES vem vazio e essa regra fica desligada.
# Só POSIX sh + git + grep. Detalhes: docs/cockpit-v2.md
set -u

TOKEN_FILES="${TOKEN_FILES:-}"

cd "$(dirname "$0")/.." || exit 2

UI_RE='\.(css|scss|sass|less|html|htm|svelte|vue|tsx|jsx|ts|js|mjs|cjs)$'
THEME_JSON_RE='(theme|token)[^/]*\.json$'

# Arquivos versionados; fora de um checkout git (ex.: build do .deb a partir do tarball, onde o
# dh_auto_test chama `make check`), cai para find na árvore, sem debian/ e .git/.
list_ui() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    git ls-files
  else
    find . -type f ! -path './.git/*' ! -path './debian/*' | sed 's|^\./||'
  fi | grep -iE "$UI_RE|$THEME_JSON_RE"
}

V1_RE='#55fcff|#006d6f|rgba?\([[:space:]]*85[[:space:]]*,[[:space:]]*252[[:space:]]*,[[:space:]]*255|rgba?\([[:space:]]*0[[:space:]]*,[[:space:]]*109[[:space:]]*,[[:space:]]*111'
LIT_RE='#[0-9a-f]{3}([0-9a-f]{1,5})?\b|rgba?\(|hsla?\('

fail=0
n=0
tmp="${TMPDIR:-/tmp}/cockpit-v2-ui.$$"
list_ui > "$tmp" || :
trap 'rm -f "$tmp"' EXIT INT TERM

while IFS= read -r f; do
  [ -f "$f" ] || continue
  n=$((n + 1))
  if grep -inE "$V1_RE" "$f" > /dev/null 2>&1; then
    echo "ERRO: cor da v1 (#55FCFF/#006D6F) em $f — use o accent-ink da v2 (#3FD1B9 escuro / #0E6E66 claro):"
    grep -inE "$V1_RE" "$f" | sed 's/^/  /'
    fail=1
  fi
  if [ -n "$TOKEN_FILES" ]; then
    is_token=0
    for t in $TOKEN_FILES; do [ "$f" = "$t" ] && is_token=1; done
    if [ "$is_token" -eq 0 ] && grep -inE "$LIT_RE" "$f" > /dev/null 2>&1; then
      echo "ERRO: literal de cor fora do arquivo de tema ($TOKEN_FILES) em $f:"
      grep -inE "$LIT_RE" "$f" | sed 's/^/  /'
      fail=1
    fi
  fi
done < "$tmp"

if [ "$fail" -ne 0 ]; then
  echo "check-cockpit-v2: FALHOU"
  exit 1
fi
echo "check-cockpit-v2: ok ($n arquivo(s) de UI verificados)"
