# Piano
Classe: report · Motore: pdflatex · Sezionamento: capitolo=\chapter, esercizio=\section, parti=\subsection

Organizzazione: come RIF_STILE (elaborato_tony.pdf), un capitolo per traccia e un esercizio (\esSezione) per sottopunto, così la numerazione delle sezioni coincide con quella della traccia (1.1, 1.2, ... 12.1). Le "Parti" del modello non si riproducono: il template non ha un livello \part tra le macro.
Associazione: `vivado/esercizioX_Y` ↔ traccia X.Y (numero + entità/funzione concordano per tutti i 7 implementati → derivati). Slug dei placeholder senza cartella: `esercizioX-Y`, per coerenza.
Autonomi: nessuno.

**Componenti comuni** (vivado/src, aggiunta dall'utente dopo il checkpoint). Ogni componente condiviso si presenta per intero alla sua prima comparsa; negli esercizi successivi si richiama con un riferimento (`\ref`) al listato originale, etichetta `lst:<slug-prima-comparsa>:<nome-file con _ sostituito da ->`. Prima comparsa: mux_4_1 e mux_16_1 in esercizio1-1; interconn16_4 in esercizio1-2; rom16_8 in esercizio2-1; dff e mux_2_1 in esercizio4-1; counter_mod in esercizio5-1; mem, rom e onecount in esercizio6-1; full_adder, rca e add_sub in esercizio7-1. La cartella vivado/sim (demux_1_4 e testbench di 1.1 e 1.2) resta assente.

## 01-multiplexer — Multiplexer 16:1 e rete di interconnessione
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio1-1 | Multiplexer 16:1 | derivato | STILE p. 5-8 · ALTRO p. 6-8 | vivado/esercizio1_1 + src | testbench mancante (vivado/sim assente); wave_1_1.png presente |
| 2 | esercizio1-2 | Rete di interconnessione 16:4 | derivato | STILE p. 9-12 · ALTRO p. 9-10 | vivado/esercizio1_2 + src | demux_1_4 e testbench mancanti (vivado/sim assente); wave_1_2.png presente |
| 3 | esercizio1-3 | Rete di interconnessione su board | placeholder | STILE p. 13-14 · ALTRO p. 11-13 | — | |

## 02-rom-m — Sistema ROM + M
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio2-1 | Sistema ROM + M | derivato | STILE p. 15-18 · ALTRO p. 14-15 | vivado/esercizio2_1 | usa src/rom16_8 |
| 2 | esercizio2-2 | Sistema ROM + M su board | placeholder | STILE p. 19-20 · ALTRO p. 16 | — | |

## 03-riconoscitore-sequenza — Riconoscitore di sequenza
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio3-1 | Riconoscitore della sequenza 101 | derivato | STILE p. 22-26 · ALTRO p. 17-19 | vivado/esercizio3_1 | autosufficiente |
| 2 | esercizio3-2 | Riconoscitore su board | placeholder | STILE p. 27-31 · ALTRO p. 19-21 | — | |

## 04-shift-register — Shift register
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio4-1 | Shift register comportamentale e strutturale | derivato | STILE p. 32-37 · ALTRO p. 22-24 | vivado/esercizio4_1 | usa src/dff, mux_2_1, mux_4_1 |

## 05-cronometro — Cronometro
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio5-1 | Cronometro | derivato | STILE p. 38-44 · ALTRO p. 24-26 | vivado/esercizio5_1 | usa src/counter_mod |
| 2 | esercizio5-2 | Cronometro su board | placeholder | STILE p. 45-53 · ALTRO p. 26-31 | — | |

## 06-po-pc — Sistema di lettura, elaborazione e scrittura (PO/PC)
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio6-1 | Sistema PO/PC | derivato | STILE p. 54-63 · ALTRO p. 32-34 | vivado/esercizio6_1 | usa src/counter_mod, mem, onecount, rom |
| 2 | esercizio6-2 | Sistema PO/PC su board | placeholder | STILE p. 64-66 · ALTRO p. 35-37 | — | |
| 3 | esercizio6-3 | Timing analysis | placeholder | STILE p. 67-68 | — | |

## 07-moltiplicatore-booth — Moltiplicatore di Booth
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio7-1 | Moltiplicatore di Booth | derivato | STILE p. 70-80 · ALTRO p. 38-42 | vivado/esercizio7_1 | usa src/full_adder, rca, add_sub, counter_mod |
| 2 | esercizio7-2 | Moltiplicatore di Booth su board | placeholder | STILE p. 81-90 · ALTRO p. 42-46 | — | |

## 08-handshaking — Comunicazione con handshaking
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio8-1 | Comunicazione con handshaking | derivato | STILE p. 92-105 · ALTRO p. 46-53 | vivado/esercizio8_1 | usa src/counter_mod, rom, mem |

## 09-processore — Processore MIC-1
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio9-1 | Processore MIC-1 | placeholder | STILE p. 107-110 · ALTRO p. 53-57 | — | |

## 10-interfaccia-seriale — Interfaccia seriale UART
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio10-1 | Comunicazione seriale UART-RS232 | placeholder | STILE p. 112-117 · ALTRO p. 58-63 | — | |

## 11-switch-multistadio — Switch multistadio
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio11-1 | Switch multistadio omega network | placeholder | STILE p. 119-127 · ALTRO p. 64-70 | — | |

## 12-prova-esame — Prova d'esame di dicembre 2024
| # | slug | titolo | tipo | riferimento | cartella vivado | note |
|---|---|---|---|---|---|---|
| 1 | esercizio12-1 | Prova d'esame di dicembre | placeholder | STILE p. 129-142 · ALTRO p. 71-79 | — | |

## Non pianificato
- Appendice dei componenti comuni (STILE-APP): non pianificata; i componenti si presentano dentro gli esercizi (vedi sopra). In src ci sono anche automa, common_defs, cont_16_s, ffT, mic1_datapath: non citati da alcun progetto, non inclusi.
- Placeholder confermati dall'utente: le prove su board (1.3, 2.2, 3.2, 5.2, 6.2, 7.2), la timing analysis 6.3 e le tracce 9-12.
