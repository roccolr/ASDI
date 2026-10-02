# Inventario esercizi Vivado

| slug | cartella | stato | design | tb | immagini |
|---|---|---|---|---|---|
| esercizio1-1 | vivado/esercizio1_1 | completo | 2 (src) | sì (sim) | 1 |
| esercizio1-2 | vivado/esercizio1_2 | completo | 3 (src) + demux (sim) | sì (sim) | 1 |
| esercizio1-3 | vivado/esercizio1_3 | parziale | 2 | no | 0 |
| esercizio2-1 | vivado/esercizio2_1 | completo | 2 | sì | 1 |
| esercizio2-2 | vivado/esercizio2_2 | parziale | 1 | no | 0 |
| esercizio3-1 | vivado/esercizio3_1 | completo | 1 | sì | 2 |
| esercizio3-2 | vivado/esercizio3_2 | parziale | 3 | no | 2 |
| esercizio4-1 | vivado/esercizio4_1 | completo | 1 (2 arch) | sì | 2 |
| esercizio5-1 | vivado/esercizio5_1 | completo | 1 | sì | 2 |
| esercizio5-2 | vivado/esercizio5_2 | parziale | 6 | no | 2 |
| esercizio6-1 | vivado/esercizio6_1 | completo | 3+ | sì | 1 |
| esercizio6-2 | vivado/esercizio6_2 | parziale | 8 | no | 0 |
| esercizio7-1 | vivado/esercizio7_1 | completo | 3 | sì | 2 |
| esercizio7-2 | vivado/esercizio7_2 | parziale | 8 | no | 0 |
| esercizio8-1 | vivado/esercizio8_1 | completo | 7 | sì | 4 |
| esercizio9-1 | vivado/mic1 | parziale | 4 | no | 0 |
| esercizio10-1 | vivado/esercizio_10 | completo | 5 | sì | 1 |

## esercizio1-1
- cartella: vivado/esercizio1_1
- progetto: esercizio1_1.xpr (i sorgenti sono esterni al progetto, in vivado/src e vivado/sim)
- design: vivado/src/mux_4_1.vhd (entità `mux_4_1`), vivado/src/mux_16_1.vhd (entità `mux_16_1`)
- testbench: vivado/sim/mux_16_1_tb.vhd (entità `mux_16_1_tb`)
- altri file citati dal .xpr: vivado/sim/demux_1_4.vhd (non usato da questo esercizio)
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave_1_1.png — simulazione
- report: nessuno
- stato: completo (sorgenti in vivado/src e vivado/sim, aggiunta dopo il primo inventario)
- testata: nessuna

## esercizio1-2
- cartella: vivado/esercizio1_2
- progetto: esercizio1_2.xpr (i sorgenti sono esterni al progetto, in vivado/src e vivado/sim)
- design: vivado/src/mux_4_1.vhd, vivado/src/mux_16_1.vhd, vivado/src/interconn16_4.vhd (entità `interconn16_4`)
- design (in sim): vivado/sim/demux_1_4.vhd (entità `demux_1_4`)
- testbench: vivado/sim/interconn16_4_tb.vhd (entità `interconn16_4_tb`); il .xpr cita anche mux_16_1_tb.vhd
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave_1_2.png — simulazione
- report: nessuno
- stato: completo (sorgenti in vivado/src e vivado/sim)
- testata: nessuna

## esercizio2-1
- cartella: vivado/esercizio2_1
- progetto: esercizio2_1.xpr
- design: 
  - sources_1/new/systemS.vhd — entità `systemS` (arch `structural`), 14 righe utili; componenti: rom16_8, systemM; generic: nessuno
  - sources_1/new/systemM.vhd — entità `systemM` (arch `dataflow`), 15 righe utili; componenti: nessuno; generic: nessuno
- testbench: sim_1/new/systemS_tb.vhd — entità `systemS_tb`, 36 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave_2_1.png — simulazione
- report: nessuno
- stato: completo — design implementato (structural con istanziazioni ROM e dataflow) e testbench presente con stimoli
- testata: nessuna

## esercizio1-3
- cartella: vivado/esercizio1_3
- progetto: esercizio1_3.xpr
- design:
  - sources_1/new/acq_reg.vhd — entità `acq_reg` (arch `behavioral`), 27 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/interconn_tl.vhd — entità `top_1_3` (arch `structural`), 29 righe utili; componenti: acq_reg, interconn16_4; generic: nessuno
- testbench: nessuno
- vincoli: constrs_1/imports/Desktop/Nexys-A7-100T-Master.xdc (Nexys A7-100T)
- IP: nessuno
- immagini: nessuna
- report: nessuno
- stato: parziale — design presente (top-level con componenti, incluso registro di acquisizione) ma testbench assente
- testata: nessuna

## esercizio2-2
- cartella: vivado/esercizio2_2
- progetto: esercizio2_2.xpr
- design: sources_1/new/systemS_tl.vhd — entità `systemS_tl` (arch `structural`), 13 righe utili; componenti: systemS; generic: nessuno
- testbench: nessuno
- vincoli: constrs_1/imports/Desktop/Nexys-A7-100T-Master.xdc
- IP: nessuno
- immagini: nessuna
- report: nessuno
- stato: parziale — wrapper top-level per systemS (da esercizio2_1) con porte hardware, nessun testbench
- testata: nessuna

## esercizio3-2
- cartella: vivado/esercizio3_2
- progetto: esercizio3_2.xpr
- design:
  - sources_1/imports/new/fsm_sequence.vhd — entità `fsm_sequence` (arch `Behavioral`), 70 righe utili; componenti: nessuno; generic: nessuno [copia da esercizio3_1]
  - sources_1/new/fsm_sequence_tl.vhd — entità `fsm_sequence_tl` (arch `structural`), 61 righe utili; componenti: debouncer (2×), input_manager, fsm_sequence; generic: nessuno
  - sources_1/new/input_manager.vhd — entità `input_manager` (arch `Behavioral`), 29 righe utili; componenti: nessuno; generic: nessuno
- testbench: nessuno
- vincoli: constrs_1/imports/Desktop/Nexys-A7-100T-Master.xdc (Nexys A7-100T, switch e bottoni per interfaccia)
- IP: nessuno
- immagini:
  - debouncer_fsm.png — stati
  - top_3_2_architettura.png — schema
- report: nessuno
- stato: parziale — sistema completo con controllo di ingresso (debouncer, input_manager) e FSM acquisita, ma nessun testbench
- testata: nessuna

## esercizio3-1
- cartella: vivado/esercizio3_1
- progetto: esercizio3_1.xpr
- design: sources_1/new/fsm_sequence.vhd — entità `fsm_sequence` (arch `Behavioral`), 95 righe utili; componenti: nessuno; generic: nessuno
- testbench: sim_1/new/fsm_sequence_tb.vhd — entità `fsm_sequence_tb`, 76 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave3_1.png — simulazione
  - riconoscitore_101_diagramma_stati.png — stati
- report: nessuno
- stato: completo — FSM a 7 stati (2 gruppi di riconoscimento) con logica Mealy-Moore, testbench con 4 test case con cambi di modalità
- testata: nessuna

## esercizio5-2
- cartella: vivado/esercizio5_2
- progetto: esercizio5_2.xpr
- design:
  - sources_1/new/coronometro_tl.vhd — entità `coronometro_tl` (arch `structural`), 54 righe utili; componenti: cronometro, input_manager, seg7_decoder; generic: nessuno
  - sources_1/new/input_manager.vhd — entità `input_manager` (arch `Behavioral`), 54 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/seg7_decoder.vhd — entità `seg7_decoder` (arch `Behavioral`), 23 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/imports/.../cronometro.vhd — entità `cronometro` (arch `structural`), 44 righe utili [copia da esercizio5_1]
  - sources_1/imports/.../counter_mod.vhd — componente comune, 43 righe utili
  - sources_1/imports/.../debouncer.vhd — componente comune, 56 righe utili
- testbench: nessuno
- vincoli: constrs_1/imports/Desktop/Nexys-A7-100T-Master.xdc (Nexys A7-100T, display 7-segmenti e input)
- IP: nessuno
- immagini:
  - photo_2026-10-02_02-03-20.jpg — scheda
  - photo_2026-10-02_02-03-21.jpg — scheda
- report: nessuno
- stato: parziale — cronometro con decodificatore BCD-to-7seg e controllo di ingresso, ma nessun testbench
- testata: nessuna

## esercizio6-2
- cartella: vivado/esercizio6_2
- progetto: esercizio6_2.xpr
- design:
  - sources_1/new/sistema_tl.vhd — entità `sistema_tl` (arch `structural`), 30 righe utili; componenti: sistema, input_manager, debouncer; generic: nessuno
  - sources_1/imports/.../sistema.vhd — entità `sistema` (arch `structural`), 45 righe utili [copia da esercizio6_1]
  - sources_1/imports/.../control_unit.vhd — entità `control_unit` (arch `behavioral`), 62 righe utili [copia da esercizio6_1]
  - sources_1/imports/.../counter_mod.vhd, .../rom.vhd, .../mem.vhd, .../onecount.vhd, .../debouncer.vhd — componenti comuni
- testbench: nessuno
- vincoli: constrs_1/imports/Desktop/Nexys-A7-100T-Master.xdc
- IP: nessuno
- immagini: nessuna
- report: nessuno
- stato: parziale — sistema (control_unit + datapath) con interfaccia hardware (debouncer, input_manager), nessun testbench
- testata: nessuna

## esercizio7-2
- cartella: vivado/esercizio7_2
- progetto: esercizio7_2.xpr
- design:
  - sources_1/new/booth_tl.vhd — entità `booth_tl` (arch `structural`), 19 righe utili; componenti: booth; generic: nessuno
  - sources_1/imports/new/booth.vhd — entità `booth` (arch `structural`), 31 righe utili [copia da esercizio7_1]
  - sources_1/imports/new/booth_cu.vhd — entità `booth_cu` (arch `behavioral`), 76 righe utili [copia da esercizio7_1]
  - sources_1/imports/new/booth_po.vhd — entità `booth_po` (arch `mixed`), 61 righe utili [copia da esercizio7_1]
  - sources_1/imports/src/add_sub.vhd, .../counter_mod.vhd, .../full_adder.vhd, .../rca.vhd — componenti comuni
- testbench: nessuno
- vincoli: constrs_1/imports/Desktop/Nexys-A7-100T-Master.xdc
- IP: nessuno
- immagini: nessuna
- report: nessuno
- stato: parziale — moltiplicatore Booth (control + datapath) con top-level hardware, nessun testbench
- testata: nessuna

## esercizio4-1
- cartella: vivado/esercizio4_1
- progetto: esercizio4_1.xpr
- design: sources_1/new/shift_register.vhd — entità `shift_register` (arch `Behavioral`, arch `structural`), 95 righe utili; componenti (in structural): mux_4_1, mux_2_1, dff; generic: N
- testbench: sim_1/new/shift_register_tb.vhd — entità `shift_register_tb`, 82 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave4_1.png — simulazione
  - shift_register_slice_strutturale.png — rtl
- report: nessuno
- stato: completo — due architetture (behavioral e structural con generazione generate), testbench con stimoli e verifiche comparative
- testata: nessuna

## esercizio5-1
- cartella: vivado/esercizio5_1
- progetto: esercizio5_1.xpr
- design: sources_1/new/cronometro.vhd — entità `cronometro` (arch `structural`), 52 righe utili; componenti: counter_mod (4 istanze); generic: F_CLK
- testbench: sim_1/new/cronometro_tb.vhd — entità `cronometro_tb`, 66 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave5_1.png — simulazione
  - cronometro_structural_schema.png — rtl
- report: nessuno
- stato: completo — architettura strutturale con cascata di contatori modulari parametrici, testbench con sequenze temporali e verifiche di conteggio
- testata: nessuna

## esercizio6-1
- cartella: vivado/esercizio6_1
- progetto: esercizio6_1.xpr
- design:
  - sources_1/new/sistema.vhd — entità `sistema` (arch `structural`), 51 righe utili; componenti: counter_mod, rom, onecount, mem, control_unit; generic: N, A
  - sources_1/new/control_unit.vhd — entità `control_unit` (arch `behavioral`), 71 righe utili; componenti: nessuno; generic: nessuno
- testbench: sim_1/new/sistema_tb.vhd — entità `sistema_tb`, 63 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave6_1.png — simulazione
- report: nessuno
- stato: completo — sistema completo con control_unit (FSM) e datapath (ROM, counter, memoria), testbench con verifiche di contenuto memoria
- testata: nessuna

## esercizio7-1
- cartella: vivado/esercizio7_1
- progetto: esercizio7_1.xpr
- design:
  - sources_1/new/booth.vhd — entità `booth` (arch `structural`), 36 righe utili; componenti: booth_po, booth_cu; generic: nessuno
  - sources_1/new/booth_po.vhd — entità `booth_po` (arch `mixed`), componenti: add_sub, counter_mod; generic: nessuno
  - sources_1/new/booth_cu.vhd — entità `booth_cu` (arch `behavioral`), 88 righe utili; componenti: nessuno; generic: nessuno
- testbench: sim_1/new/booth_tb.vhd — entità `booth_tb`, 53 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave7_1.png — simulazione
  - booth_schema_blocchi.png — rtl
- report: nessuno
- stato: completo — moltiplicatore Booth con datapath (registri, sommatore) e FSM 5 stati, testbench con verifica prodotto firmato
- testata: nessuna

## esercizio8-1
- cartella: vivado/esercizio8_1
- progetto: esercizio8_1.xpr
- design:
  - sources_1/new/system_A.vhd — entità `system_A` (arch `structural`), 49 righe utili; componenti: cu_A, counter_mod, rom_8_8; generic: N, M
  - sources_1/new/system_B.vhd — entità `system_B` (arch `structural`), 67 righe utili; componenti: cu_B, mem, counter_mod, adder, register_M; generic: N, M
  - sources_1/new/cu_A.vhd — entità `cu_A` (arch `behavioral`), 57 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/cu_B.vhd — entità `cu_B` (arch `behavioral`), 60 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/adder.vhd — entità `adder` (arch), componenti: nessuno; generic: M
  - sources_1/new/register_M.vhd — entità `register_M`, componenti: nessuno; generic: M
  - sources_1/new/rom_8_8.vhd — entità `rom_8_8`, componenti: nessuno; generic: N, A
- testbench: sim_1/new/handshaking_tb.vhd — entità `handshaking_tb`, ~80 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave8_1.png — simulazione
  - architettura.png — rtl
  - cu_A_fsm.png — stati
  - cu_B_fsm.png — stati
- report: nessuno
- stato: completo — due sistemi concorrenti (A produttore/B consumatore) con sincronizzazione handshaking, testbench con due clock diversi
- testata: nessuna

## esercizio9-1
- cartella: vivado/mic1 (esercizio_9 è un progetto vuoto, mic1 contiene l'implementazione)
- progetto: mic1.xpr
- design:
  - sources_1/new/mic1.vhd — entità `mic1` (arch `structural`), 42 righe utili; componenti: mic1_cu, mic1_datapath; generic: nessuno
  - sources_1/new/mic1_cu.vhd — entità `mic1_cu` (arch `Behavioral`), 55 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/alu.vhd — entità `alu` (arch `Behavioral`), 38 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/control_store.vhd — entità `control_store` (arch `Behavioral`), 27 righe utili; componenti: nessuno; generic: nessuno
- testbench: nessuno
- vincoli: nessuno
- IP: nessuno
- immagini: nessuna
- report: nessuno
- stato: parziale — microprocessore minimalista (mic-1) con CU a microcodice, ALU, percorso dati incompleto, nessun testbench
- testata: nessuna

## esercizio10-1
- cartella: vivado/esercizio_10
- progetto: esercizio_10.xpr
- design:
  - sources_1/new/marco_system.vhd — entità `marco_system` (arch `structural`), 25 righe utili; componenti: systemA, systemB; generic: nessuno
  - sources_1/new/systemA.vhd — entità `systemA` (arch `structural`), 47 righe utili; componenti: cuA, Rs232RefComp, counter_mod, rom; generic: nessuno
  - sources_1/new/systemB.vhd — entità `systemB` (arch `structural`), 48 righe utili; componenti: cuB, Rs232RefComp, counter_mod, mem; generic: nessuno
  - sources_1/new/cuA.vhd — entità `cuA` (arch `Behavioral`), 53 righe utili; componenti: nessuno; generic: nessuno
  - sources_1/new/cuB.vhd — entità `cuB` (arch `Behavioral`), 54 righe utili; componenti: nessuno; generic: nessuno
- testbench: sim_1/imports/new/macro_system_tb.vhd — entità `macro_system_tb` (arch `Behavioral`), 77 righe utili; verifica trasferimento seriale ROM→MEM con RS232
- vincoli: nessuno
- IP: nessuno
- immagini:
  - testbench.png — simulazione
- report: nessuno
- stato: completo — sistema producer-consumer seriale (SystemA→RS232→SystemB, ROM↔MEM) con FSM e handshaking, testbench con 8 byte di trasferimento e verifica MEM
- testata: nessuna

## src (componenti comuni in vivado/src, aggiunti dall'utente dopo il primo inventario)
I .xpr li includono come `$PPRDIR/../src/<file>`. Uso per esercizio (dai .xpr):
- esercizio1-1: mux_4_1, mux_16_1
- esercizio1-2: mux_4_1, mux_16_1, interconn16_4
- esercizio1-3: demux_1_4, mux_4_1, mux_16_1, interconn16_4
- esercizio2-1: rom16_8
- esercizio2-2: rom16_8
- esercizio3-1: nessuno
- esercizio3-2: debouncer
- esercizio4-1: dff, mux_2_1, mux_4_1
- esercizio5-1: counter_mod
- esercizio5-2: bin2dec, debouncer, counter_mod, dispaly_driver
- esercizio6-1: counter_mod, mem, onecount, rom
- esercizio6-2: debouncer, counter_mod, mem, onecount, rom
- esercizio7-1: full_adder, rca, add_sub, counter_mod
- esercizio7-2: full_adder, rca, add_sub, counter_mod
- esercizio8-1: counter_mod, rom, mem
- esercizio9-1: common_defs, mic1_datapath
- esercizio10-1: RS232RefComp, counter_mod, rom, mem
Nuovi file (rispetto al primo inventario): bin2dec.vhd, debouncer.vhd, dispaly_driver.vhd, RS232RefComp.vhd.
Presenti in src ma non citati da nessun .xpr: automa.vhd, cont_16_s.vhd, ffT.vhd (non assegnati a esercizi).
Cartella vivado/sim (citata da 1_1 e 1_2): demux_1_4, mux_16_1_tb, interconn16_4_tb (+ automa_tb, mux_2_1_tb, rca_tb non citati).

## Esercitazioni escluse (non inventariate)
RCA/, add_sub/, full_adder/, contatore_modulo16_seriale/, lab01_mux/, lab02/ — esercitazioni separate non integrate nell'elaborato.
