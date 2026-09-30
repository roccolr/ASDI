# Inventario esercizi Vivado

| slug | cartella | stato | design | tb | immagini |
|---|---|---|---|---|---|
| esercizio1-1 | vivado/esercizio1_1 | completo | 2 (src) | sì (sim) | 1 |
| esercizio1-2 | vivado/esercizio1_2 | completo | 3 (src) + demux (sim) | sì (sim) | 1 |
| esercizio2-1 | vivado/esercizio2_1 | completo | 2 | sì | 1 |
| esercizio3-1 | vivado/esercizio3_1 | completo | 1 | sì | 2 |
| esercizio4-1 | vivado/esercizio4_1 | completo | 1 (2 arch) | sì | 2 |
| esercizio5-1 | vivado/esercizio5_1 | completo | 1 | sì | 2 |
| esercizio6-1 | vivado/esercizio6_1 | completo | 3+ | sì | 1 |
| esercizio7-1 | vivado/esercizio7_1 | completo | 3 | sì | 2 |
| esercizio8-1 | vivado/esercizio8_1 | completo | 7 | sì | 4 |

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

## esercizio3-1
- cartella: vivado/esercizio3_1
- progetto: esercizio3_1.xpr
- design: sources_1/new/fsm_sequence.vhd — entità `fsm_sequence` (arch `Behavioral`), 72 righe utili; componenti: nessuno; generic: nessuno
- testbench: sim_1/new/fsm_sequence_tb.vhd — entità `fsm_sequence_tb`, 72 righe utili
- vincoli: nessuno
- IP: nessuno
- immagini:
  - wave3_1.png — simulazione
  - riconoscitore_101_diagramma_stati.png — stati
- report: nessuno
- stato: completo — FSM a 5 stati con logica combinatoria e sequenziale, testbench con più test case commentati
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

## src (componenti comuni in vivado/src, aggiunti dall'utente dopo il primo inventario)
I .xpr li includono come `$PPRDIR/../src/<file>`. Uso per esercizio (dai .xpr):
- esercizio1-1: mux_4_1, mux_16_1
- esercizio1-2: mux_4_1, mux_16_1, interconn16_4
- esercizio2-1: rom16_8
- esercizio3-1: nessuno
- esercizio4-1: dff, mux_2_1, mux_4_1
- esercizio5-1: counter_mod
- esercizio6-1: counter_mod, mem, onecount, rom
- esercizio7-1: full_adder, rca, add_sub, counter_mod
- esercizio8-1: counter_mod, rom, mem
Presenti in src ma non citati da nessun .xpr: automa.vhd, common_defs.vhd, cont_16_s.vhd, ffT.vhd, mic1_datapath.vhd (non assegnati a esercizi).
Cartella vivado/sim (citata da 1_1 e 1_2): ora presente — demux_1_4, mux_16_1_tb, interconn16_4_tb (+ automa_tb, mux_2_1_tb, rca_tb non citati).
