# Stato
Fase corrente: 5 — concluso aggiornamento 2026-10-02 (out/elaborato.pdf, 116 pp., 0 errori, 0 overfull, 0 rif. indefiniti)
Piano confermato: sì
Strumenti: latexmk ok (solo con PATH ripulito, vedi note) · pdftotext ok (xpdf 4.06) · pdfinfo ok · rsvg-convert assente · pdflatex ok (MiKTeX 25.12)
Motore: pdflatex · shell-escape: no
Classe: report · Sezionamento: capitolo=\chapter, esercizio=\section, parti=\subsection

## Fasi
- [x] 0 — Preparazione
- [x] 1 — Analisi (inventario + riferimenti)
- [x] 2 — Piano (checkpoint: conferma utente)
- [x] 3 — Redazione, capitolo per capitolo
- [x] 4 — Compilazione finale e verifica
- [x] 5 — Report all'utente

## Note di configurazione
- RIF_STILE = riferimenti/elaborato_tony.pdf (150 pp.) · RIF_ALTRO = riferimenti/Elaborato_ASDI_M63001784.pdf (91 pp.) — scelta dell'utente; prompt.md aggiornato.
- **latexmk**: MiKTeX fallisce perché il PATH contiene la voce-file `.../miniconda3/Scripts/conda.exe`. Lanciare sempre così:
  `P=$(echo "$PATH" | tr ':' '\n' | grep -v 'conda.exe$' | paste -sd:); PATH="$P" latexmk ...`
- **work/riferimenti/** non è creabile: la regola deny `Write(./riferimenti/**)` in .claude/settings.json colpisce anche quel percorso. Gli estratti dei PDF vanno in **work/estratti-pdf/**.
- Template: marcatore `%% === CONTENUTO ELABORATO ===` aggiunto su richiesta dell'utente al posto dei vecchi `\input` commentati (copia in work/scartati/main-tex-vecchi-input-capitoli.txt). `\input{elaborato-macro}` aggiunto in fondo al preambolo. Compilazione di prova del template vuoto: ok.
- Il template (structure.tex) offre già: stile listings `vhdl` e `xdc`, `\vhdlfile[opts]{<slug>/<file>.vhd}{didascalia}{lst:...}` (radice `codice/`), `\xdcfile`, `\sig{}`, `\ent{}`, ambienti `traccia`, `scelta`/`scelta*`, `osservazione`, `attenzione`, `risultato`, `porte` + `\porta{nome}{dir}{bit}{descr}`, intestazioni fisse `\progetto` `\implementazione` `\simulazione` `\sintesiboard` `\timinganalysis` (subsubsection*), `\todo{}` in rosso (visibile in bozza). `\screenshot` punta a figure/screenshot/: non usarlo, usare `\includegraphics{figure/<slug>/...}`.

| slug | cap | tipo | redatto | umanizzato | compilato | note |
|---|---|---|---|---|---|---|
| esercizio1-1 | 01 | derivato | ✔ | ✔ | ✔ | rigenerato v2: tb da vivado/sim, schema TikZ; v1 in work/scartati/v1-parziali |
| esercizio1-2 | 01 | derivato | ✔ | ✔ | ✔ | rigenerato v2: demux e tb da vivado/sim, schema TikZ; copie ricopiate con cp (identiche) |
| esercizio1-3 | 01 | derivato | ✔ | ✔ | ✔ | board; nuovo 2026-10-02 |
| esercizio2-1 | 02 | derivato | ✔ | ✔ | ✔ | schema TikZ aggiunto; discrepanze dichiarate |
| esercizio2-2 | 02 | derivato | ✔ | ✔ | ✔ | board; TODO foto/verifica su board; nuovo 2026-10-02 |
| esercizio3-1 | 03 | derivato | ✔ | ✔ | ✔ | RISCRITTO 2026-10-02 (FSM 7 stati); v1 in work/scartati/v1-esercizio3-1 |
| esercizio3-2 | 03 | derivato | ✔ | ✔ | ✔ | board; prima comparsa debouncer; TODO tb e foto; nuovo 2026-10-02 |
| esercizio4-1 | 04 | derivato | ✔ | ✔ | ✔ | discrepanze dichiarate (en con mux di hold, shift con zeri, unica entità 2 arch) |
| esercizio5-1 | 05 | derivato | ✔ | ✔ | ✔ | discrepanze dichiarate (prescaler counter_mod, reset sincrono, run) |
| esercizio5-2 | 05 | derivato | ✔ | ✔ | ✔ | board; 2 foto; nuovo 2026-10-02 |
| esercizio6-1 | 06 | derivato | ✔ | ✔ | ✔ | discrepanze dichiarate; schema TikZ PO/PC aggiunto |
| esercizio6-2 | 06 | derivato | ✔ | ✔ | ✔ | board; estratti modifiche 6.1; TODO tb e foto; nuovo 2026-10-02 |
| esercizio6-3 | 06 | placeholder | ✔ | — | ✔ | |
| esercizio7-1 | 07 | derivato | ✔ | ✔ | ✔ | discrepanze dichiarate (registri in un process, 1 caso di test); copia booth_cu.vhd riconvertita latin1→UTF-8 |
| esercizio7-2 | 07 | derivato | ✔ | ✔ | ✔ | board; % TODO esiti board; nuovo 2026-10-02 |
| esercizio8-1 | 08 | derivato | ✔ | ✔ | ✔ | discrepanze dichiarate in riquadro osservazione; rom.vhd non istanziato; copia cu_a.vhd riconvertita latin1→UTF-8 |
| esercizio9-1 | 09 | autonomo | ✔ | ✔ | ✔ | MIC-1 proprio (vivado/mic1); ALU non istanziata, c_bus non pilotato; nuovo 2026-10-02 |
| esercizio10-1 | 10 | derivato | ✔ | ✔ | ✔ | 3 schemi TikZ (sistema, FSM A, FSM B); nuovo 2026-10-02 |
| esercizio11-1 | 11 | placeholder | ✔ | — | ✔ | |
| esercizio12-1 | 12 | placeholder | ✔ | — | ✔ | |

## Note di lavorazione
- Sorgenti in latin1 (ISO-8859): mux_2_1, booth_cu, cu_A, ffT. Le copie in latex/codice/ si ottengono con `iconv -f latin1 -t utf-8` (gli accenti sono gestiti dal literate di structure.tex). Fatto per mux_2_1 (4-1) e booth_cu (7-1); cu_A (8-1) fatto.
- Verifica finale: 65 pagine; 20/20 etichette sec: nel .aux; 0 riferimenti indefiniti/duplicati; 3 overfull > 10pt (8-1 30pt, 5-1 13.7pt e 10.9pt); font warning T1/zi4/m/it (inconsolata corsivo sostituito).
- Aperti: FIXME schema a blocchi in 1-1 e 2-1; TODO schema a blocchi in 1-2 e 6-1; TODO demux_1_4 e testbench in 1-1/1-2 (vivado/sim assente).
- Revisione (2026-09-30): vivado/sim aggiunta dall'utente → 1.1 e 1.2 rigenerati come derivati; schemi TikZ per 1.1, 1.2, 2.1, 6.1 (come nel modello), sovrapposizioni corrette e verificate a vista; 6.1 in scalebox 0.93; overfull corretti in 5.1 e 8.1 (elenchi puntati). Esito: 68 pp., 0 errori, 0 overfull, 0 rif. indefiniti, 0 TODO/FIXME.
- Incidente: latex/out/ (build del template vuoto preesistente, 13:26) sovrascritta da una compilazione di un redattore con -outdir=out lanciata da latex/. Solo prodotti di compilazione rigenerabili.
- Aggiornamento 2026-10-02: aggiunti 1.3, 2.2, 3.2, 5.2, 6.2, 7.2, 9.1 (autonomo, vivado/mic1), 10.1; 3.1 riscritto. Esercitazioni escluse (RCA, add_sub, full_adder, contatore_modulo16_seriale, lab01_mux, lab02). Regola §10 di stile.md (nessuna citazione dei riferimenti) applicata ai soli file nuovi. Snapshot pre-aggiornamento in work/snapshot-2026-10-02/; PDF precedente in work/scartati/elaborato-2026-10-02-prima-aggiornamento.pdf. Copia rs232refcomp.vhd ricopiata dall'originale (era stata doppiamente convertita). Schema 10.1 corretto a vista. Esito: 116 pp., 0 errori, 0 overfull, 0 rif. indefiniti; solo % TODO invisibili (foto/testbench mancanti in 2.2, 3.2, 6.2, 7.2, 9.1).
