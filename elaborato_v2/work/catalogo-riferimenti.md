# Catalogo esercizi dei documenti di riferimento

Documenti:
- STILE = `riferimenti/elaborato_tony.pdf` (150 pp., testo estratto in `work/estratti-pdf/stile.txt`; versione senza listati `stile_c.txt`). Documento modello per lo stile. Numerazione nel PDF: 13 capitoli in 9 "Parti"; gli esercizi sono numerati per capitolo (es. 5.1, 5.2) e coincidono con il numero della traccia. Il codice è riportato integralmente in listati numerati ("Listing N.M").
- ALTRO = `riferimenti/Elaborato_ASDI_M63001784.pdf` (91 pp., testo in `work/estratti-pdf/altro.txt`, versione compatta `altro_d.txt`). Numerazione: 8 capitoli, esercizi 1-12, sottopunti 1.1, 1.2, ... Il codice è testo numerato "1. 2. 3."; le immagini (forme d'onda, FSM, schemi, report) NON hanno didascalia né numero: nel testo estratto non compaiono; sono inserite dopo il paragrafo di descrizione (simulazione: dopo il testo che dice quali casi si sono provati; FSM: dopo "l'automa è riportato di seguito"). Nessuna pagina illeggibile.

Nota di associazione con le cartelle Vivado: `esercizioX_Y` corrisponde al sottopunto X.Y delle tracce (es. `esercizio5_2` = Cronometro su board, `esercizio7_1` = Booth in simulazione). Gli esercizi 8, 9, 10, 11, 12 hanno un solo punto (`esercizio8_1`, ...). Le tracce sono quelle ufficiali del corso, identiche nei due documenti: per ogni traccia le due fonti differiscono solo nella soluzione.

Pagine indicate: numero di pagina del PDF (per STILE la numerazione stampata coincide con quella del file).

## Tabella riassuntiva

| ID | Titolo | Argomento | Pagine | Soluzione |
|---|---|---|---|---|
| STILE-1.1 | Multiplexer 16:1 | combinatorio, strutturale | 5-8 | sì |
| STILE-1.2 | Rete di interconnessione 16:4 | combinatorio | 9-12 | sì |
| STILE-1.3 | Interconnessione 16:4 su board | combinatorio + registro, board | 13-14 | sì |
| STILE-2.1 | Sistema ROM+M | memorie, combinatorio | 15-18 | sì |
| STILE-2.2 | ROM+M su board | board | 19-20 | sì |
| STILE-3.1 | Riconoscitore di sequenza 101 | FSM | 22-26 | sì |
| STILE-3.2 | Riconoscitore su board | FSM, board, debouncer | 27-31 | sì |
| STILE-4.1 | Shift register (comportamentale + strutturale) | sequenziale, generic | 32-37 | sì |
| STILE-5.1 | Cronometro | sequenziale strutturale, contatori | 38-44 | sì |
| STILE-5.2 | Cronometro su board | board, display 7 segmenti | 45-53 | sì |
| STILE-6.1 | Sistema lettura-elaborazione-scrittura PO/PC | PO/PC, FSM, memorie | 54-63 | sì |
| STILE-6.2 | PO/PC su board | board | 64-66 | sì |
| STILE-6.3 | Timing analysis del PO/PC | timing | 67-68 | sì |
| STILE-7.1 | Moltiplicatore di Booth | aritmetica, PO/PC | 70-80 | sì |
| STILE-7.2 | Booth su board | board, display | 81-90 | sì |
| STILE-8.1 | Comunicazione con handshaking | due nodi, FSM | 92-105 | sì |
| STILE-9.1 | Processore MIC-1 | microprogrammazione | 107-110 | sì |
| STILE-10.1 | UART-RS232 | seriale, FSM | 112-117 | sì |
| STILE-11.1 | Switch multistadio (omega network) | reti di interconnessione | 119-127 | sì |
| STILE-12.1 | Prova di dicembre (ROM, handshaking, CLA) | sistema completo | 129-142 | sì |
| STILE-APP | Appendice: MUX 2:1, FF D, macchina M, divisore, RCA, full adder, contatore, ROM, memoria | componenti | 144-149 | sì |
| ALTRO-1.1 | Multiplexer 16:1 | combinatorio, strutturale | 6-8 | sì |
| ALTRO-1.2 | Rete di interconnessione 16:4 | combinatorio | 9-10 | sì |
| ALTRO-1.3 | Interconnessione 16:4 su board | board | 11-13 | sì |
| ALTRO-2.1 | Sistema ROM+M (one hot) | memorie | 14-15 | sì |
| ALTRO-2.2 | ROM+M su board | board | 16 | sì (solo vincoli) |
| ALTRO-3.1 | Riconoscitore di sequenza | FSM | 17-19 | sì |
| ALTRO-3.2 | Riconoscitore su board | FSM, board | 19-21 | sì |
| ALTRO-4.1 | Shift register | sequenziale, generic | 22-24 | sì |
| ALTRO-5.1 | Cronometro | strutturale, FF T | 24-26 | sì |
| ALTRO-5.2 | Cronometro su board + timing analysis | board, timing | 26-31 | sì |
| ALTRO-6.1 | PO/PC | PO/PC | 32-34 | sì |
| ALTRO-6.2 | PO/PC su board | board | 35-37 | sì |
| ALTRO-7.1 | Moltiplicatore di Booth | aritmetica | 38-42 | sì |
| ALTRO-7.2 | Booth su board + timing analysis | board, timing | 42-46 | sì |
| ALTRO-8.1 | Handshaking (variante a 3 passi con NEXT) | due nodi | 46-53 | sì |
| ALTRO-9.1 | Processore MIC-1 (BIPUSH, IAND, SWAP modificata) | microprogrammazione | 53-57 | sì |
| ALTRO-10 | UART-RS232 con handshake hardware rts/cts | seriale | 58-63 | sì |
| ALTRO-11.1 | Switch multistadio combinatorio (senza CU) | omega network | 64-70 | sì |
| ALTRO-12.1 | Prova di dicembre, con clock diversi | sistema completo | 71-79 | sì |
| ALTRO-APP | Appendice: MUX 2:1, decoder 4:16, divisore, contatore, memoria NxM, FF T, adder-sub, registro, ROM 16x8 | componenti | 80-91 | sì |

---

## STILE-1.1: Multiplexer 16:1
- documento: STILE — riferimenti/elaborato_tony.pdf
- pagine: 5-8
- posizione nel documento: Parte I "Reti combinatorie elementari", cap. 1 "Multiplexer 16:1", sez. 1.1
- argomento: combinatorio, composizione strutturale
- consegna: progettare, scrivere in VHDL e simulare un multiplexer indirizzabile 16:1 componendo multiplexer 4:1.
- interfaccia attesa: `mux4_1` (a: 4 bit `0 to 3`, s: 2 bit, y: 1 bit); `mux16_1` (a: 16 bit, s: 4 bit, y); testbench `mux16_1_tb` senza porte, istanza `uut`
- approccio della soluzione: MUX 4:1 dataflow (`with select`, `'-'` negli altri casi); MUX 16:1 strutturale con 4 MUX al primo livello + 1 al secondo, segnale interno `u` a 4 bit; testbench con ciclo su i = 0..15
- figure nel documento, in ordine: schema a blocchi (Fig 1.1) dopo la frase "Progetto e Architettura"; forme d'onda (Fig 1.2) dopo la spiegazione del testbench
- parole chiave per l'associazione: mux, multiplexer, 16:1, mux4_1, mux16_1, indirizzabile, composizione

## STILE-1.2: Rete di interconnessione 16:4
- documento: STILE
- pagine: 9-12
- posizione nel documento: Parte I, cap. 1, sez. 1.2
- argomento: combinatorio
- consegna: usando il MUX 16:1 progettare e simulare una rete di interconnessione con 16 sorgenti e 4 destinazioni.
- interfaccia attesa: `dmux1_4` (i, s 2 bit, y 4 bit); `interconnection16_4` (i 16 bit, s_i 4 bit, s_y 2 bit, y 4 bit)
- approccio della soluzione: MUX 16:1 seguito da DMUX 1:4 (strutturale); testbench con assert su tutte le destinazioni
- figure nel documento, in ordine: schema a blocchi (Fig 1.3) dopo il paragrafo di progetto; immagine del codice DMUX (Fig 1.4) dentro Implementazione (unico caso in cui il codice compare come immagine); forme d'onda (Fig 1.5) dopo il commento del testbench
- parole chiave per l'associazione: interconnessione, 16:4, dmux, demultiplexer, s_i, s_y, interconnection16_4

## STILE-1.3: Implementazione su board della rete di interconnessione
- documento: STILE
- pagine: 13-14
- posizione nel documento: Parte I, cap. 1, sez. 1.3
- argomento: board (Nexys A7), combinatorio con rete di controllo
- consegna: sintetizzare su board la rete 16:4: switch per le selezioni e LED per i 4 bit di uscita; i 16 bit di dato inseriti 8 alla volta con due bottoni (prima e seconda metà).
- interfaccia attesa: `interconnection16_4_onboard` (CLK100MHZ, BTNL, BTNR, SW_DATA 15..8, SW_SEL 5..0, LED 15..12)
- approccio della soluzione: top module con registro a 16 bit caricato a metà tramite bottoni + rete precedente; file .xdc con righe decommentate
- figure nel documento, in ordine: nessuna
- parole chiave per l'associazione: board, Nexys, BTNL, BTNR, SW_DATA, SW_SEL, load, xdc, rete di controllo

## STILE-2.1: Sistema ROM+M
- documento: STILE
- pagine: 15-18
- posizione nel documento: Parte I, cap. 2 "Sistema ROM + M", sez. 2.1
- argomento: memorie, combinatorio
- consegna: sistema S formato da ROM combinatoria 16x8 e da una macchina combinatoria M (8 bit in, 4 bit out, funzione libera) che trasforma il dato letto all'indirizzo A di 4 bit.
- interfaccia attesa: ROM (address 4 bit, data 8 bit); `M` (input 8 bit, output 4 bit); `S` (input 4 bit, output 4 bit)
- approccio della soluzione: ROM behavioral con array in esadecimale e process sensibile a address; M = AND tra coppie di bit adiacenti; S strutturale; testbench con una M di riferimento per il confronto
- figure nel documento, in ordine: schema a blocchi (ROM → M) dopo la frase introduttiva del progetto; forme d'onda (Fig 2.1) dopo il testbench
- parole chiave per l'associazione: ROM, macchina M, sistema S, address, 16x8, AND adiacenti, 0xBD

## STILE-2.2: ROM+M su board
- documento: STILE
- pagine: 19-20
- posizione nel documento: Parte I, cap. 2, sez. 2.2
- argomento: board
- consegna: implementare su board il sistema ROM+M con switch per l'indirizzo e LED per i 4 bit di uscita.
- interfaccia attesa: `S_onboard` (SW 15..12, LED 15..12)
- approccio della soluzione: solo top module + vincoli
- figure nel documento, in ordine: foto della scheda (Fig 2.2) dopo il commento dell'ingresso 0001 → LED
- parole chiave per l'associazione: S_onboard, SW, LED, indirizzo, ROM+M board

## STILE-3.1: Riconoscitore di sequenza
- documento: STILE
- pagine: 22-26
- posizione nel documento: Parte II "Reti sequenziali elementari", cap. 3, sez. 3.1
- argomento: FSM
- consegna: macchina che riconosce 101; ingressi dato i, tempificazione A, modo M; M=0 gruppi di 3 bit non sovrapposti, M=1 uno alla volta con sovrapposizione parziale; uscita Y.
- interfaccia attesa: `Sequence_Detector` (input, M, reset, clock, A, state_output_led 7 bit, Y)
- approccio della soluzione: FSM con process sul clock; uscita a 7 bit con lo stato su LED
- figure nel documento, in ordine: codice → diagramma degli stati (Fig 3.1, sottografo nero modo 0, rosso modo 1) dopo il listato; codice testbench → due forme d'onda (Fig 3.2 modo 0, Fig 3.3 modo 1)
- parole chiave per l'associazione: riconoscitore, sequenza 101, FSM, Sequence_Detector, modo M, tempificazione A

## STILE-3.2: Riconoscitore su board
- documento: STILE
- pagine: 27-31
- posizione nel documento: Parte II, cap. 3, sez. 3.2
- argomento: FSM, board, debouncer
- consegna: switch S1 per i, S2 per M, bottoni B1/B2 per acquisire in sincronia con A (ricavato dal clock della board), LED per Y.
- interfaccia attesa: `Input_Manager` (clock, input 2 bit, load_next, change_mode → detector_input, detector_M, detector_enable); `Button_Debouncer`; `Sequence_Detector_onboard` (CLK100MHZ, SW 15..14, BTNU, BTNR, BTNL, LED_STATE 7 bit, LED_OUTPUT)
- approccio della soluzione: input manager + button debouncer + detector (strutturale)
- figure nel documento, in ordine: nessuna
- parole chiave per l'associazione: Input_Manager, Button_Debouncer, load_next, change_mode, LED_STATE, BTNU

## STILE-4.1: Shift register
- documento: STILE
- pagine: 32-37
- posizione nel documento: Parte II, cap. 4, sez. 4.1 con sottosezioni 4.1.1 Approccio comportamentale, 4.1.2 Approccio strutturale
- argomento: sequenziale, generic
- consegna: registro a scorrimento di N bit (generic) con shift a destra/sinistra di 1 o 2 posizioni selezionabili; realizzarlo sia comportamentale sia strutturale.
- interfaccia attesa: `shiftregister_behavioral` e `shiftregister_structural`, generic `bit_number` (default 8); porte clock, reset, load, Y, shift_left, input, output
- approccio della soluzione: comportamentale (operatori di shift); strutturale con N flip-flop D, MUX 2:1 (load) e MUX 4:1 sugli adiacenti i-2, i-1, i+1, i+2; testbench che confronta le due versioni a 16 bit (load x"6F5D", shift dx, sx, ...)
- figure nel documento, in ordine: (comportamentale: solo listato) schema dell'architettura (Fig 4.1) all'inizio della parte strutturale; forme d'onda (Fig 4.2) dopo il testbench, seguita da elenco puntato dei passi di test
- parole chiave per l'associazione: shift register, registro a scorrimento, bit_number, shift_left, Y, generic, behavioral, structural

## STILE-5.1: Cronometro
- documento: STILE
- pagine: 38-44
- posizione nel documento: Parte II, cap. 5, sez. 5.1
- argomento: sequenziale strutturale, contatori
- consegna: cronometro (ore, minuti, secondi) da una base dei tempi (clock board), con set del valore iniziale e reset, struttura di contatori a scelta.
- interfaccia attesa: `clock_divider` (generic clock_frequency_in/out; clock, reset → clock_divided); `counter` (generic max_count; clock, enable, reset, load, input, output, Q); cronometro strutturale con set/reset
- approccio della soluzione: divisore di frequenza a 1 Hz + 3 contatori (secondi mod 60, minuti mod 60, ore) collegati in cascata con enable; nei test base tempi ridotta a 1 us
- figure nel documento, in ordine: schema a blocchi (Fig 5.1) in Progetto; due forme d'onda (Fig 5.2 conteggio, Fig 5.3 con valore precaricato 7:59:59 → 8:00:00) dopo il testbench
- parole chiave per l'associazione: cronometro, chronometer, clock_divider, counter, secondi minuti ore, set, reset, base dei tempi

## STILE-5.2: Cronometro su board
- documento: STILE
- pagine: 45-53
- posizione nel documento: Parte II, cap. 5, sez. 5.2
- argomento: board, display a 7 segmenti
- consegna: display a 7 segmenti per l'orario, switch per l'orario iniziale, due bottoni per set e reset, codifica a scelta.
- interfaccia attesa: `input_manager` (clock, 3 bottoni ore/minuti/secondi, switches 6 bit → value 17 bit); `seven_segments_display`; `anodes_manager`; `cathodes_manager`; `cathodes_input_manager`; `chronometer_onboard` (CLK100MHZ, CATHODES, ANODES, BTNU/L/C/R/D, SW 5..0)
- approccio della soluzione: input manager con tre caricamenti (5+6+6 = 17 bit) + display multiplexato composto da manager di anodi/catodi
- figure nel documento, in ordine: foto della scheda (Fig 5.4) in Sintesi su board; nessuna altra
- parole chiave per l'associazione: display 7 segmenti, anodes, cathodes, input_manager, chronometer_onboard, BTNC

## STILE-6.1: Sistema di lettura-elaborazione-scrittura PO/PC
- documento: STILE
- pagine: 54-63
- posizione nel documento: Parte II, cap. 6, sez. 6.1
- argomento: PO/PC, FSM, memorie
- consegna: sistema con ROM di N locazioni da 8 bit, macchina M (8 → 4 bit), memoria MEM di N locazioni; avvio con START, unità di controllo che scandisce le locazioni con un contatore; ROM in lettura sincrona, MEM in scrittura sincrona.
- interfaccia attesa: `ROM_N` (generic N; clock, read, address, output), `MEM_N` (clock, write, address, input), `control_unit` (clock, start, reset, Q_counter → read_rom, write_mem, enable_counter, reset_counter), `counter`, `rom_m_mem` (generic N; clock, start, reset, output 4 bit)
- approccio della soluzione: strutturale; testbench che confronta test_output con il risultato atteso (30 ns per l'elaborazione)
- figure nel documento, in ordine: schema a blocchi (Fig 6.1) dopo elenco numerato dei 5 componenti; forme d'onda (Fig 6.2) dopo il testbench, seguite da commento sul fronte di clock
- parole chiave per l'associazione: PO/PC, parte operativa, parte di controllo, control unit, ROM_N, MEM_N, rom_m_mem, START

## STILE-6.2: PO/PC su board
- documento: STILE
- pagine: 64-66
- posizione nel documento: Parte II, cap. 6, sez. 6.2
- argomento: board
- consegna: due bottoni per read e reset, LED per le uscite della macchina istante per istante.
- interfaccia attesa: `rom_m_mem_onboard` (CLK100MHZ, BTNC, BTNU, LED 15..12)
- approccio della soluzione: top con clock divider + sistema; elenco numerato di 3 valori ROM con uscita M
- figure nel documento, in ordine: due foto della scheda affiancate (sottofigure a, b; Fig 6.3) dopo la frase "Ad esempio"
- parole chiave per l'associazione: rom_m_mem_onboard, BTNC, BTNU, LED, clock divider

## STILE-6.3: Timing analysis
- documento: STILE
- pagine: 67-68
- posizione nel documento: Parte II, cap. 6, sez. 6.3
- argomento: timing analysis (WNS, FMAX)
- consegna: valutare il timing del sistema PO/PC, trovare la migliore frequenza operativa riducendo il WNS.
- interfaccia attesa: non indicata
- approccio della soluzione: tre tentativi con `create_clock` a periodo 10 ns, 5 ns, 4 ns; ogni listato di vincolo è seguito dallo screenshot del riepilogo Design Timing Summary; formula FMAX = 1/(T - WNS)
- figure nel documento, in ordine: screenshot dei report (Fig 6.4, 6.5, 6.6), ciascuno dopo il listato del vincolo corrispondente
- parole chiave per l'associazione: timing analysis, WNS, slack, FMAX, create_clock, periodo

## STILE-7.1: Moltiplicatore di Booth
- documento: STILE
- pagine: 70-80
- posizione nel documento: Parte III "Macchine aritmetiche", cap. 7, sez. 7.1
- argomento: aritmetica sequenziale, PO/PC
- consegna: moltiplicatore di Booth per due stringhe da 8 bit.
- interfaccia attesa: `register_8`, `shiftregister` (16 bit, shift, serial_output), `counter`, `adder_subtractor` (a, b, cin → s, cout), `control_unit` (booth_eval 2 bit, counter_Q...), `booth_multiplier` (clock, reset, start, x, y 8 bit → output 16 bit, done)
- approccio della soluzione: strutturale: registro, shift register AQ, contatore, adder-subtractor (RCA + full adder in appendice), CU a stati; testbench con più casi (es. 15×3 = 45)
- figure nel documento, in ordine: schema architettura (Fig 7.1) dopo l'elenco dei tre casi dell'algoritmo; forme d'onda (Fig 7.2) dopo il testbench
- parole chiave per l'associazione: Booth, moltiplicatore, booth_multiplier, adder_subtractor, done, complemento a due, shift register 16 bit

## STILE-7.2: Booth su board
- documento: STILE
- pagine: 81-90
- posizione nel documento: Parte III, cap. 7, sez. 7.2
- argomento: board, display
- consegna: sintetizzare il moltiplicatore e usarlo con i dispositivi della board (uso a discrezione).
- interfaccia attesa: `button_debouncer` (generic clock_period, noise_time), `seven_segments_display` (input 16 bit), `booth_multiplier_onboard` (CLK100MHZ, X, Y 8 bit, BTNU, BTNC, LED, CATHODES, ANODES)
- approccio della soluzione: debouncer + display con clock divider, contatore, anodes/cathodes manager (elenco numerato); risultato in decimale con segno meno
- figure nel documento, in ordine: foto della scheda (Fig 7.3) in Sintesi su board
- parole chiave per l'associazione: booth_multiplier_onboard, button_debouncer, cathodes_input_manager, display, LUT potenze di 10

## STILE-8.1: Comunicazione con handshaking
- documento: STILE
- pagine: 92-105
- posizione nel documento: Parte IV, cap. 8, sez. 8.1
- argomento: due nodi comunicanti, FSM
- consegna: nodi A e B con memoria interna di N stringhe da M bit (X(i), Y(i)); A trasmette X(i) con handshaking, B calcola S(i) = X(i)+Y(i) e la memorizza; contatori espliciti in A e B; somma anche comportamentale.
- interfaccia attesa: `register_M` (generic M), `adder` (generic M), `control_unit_A` (start, ack → req, counter_*, rom_read), `control_unit_B` (req → ack, mem_read, mem_write, reg_read), `system_A`, `system_B` (generic N, M)
- approccio della soluzione: strutturale; due FSM (stati IDLE, DATA_READ, START_TX, WAIT_ACK, END_TX, CHECK_COUNT per A; WAIT_TX, ACK_TX, WAIT_END_REQ, END_TX per B); testbench con due clock diversi
- figure nel documento, in ordine: schema esterno req/ack/dati; architettura interna (Fig 8.1); FSM A (Fig 8.2); FSM B (Fig 8.3) tutte in Progetto; forme d'onda (Fig 8.4) dopo la descrizione del testbench
- parole chiave per l'associazione: handshaking, req, ack, nodo A, nodo B, control_unit_A, system_A, system_B, X(i), Y(i)

## STILE-9.1: Processore MIC-1
- documento: STILE
- pagine: 107-110
- posizione nel documento: Parte V, cap. 9, sez. 9.1
- argomento: processore microprogrammato IJVM
- consegna: analizzare in simulazione il processore IJVM fornito studiando due istruzioni a scelta; modificare un codice operativo documentando le modifiche.
- interfaccia attesa: non indicata (processore fornito)
- approccio della soluzione: PUNTO A: pop e if_icmpeq (elenco delle microistruzioni); PUNTO B: IADD a 2 operandi → a 3 operandi, modifica di `program.ajvm` e del process `wavegen_proc` nel testbench, valore atteso 0xA+0xE+0x4 = 0x1C
- figure nel documento, in ordine: screenshot del test (Fig 9.1) alla fine
- parole chiave per l'associazione: MIC-1, IJVM, microistruzione, IADD, pop, if_icmpeq, BIPUSH, program.ajvm, MAL

## STILE-10.1: UART-RS232
- documento: STILE
- pagine: 112-117
- posizione nel documento: Parte VI, cap. 10, sez. 10.1
- argomento: interfaccia seriale, FSM
- consegna: partendo da `RS232RefComp.vhd` (Digilent), sistema con unità A (ROM 8x1 byte, CONT_A, UART_A) e unità B (MEM 8x1 byte, CONT_B, UART_B) sullo stesso clock, comunicazione seriale a comando WR.
- interfaccia attesa: `control_unit_A` (start, TBE → WR, rom_read, counter_*), `control_unit_B` (RDA, PE, FE, OE → RD, mem_write, error, counter_*)
- approccio della soluzione: strutturale con due FSM; riquadro NOTA che spiega TBE, RDA, PE, FE, OE; testbench con `uart_line`, RX di A a '1', TX di B open
- figure nel documento, in ordine: schema UART (Fig 10.1), FSM A (Fig 10.2), FSM B (Fig 10.3) in Progetto; forme d'onda (Fig 10.4) dopo il testbench
- parole chiave per l'associazione: UART, RS232, Rs232RefComp, TBE, RDA, WR, RD, uart_line, control_unit_A/B

## STILE-11.1: Switch multistadio
- documento: STILE
- pagine: 119-127
- posizione nel documento: Parte VII, cap. 11, sez. 11.1
- argomento: rete di interconnessione omega network
- consegna: switch multistadio omega network per messaggi di 2 bit tra 4 nodi con priorità fissa (nodo 1 più prioritario).
- interfaccia attesa: `switch_2_2_2bit` (x0, x1 2 bit, s_i, s_o → y0, y1), `priority_manager` (enable 4 bit, dest_0..3 → s_i, s_o, ...), omega network e sistema finale
- approccio della soluzione: strutturale; switch elementare = MUX 2:1 + DMUX 1:2; perfect shuffling; priority manager nella CU; spiegazione teorica (perfect shuffling, instradamento sul bit più significativo)
- figure nel documento, in ordine: perfect shuffling (Fig 11.1) e topologia (Fig 11.2) in Progetto; architettura iniziale (Fig 11.3); componente switch (Fig 11.4) in Implementazione; forme d'onda (Fig 11.5) dopo il testbench
- parole chiave per l'associazione: omega network, switch multistadio, perfect shuffling, priority_manager, switch_2_2, priorità fissa

## STILE-12.1: Prova di dicembre
- documento: STILE
- pagine: 129-142
- posizione nel documento: Parte VIII, cap. 12, sez. 12.1
- argomento: sistema completo (ROM sincrona, handshaking, sommatore CLA)
- consegna: nodo A con ROM 8x4 (lettura sincrona), nodo B con sommatore parallelo a 4 bit e registro R; A invia gli elementi con handshaking, B somma progressivamente e salva in R. Quattro punti: schema a blocchi PO/PC, automi delle CU con tempificazione, sommatore carry look-ahead, VHDL e simulazione con clock diversi di A e B.
- interfaccia attesa: `ROM_8_4`, `control_unit_A`, `register_M`, `carry_look_ahead_adder_4` (x, y 4 bit → s 5 bit), `control_unit_B`, `system_A`, `system_B`
- approccio della soluzione: struttura in "Punto numero 1..4" (parti della traccia)
- figure nel documento, in ordine: architettura (Fig 12.1), automa A (12.2), automa B (12.3), architettura CLA (12.4) subito dopo l'enunciato dei punti 1-3; forme d'onda (12.5) alla fine dopo il testbench
- parole chiave per l'associazione: prova, dicembre, carry look-ahead, ROM_8_4, buffer, registro R, ADDER4, system_A, system_B

## STILE-APP: Appendice (cap. 13)
- documento: STILE
- pagine: 144-149
- posizione nel documento: Parte IX
- argomento: componenti riutilizzati
- consegna: non applicabile (raccolta di listati con una riga di contesto e rimando agli esercizi che li usano)
- interfaccia attesa: mux_2_1, FF D, M, clock divider, ripple_carry_adder_8, full_adder, contatore, ROM, MEM
- approccio della soluzione: solo listato + una frase
- figure nel documento, in ordine: nessuna
- parole chiave per l'associazione: appendice, componenti comuni

---

## ALTRO-1.1: Multiplexer 16:1
- documento: ALTRO — riferimenti/Elaborato_ASDI_M63001784.pdf
- pagine: 6-8
- posizione nel documento: Capitolo 1 "reti combinatorie elementari", Esercizio 1 "Multiplexer 16:1", Esercizio 1.1
- argomento: combinatorio, strutturale
- consegna: come STILE-1.1
- interfaccia attesa: `mux_4_1` (b0..b3, s0, s1, y0), `mux_16_1` (a_16, s_4, y)
- approccio della soluzione: MUX 4:1 da tre MUX 2:1 (appendice); MUX 16:1 con 4+1 istanze; testo di progetto discorsivo, testbench descritto a parole
- figure nel documento, in ordine: (le figure non hanno didascalia) schema e forma d'onda dopo il paragrafo di Simulazione
- parole chiave per l'associazione: mux_4_1, mux_16_1, mux_2_1, LSB/MSB di selezione

## ALTRO-1.2: Rete di interconnessione 16:4
- documento: ALTRO
- pagine: 9-10
- posizione nel documento: Cap. 1, Esercizio 1.2
- argomento: combinatorio
- consegna: come STILE-1.2
- interfaccia attesa: `demux_1_4` (a, s 2 bit, y 4 bit; dataflow con `when ... else`), `interconnection_16_4` (a_16, s_in, s_out, y_4)
- approccio della soluzione: strutturale (MUX 16:1 + DEMUX 1:4)
- figure nel documento, in ordine: dopo Simulazione (forme d'onda)
- parole chiave per l'associazione: interconnection_16_4, demux_1_4, s_in, s_out, y_4

## ALTRO-1.3: Interconnessione 16:4 su board
- documento: ALTRO
- pagine: 11-13
- posizione nel documento: Cap. 1, Esercizio 1.3
- argomento: board
- consegna: come STILE-1.3
- interfaccia attesa: `interconnection_16_4` con a_8_8, load_first, load_second, CLK, s_in, s_out, y_4
- approccio della soluzione: process di controllo (registro a 16 bit caricato per metà) dentro il top; nota sul fatto che il debouncer non serve perché la rete è combinatoria
- figure nel documento, in ordine: nessuna nel testo; listato del file di vincoli (intitolato "File constraints") completo
- parole chiave per l'associazione: a_8_8, load_first, load_second, constraints

## ALTRO-2.1: Sistema ROM+M
- documento: ALTRO
- pagine: 14-15
- posizione nel documento: Esercizio 2, 2.1
- argomento: memorie, combinatorio
- consegna: come STILE-2.1
- interfaccia attesa: `m_system` (input 4, output 4)
- approccio della soluzione: decoder 4:16 (one hot) + ROM 16x8 one hot + trasformatore M (bit 5..2, comportamentale); sistema strutturale; elenco puntato dei 3 componenti
- figure nel documento, in ordine: dopo Simulazione
- parole chiave per l'associazione: decoder, one hot, ROM 16x8, trasformatore M, m_system

## ALTRO-2.2: ROM+M su board
- documento: ALTRO
- pagine: 16
- posizione nel documento: Esercizio 2, 2.2
- argomento: board
- consegna: come STILE-2.2
- interfaccia attesa: non indicata
- approccio della soluzione: nessun codice nuovo, solo vincoli
- figure nel documento, in ordine: nessuna
- parole chiave per l'associazione: constraint, switch, LED

## ALTRO-3.1: Riconoscitore di sequenze
- documento: ALTRO
- pagine: 17-19
- posizione nel documento: Cap. 2 "reti sequenziali elementari", Esercizio 3, 3.1
- argomento: FSM
- consegna: come STILE-3.1
- interfaccia attesa: `automa` (input, mode, CLK, RST, output)
- approccio della soluzione: due process (ingresso-uscita e stato); al cambio modo l'automa riparte da zero
- figure nel documento, in ordine: FSM e waveform (senza didascalia)
- parole chiave per l'associazione: automa, mode, riconoscitore

## ALTRO-3.2: Riconoscitore su board
- documento: ALTRO
- pagine: 19-21
- posizione nel documento: Esercizio 3, 3.2
- argomento: FSM, board
- consegna: come STILE-3.2
- interfaccia attesa: `automa2` (s_in, s_m, load_input, load_mode, CLK, RST, output, n_y, ...)
- approccio della soluzione: due button debouncer (modo e input)
- figure nel documento, in ordine: nessuna nota
- parole chiave per l'associazione: automa2, button debouncer

## ALTRO-4.1: Shift register
- documento: ALTRO
- pagine: 22-24
- posizione nel documento: Esercizio 4, 4.1
- argomento: sequenziale
- consegna: come STILE-4.1
- interfaccia attesa: non ricavata (generic N)
- approccio della soluzione: behavioral + structural (FF, MUX 4x1, MUX 2x1); test con N = 8, un solo screenshot per entrambe
- figure nel documento, in ordine: dopo Simulazione
- parole chiave per l'associazione: shift register, N generic

## ALTRO-5.1: Cronometro
- documento: ALTRO
- pagine: 24-26
- posizione nel documento: Esercizio 5, 5.1
- argomento: strutturale
- consegna: come STILE-5.1
- interfaccia attesa: `chronometer` (clk, start, rst, set, ...)
- approccio della soluzione: contatori in serie, ciascuno da un contatore mod 2 a FF T; simulazione con divisore scollegato
- figure nel documento, in ordine: dopo Simulazione
- parole chiave per l'associazione: chronometer, flip-flop T, mm_set, ss_ended

## ALTRO-5.2: Cronometro su board + Timing analysis
- documento: ALTRO
- pagine: 26-31
- posizione nel documento: Esercizio 5, 5.2
- argomento: board, timing
- consegna: come STILE-5.2
- interfaccia attesa: `board_chronometer` (clk, rst, start, ss_load, mm_load, hh_load, ...)
- approccio della soluzione: debouncer + encoder per decimale; sezione "Timing analysis": periodo 10 ns poi 3.5 ns, FMAX 265 MHz
- figure nel documento, in ordine: report di timing dopo ciascun vincolo
- parole chiave per l'associazione: board_chronometer, encoder, timing analysis, 3.5 ns

## ALTRO-6.1: PO/PC
- documento: ALTRO
- pagine: 32-34
- posizione nel documento: Esercizio 6, 6.1
- argomento: PO/PC
- consegna: come STILE-6.1
- interfaccia attesa: `PO_PC` (CLK, RST, STR, y 4 bit)
- approccio della soluzione: ROM one hot sincrona, contatore mod 16, memoria; uscita di debug SYS_OUT
- figure nel documento, in ordine: dopo Simulazione
- parole chiave per l'associazione: PO_PC, STR, SYS_OUT

## ALTRO-6.2: PO/PC su board
- documento: ALTRO
- pagine: 35-37
- posizione nel documento: Esercizio 6, 6.2
- argomento: board
- consegna: come STILE-6.2
- interfaccia attesa: `Controlled_PO_PC` (CLK, RST, STR_READ, MEM_OUT); `PO_PC` con READ
- approccio della soluzione: nuovo ingresso READ + due debouncer
- figure nel documento, in ordine: nessuna nota
- parole chiave per l'associazione: Controlled_PO_PC, STR_READ

## ALTRO-7.1: Moltiplicatore di Booth
- documento: ALTRO
- pagine: 38-42
- posizione nel documento: Cap. 3, Esercizio 7, 7.1
- argomento: aritmetica
- consegna: come STILE-7.1
- interfaccia attesa: non ricavata
- approccio della soluzione: struttura tipo Robertson: registro M, shift register AQ, counter, adder-subtractor; FSM con stati init, scan, rshift, incr, finish
- figure nel documento, in ordine: FSM dopo la descrizione
- parole chiave per l'associazione: AQ, Q-1, rshift, scan

## ALTRO-7.2: Booth su board + Timing analysis
- documento: ALTRO
- pagine: 42-46
- posizione nel documento: Esercizio 7, 7.2
- argomento: board, timing
- consegna: come STILE-7.2
- interfaccia attesa: non ricavata
- approccio della soluzione: 2 debouncer, encoder decimale, display manager, LED di fine; timing a 10 ns poi 2 ns, FMAX 277 MHz
- figure nel documento, in ordine: report di timing
- parole chiave per l'associazione: display manager, encoder, LED di fine

## ALTRO-8.1: Handshaking
- documento: ALTRO
- pagine: 46-53
- posizione nel documento: Cap. 4, Esercizio 8, 8.1
- argomento: due nodi
- consegna: come STILE-8.1
- interfaccia attesa: `A` (CLK, RST, NXT, ACKb → d, REQ, ACKa), `B` (REQ, ACKa, d → ACKb, TMP_sum_print), `A_B` (CLK, RST, NXT, TMP_sum)
- approccio della soluzione: handshake a 3 passi con segnale NEXT; somma comportamentale; segnali di debug
- figure nel documento, in ordine: dopo Simulazione
- parole chiave per l'associazione: NXT, ACKa, ACKb, TMP_sum

## ALTRO-9.1: Processore
- documento: ALTRO
- pagine: 53-57
- posizione nel documento: Cap. 5, Esercizio 9, 9.1
- argomento: MIC-1
- consegna: come STILE-9.1
- interfaccia attesa: non indicata
- approccio della soluzione: BIPUSH e IAND analizzate con gtkwave; SWAP modificata (tabella prima/dopo come immagine)
- figure nel documento, in ordine: schema del processore all'inizio; waveform dopo ogni istruzione
- parole chiave per l'associazione: BIPUSH, IAND, SWAP, MAL, control store, gtkwave

## ALTRO-10: Interfaccia seriale
- documento: ALTRO
- pagine: 58-63
- posizione nel documento: Cap. 6, Esercizio 10
- argomento: UART
- consegna: come STILE-10.1
- interfaccia attesa: `unit_A` (clk, rst, start, txd, stop, rts, cts), `unit_B` (clk, rst, rxd, stop, rts, cts)
- approccio della soluzione: handshake hardware rts/cts; FSM di A e B
- figure nel documento, in ordine: FSM unità A, FSM unità B in Progetto; waveform dopo Simulazione
- parole chiave per l'associazione: unit_A, unit_B, rts, cts, txd, rxd

## ALTRO-11.1: Switch multistadio
- documento: ALTRO
- pagine: 64-70
- posizione nel documento: Cap. 7, Esercizio 11, 11.1
- argomento: omega network
- consegna: come STILE-11.1
- interfaccia attesa: `switch_2_2` (generic N; a0, a1, sel_in, ... → y0, y1)
- approccio della soluzione: sistema puramente combinatorio, ingresso REQ_TX, espressioni logiche di priorità per stadio (EXP_2_3, EXP_0_1)
- figure nel documento, in ordine: waveform e parte del testbench
- parole chiave per l'associazione: switch_2_2, REQ_TX, EXP_2_3

## ALTRO-12.1: Prova di esame
- documento: ALTRO
- pagine: 71-79
- posizione nel documento: Cap. 8, Esercizio 12, 12.1
- argomento: sistema completo
- consegna: come STILE-12.1
- interfaccia attesa: `A` (CLK, RST, START, REQ, ACK, d), `Adder_Carry_Look_Ahead` (X, Y, C_in → SUM, C_out), `B`, `A_B` (CLK_A, CLK_B, RST, START, SUM)
- approccio della soluzione: R aggiornato ad ogni iterazione con MUX di inizializzazione; nessuna gestione dell'overflow; sezione "Comportamento asincrono" con due clock
- figure nel documento, in ordine: schemi nodo A/B, waveform, due waveform asincrone
- parole chiave per l'associazione: A_B, CLK_A, CLK_B, Adder_Carry_Look_Ahead

## ALTRO-APP: Appendice
- documento: ALTRO
- pagine: 80-91
- posizione nel documento: Appendice
- argomento: componenti
- consegna: per ogni componente sezioni "Progetto e architettura" e "Implementazione" (contatore, memoria NxM, ROM 16x8 in tre varianti, ecc.)
- interfaccia attesa: `mux_2_1`, `decoder_4_16`, `Contatore`, `MEM`, `flipflop_t`, `adder_subtracter`, `generic_register`, `rom_16x8_one_hot`, `ROM_N_4`
- approccio della soluzione: descrizione a parole + listato
- figure nel documento, in ordine: schema in Progetto (es. contatore N=4)
- parole chiave per l'associazione: appendice
