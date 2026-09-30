# Compito: elaborato LaTeX degli esercizi Vivado

Sei l'**orchestratore**. Non scrivi tu gli esercizi: pianifichi, deleghi ai subagenti in `.claude/agents/`, controlli i risultati, tieni aggiornato `work/stato.md` e alla fine consegni `out/elaborato.pdf`. Rispetta gli invarianti e le convenzioni di `CLAUDE.md`.

## Configurazione

| Chiave | Valore | Note |
|---|---|---|
| `VIVADO_DIR` | `./vivado` | cartella con un progetto/esercizio per sottocartella |
| `RIF_STILE` | `./riferimenti/elaborato_tony.pdf` | documento modello: stile di scrittura, struttura degli esercizi, posizione delle immagini |
| `RIF_ALTRO` | `./riferimenti/Elaborato_ASDI_M63001784.pdf` | secondo documento: altre tracce e soluzioni |
| `TEMPLATE_MAIN` | `./latex/main.tex` | deve contenere il marcatore `%% === CONTENUTO ELABORATO ===` dopo `\begin{document}` |
| `AUTONOMI` | `affine` | `affine` = nel capitolo più vicino per argomento, dopo i derivati · `dedicato` = capitolo finale "Esercizi aggiuntivi" |
| `CHECKPOINT_PIANO` | `sì` | `sì` = fermati dopo il piano e aspetta conferma · `no` = procedi |
| `MOTORE` | `auto` | `auto` = deduci dal preambolo · `pdflatex` · `xelatex` · `lualatex` |
| `PARALLELO_MAX` | `4` | numero massimo di redattori lanciati nello stesso messaggio |

L'intero elaborato segue lo stile di `RIF_STILE`. Il documento da cui un esercizio deriva fornisce il contenuto tecnico (traccia, approccio atteso), non lo stile.

---

## Fase 0 — Preparazione (tu)

1. Verifica che i percorsi della configurazione esistano. Se manca qualcosa, fermati e chiedi.
2. Verifica gli strumenti: `latexmk -v`, `pdftotext -v`, `pdfinfo -v`. Annota in `work/stato.md` quali mancano (i subagenti hanno un piano B).
3. Crea le cartelle `work/ work/riferimenti/ work/pre-umanizzazione/ work/scartati/ latex/capitoli/ latex/figure/ latex/codice/ out/`.
4. Leggi **solo il preambolo** di `TEMPLATE_MAIN` (fino a `\begin{document}`) e gli eventuali file che include con `\input`/`\usepackage` locali. Ricava:
   - classe: `book`/`report` → capitolo = `\chapter`, esercizio = `\section`, parti = `\subsection`; `article` → `\section` / `\subsection` / `\subsubsection`;
   - motore (se `MOTORE=auto`): `fontspec` o `unicode-math` → `xelatex`, altrimenti `pdflatex`;
   - pacchetti già presenti: `graphicx`, `listings`, `minted`, `xcolor`, `float`, `hyperref`, `caption`, `subcaption`.
   Verifica che il marcatore esista una sola volta dopo `\begin{document}`; se no, fermati e chiedi.
5. Crea `latex/elaborato-macro.tex` dal modello in fondo a questo file, adattandolo: nessun pacchetto già caricato dal template, livelli di sezionamento coerenti con la classe. Se il template usa `minted`, non caricare `listings` e definisci lo stile VHDL con `minted` (la compilazione richiede allora `-shell-escape`: annotalo in stato).
6. Aggiungi `\input{elaborato-macro}` come ultima riga del preambolo.
7. Inizializza `work/stato.md` con il formato in fondo a questo file.

## Fase 1 — Analisi (due subagenti in parallelo)

Lancia **nello stesso messaggio**:
- `inventario-vivado` con: `VIVADO_DIR`, file di uscita `work/inventario.md`.
- `analista-riferimenti` con: `RIF_STILE`, `RIF_ALTRO`, uscite `work/catalogo-riferimenti.md` e `work/stile.md`.

Al ritorno controlla che i tre file esistano e non siano vuoti (`wc -l`). Leggi i riepiloghi, non i file interi.

## Fase 2 — Piano (tu)

Leggi `work/inventario.md` e `work/catalogo-riferimenti.md` (sono compatti) e scrivi `work/piano.md`.

**Associazione esercizio implementato ↔ riferimento.** Un esercizio è *derivato* se corrisponde a una traccia del catalogo per almeno due indizi tra: numero o nome dell'esercizio, nome dell'entità, porte e parametri, funzione realizzata, componenti richiesti. Con un solo indizio debole è *dubbio*: segnalalo nel piano, poi decide il redattore leggendo il codice. Nessuna corrispondenza → *autonomo*.

**Esercizi da includere.** L'unione di: tutte le tracce del catalogo (implementate o no) + gli esercizi autonomi.
- Traccia senza cartella corrispondente, o con cartella in stato `vuoto` → *placeholder*.
- Cartella in stato `parziale` → si documenta ciò che esiste, con `% TODO:` per le parti mancanti.

**Capitoli.** Segui l'organizzazione in capitoli/sezioni dei riferimenti (prima `RIF_STILE`, poi `RIF_ALTRO` per ciò che il primo non copre); gli autonomi secondo `AUTONOMI`. Numera le cartelle `01-`, `02-`, … nell'ordine finale.

Formato di `work/piano.md`:

```markdown
# Piano
Classe: report · Motore: pdflatex · Sezionamento: capitolo=\chapter, esercizio=\section, parti=\subsection

## 01-<slug-capitolo> — <Titolo capitolo>
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | es-1-mux | Multiplexer 4:1 | derivato | STILE p. 12-15 | vivado/Es1_mux | |
| 2 | es-2-demux | Demultiplexer 1:4 | placeholder | ALTRO p. 20-21 | — | |
| 3 | enc-prio | Encoder con priorità | autonomo | — | vivado/enc_prio | affine al cap. 01 |
| 4 | es-4-cmp | Comparatore | dubbio | ALTRO p. 23 | vivado/cmp | solo il nome coincide |
```

Se `CHECKPOINT_PIANO=sì`: mostra all'utente una tabella riassuntiva (capitoli, conteggi per tipo, casi dubbi, autonomi e loro collocazione) e **aspetta la conferma**; dopo la conferma scrivi `Piano confermato: sì` in stato. Da qui in poi lavora senza fermarti, salvo blocchi reali.

## Fase 3 — Redazione, capitolo per capitolo

Per ogni capitolo, nell'ordine del piano:

**3.1 Redazione.** Per ogni esercizio `derivato`, `autonomo`, `parziale` o `dubbio` lancia un `redattore-esercizio`, al massimo `PARALLELO_MAX` per messaggio. Il subagente parte senza memoria: il briefing deve contenere tutto.

```
slug: <slug>
titolo: <titolo>
capitolo: <NN-slug-capitolo>
tipo: <derivato|autonomo|parziale|dubbio>
riferimento: <STILE|ALTRO> <percorso pdf> pagine <N-M>      (oppure: nessuno)
cartella vivado: <percorso>
blocco inventario: sezione "## <slug>" di work/inventario.md
file da scrivere: latex/capitoli/<NN-cap>/<slug>.tex
stile: work/stile.md
```

**3.2 Placeholder.** Nessun subagente: scrivi tu, per ogni placeholder, un file `<slug>.tex` con la sola riga `\esercizioDaSvolgere{<Titolo>}{<slug>}`. Così la struttura resta uguale a quella degli altri esercizi e completarlo più avanti richiede solo `/esercizio <slug>`.

**3.3 File di capitolo.** Scrivi `latex/capitoli/<NN-cap>/capitolo.tex`:

```latex
\esCapitolo{<Titolo capitolo>}\label{cap:<slug-capitolo>}
% introduzione di 2-4 frasi solo se stile.md prevede introduzioni di capitolo
\input{capitoli/<NN-cap>/<slug-1>}
\input{capitoli/<NN-cap>/<slug-2>}
```

e aggiungi `\input{capitoli/<NN-cap>/capitolo}` nel template, subito sopra il marcatore (il marcatore resta; gli `\input` si accumulano in ordine sopra di esso).

**3.4 Umanizzazione.** Quando tutti i file del capitolo sono pronti, lancia `umanizzatore-capitolo` con la cartella del capitolo. Per risparmiare tempo puoi lanciarlo nello stesso messaggio dei redattori del capitolo successivo.

**3.5 Compilazione di controllo.** Dopo l'umanizzazione lancia `compilatore-latex` in modalità `capitolo`. Un errore non risolto non blocca i capitoli successivi, ma va in stato e nel report finale.

**3.6 Stato.** Aggiorna `work/stato.md`. Integra nel piano le correzioni segnalate dai redattori (tipo deciso o contestato, riferimento sbagliato).

## Fase 4 — Compilazione finale e verifica

1. Lancia `compilatore-latex` in modalità `finale`.
2. Verifica tu, con comandi brevi:
   - `out/elaborato.pdf` esiste e `pdfinfo out/elaborato.pdf` riporta un numero di pagine plausibile;
   - ogni slug del piano ha la sua etichetta: `grep -rhoE 'sec:[a-z0-9-]+' latex/capitoli | sort -u`, confrontato con il piano;
   - nessun riferimento indefinito o etichetta duplicata in `out/elaborato.log` (se il compilatore ha ripulito gli ausiliari, basta il suo riepilogo);
   - `grep -rn 'FIXME' latex/capitoli` vuoto, oppure ogni occorrenza compare nel report.

## Fase 5 — Report all'utente

Breve, in chat:
- tabella per capitolo: derivati / autonomi / parziali / placeholder;
- esercizi autonomi e dove sono stati collocati;
- discrepanze tra implementazione e riferimento dichiarate nel testo;
- immagini escluse e perché;
- problemi aperti (`FIXME`, `TODO`, warning rilevanti, strumenti mancanti).

## Gestione degli imprevisti

- Subagente fallito o file di uscita mancante: rilancialo **una** volta con un briefing più preciso (aggiungi la causa del fallimento). Se fallisce di nuovo, segna `bloccato` in stato e prosegui.
- Contesto della sessione che si allunga: prima di compattare assicurati che `work/stato.md` e `work/piano.md` siano aggiornati; per riprendere basta `/riprendi`.
- Non cancellare mai file: sposta in `work/scartati/`.

---

## Formato di `work/stato.md`

```markdown
# Stato
Fase corrente: 3 — capitolo 02
Piano confermato: sì
Strumenti: latexmk ok · pdftotext ok · pdfinfo ok · rsvg-convert assente
Motore: pdflatex · shell-escape: no

| slug | cap | tipo | redatto | umanizzato | compilato | note |
|---|---|---|---|---|---|---|
| es-1-mux | 01 | derivato | ✔ | ✔ | ✔ | |
| es-2-demux | 01 | placeholder | ✔ | — | ✔ | |
| enc-prio | 01 | autonomo | ✔ | | | |
```

## Modello di `latex/elaborato-macro.tex`

```latex
% elaborato-macro.tex — generato dall'orchestratore, incluso alla fine del preambolo.
\makeatletter
\@ifpackageloaded{graphicx}{}{\usepackage{graphicx}}
\@ifpackageloaded{xcolor}{}{\usepackage{xcolor}}
\@ifpackageloaded{float}{}{\usepackage{float}}
\@ifpackageloaded{listings}{}{\usepackage{listings}}
\makeatother

% --- Sezionamento (article: \section / \subsection / \subsubsection)
\newcommand{\esCapitolo}{\chapter}
\newcommand{\esSezione}{\section}
\newcommand{\esSottosezione}{\subsection}

% --- Codice VHDL
\lstdefinestyle{vhdl}{
  language=VHDL,
  basicstyle=\ttfamily\footnotesize,
  keywordstyle=\bfseries\color{blue!60!black},
  commentstyle=\itshape\color{black!55},
  stringstyle=\color{red!50!black},
  numbers=left, numberstyle=\tiny\color{black!50}, numbersep=6pt,
  frame=single, rulecolor=\color{black!25},
  breaklines=true, columns=fullflexible, tabsize=2,
  showstringspaces=false, captionpos=b,
  literate={à}{{\`a}}1 {è}{{\`e}}1 {é}{{\'e}}1 {ì}{{\`i}}1 {ò}{{\`o}}1 {ù}{{\`u}}1
}

% --- Esercizio non ancora implementato
\newcommand{\esercizioDaSvolgere}[2]{%
  \esSezione{#1}\label{sec:#2}%
  \begin{center}
    \fbox{\parbox{0.85\linewidth}{\centering\itshape
      Esercizio non ancora implementato: sezione da completare.}}
  \end{center}}
```

Se il template ha già uno stile per il codice o colori propri, allinea `vhdl` a quelli invece di imporre questi.
