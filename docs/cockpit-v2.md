# Cockpit v2 e o cvb-tools

## O que é o Cockpit v2

O **cloudvBOX Cockpit v2** é a nova interface de operação da plataforma: cabeçalho com abas, painel de
Comandos, chat (com sessões, plano + `/confirm` para toda escrita), terminal integrado ao chat, Arquivos,
Projetos e telas de Admin. A especificação (handoff de 2026-10-12) está no repositório
[`cloudvBOX/cvb-cockpit-design`](https://github.com/cloudvBOX/cvb-cockpit-design):

- [`README.md`](https://github.com/cloudvBOX/cvb-cockpit-design/blob/main/README.md) — handoff v2; §6 traz os tokens;
- [`CLAUDE.md`](https://github.com/cloudvBOX/cvb-cockpit-design/blob/main/CLAUDE.md) — regras de implementação e decisões abertas;
- [`docs/cockpit-v2/`](https://github.com/cloudvBOX/cvb-cockpit-design/tree/main/docs/cockpit-v2) — requisitos de backend/Admin, integração terminal ↔ chat, revisão de boas práticas, estratégia multissetor;
- [`docs/00-requisitos/business-rules-v2.md`](https://github.com/cloudvBOX/cvb-cockpit-design/blob/main/docs/00-requisitos/business-rules-v2.md) — regras de negócio e conflitos em aberto.

## Relação deste repositório com o Cockpit v2

O `cvb-tools` é uma coleção de utilitários de linha de comando para administradores Linux (`mkold`, `cvbl`)
empacotada em `.deb`/`.rpm`. **Não há relação funcional com o Cockpit além da identidade visual:**

- não tem tela do Cockpit nem serviço chamado pelo chat, pelos Comandos ou por MCP. Se um dia uma ferramenta
  daqui for exposta ao Cockpit, ela entra pelo MCP com a regra da v2: leitura = `allow`, escrita = `confirm`;
- a única UI versionada é o [`index.html`](../index.html), página pública do repositório APT/YUM publicada no
  `gh-pages` pelo workflow de release. Ela segue a paleta v2 (tema escuro), declarada em variáveis no `:root`
  do próprio arquivo.

## Paleta v2 (decisão do dono, 2026-10-12)

A paleta grafite da v2 com **accent-ink teal** substitui, como cor de interação/primária em todo o design
system da plataforma (`@cvb/console-design` 0.2.0, em andamento), o ciano da marca `#55FCFF` e o teal da v1
`#006D6F`. Valores de referência (README §6 do handoff):

| Token | Escuro | Claro |
|---|---|---|
| bg | `#121212` | `#F3F3F3` |
| surface / -2 / -3 / -4 | `#1B1B1B` / `#171717` / `#252525` / `#2F2F2F` | `#FFFFFF` / `#FAFAFA` / `#EEEEEE` / `#E3E3E3` |
| line | `#262626` | `#E2E2E2` |
| text / -2 / -3 | `#EDEDED` / `#B6B6B6` / `#9B9B9B` | `#1C1C1C` / `#464646` / `#5E5E5E` |
| accent (hover) | `#3A3A3A` (`#464646`) | `#2E2E2E` |
| **accent-ink** | **`#3FD1B9`** | **`#0E6E66`** |
| accent-soft | `#1E2A28` | `#E1EFED` |
| danger / success / warn | `#FF8A80` / `#5ED39A` / `#EBC24F` | `#B42318` / `#11734A` / `#8A6400` |

O accent-ink é para interação e ênfase (links, foco, ação), nunca para texto corrido; estado nunca só por cor.
O `index.html` usa `bg`, `surface`, `surface-3`, `text`, `accent-ink` (links) e `shadow-2` do tema escuro.

## Gate

`scripts/check-cockpit-v2.sh` (POSIX sh + `grep`, sem dependência) roda em `make check`, no workflow
[`cockpit-v2.yml`](../.github/workflows/cockpit-v2.yml) (push e pull request) e antes do build no workflow de
release (e, como `make check` existe, também no `dh_auto_test` do build `.deb`; fora de um checkout git o script varre a árvore com `find`). Ele falha quando um arquivo de UI versionado (`css`, `scss`, `sass`, `less`, `html`, `svelte`, `vue`,
`ts`/`tsx`/`js`/`jsx`/`mjs`/`cjs` e `*theme*.json`/`*token*.json`) contém:

- `#55FCFF` ou `#006D6F` (sem diferenciar maiúsculas), ou
- as formas `rgb()`/`rgba()` dessas cores (`85,252,255` e `0,109,111`).

Se o repositório ganhar um arquivo de tema/tokens, passe-o em `TOKEN_FILES` (ex.: `TOKEN_FILES=src/theme.css`)
e o gate passa a falhar também com qualquer literal de cor (hex, `rgb`, `hsl`) em UI fora dele. Hoje o
repositório **não tem arquivo de tema** (as variáveis ficam no próprio `index.html`), então essa segunda regra
está desligada. Se a única UI deixar de existir, o script continua rodando e passa.

## Ainda em aberto (não decidido aqui)

- **Fonte:** a v2 usa a pilha do sistema; o contrato do DS é IBM Plex auto-hospedada. Por ora fica IBM Plex no DS
  (o `index.html` mantém a pilha do sistema que já usava).
- **Revisão de boas práticas** (`docs/cockpit-v2/best-practices-review.md`): itens aguardando Sim / Não / Depois.
- **Estratégia multissetor**: manifest-first ou screens-first, setores-piloto, nome "Action console", conectores.
- **Conflitos C-1..C-11** de `business-rules-v2.md`: abertos, decididos só pelo dono.
- Lacunas de contraste conhecidas da paleta (warn claro sobre surface-4; line-strong escuro) — corrigir no tema do DS.
