# VHDL, spiegato bene (e senza sbadigli) ⚡

> *"Il software dice alla macchina cosa **fare**. Il VHDL dice alla macchina cosa **essere**."*

Introduzione al VHDL basata sulla lezione 1 di **Architettura dei Sistemi Digitali** (Proff. Mazzocca e De Benedictis), con l'aggiunta di tutto quello che serve per partire davvero: sintassi, costrutti, esempi, trappole classiche.

---

## Indice

1. [Prima di tutto: perché un linguaggio per l'hardware?](#1-prima-di-tutto-perché-un-linguaggio-per-lhardware)
2. [Il cambio di mentalità: non stai programmando](#2-il-cambio-di-mentalità-non-stai-programmando)
3. [Anatomia di un file VHDL](#3-anatomia-di-un-file-vhdl)
4. [I tipi di dato (e il misterioso `std_logic`)](#4-i-tipi-di-dato-e-il-misterioso-std_logic)
5. [I livelli di astrazione](#5-i-livelli-di-astrazione)
6. [Dataflow: il circuito come espressione](#6-dataflow-il-circuito-come-espressione)
7. [Structural: il circuito come Lego](#7-structural-il-circuito-come-lego)
8. [Behavioral: il circuito come comportamento](#8-behavioral-il-circuito-come-comportamento)
9. [Il mondo sequenziale: clock, registri, contatori](#9-il-mondo-sequenziale-clock-registri-contatori)
10. [Macchine a stati finiti (FSM)](#10-macchine-a-stati-finiti-fsm)
11. [Signal vs Variable: la differenza che fa impazzire tutti](#11-signal-vs-variable-la-differenza-che-fa-impazzire-tutti)
12. [Generic e generate: circuiti parametrici](#12-generic-e-generate-circuiti-parametrici)
13. [Il testbench: mettere alla prova il circuito](#13-il-testbench-mettere-alla-prova-il-circuito)
14. [Sintetizzabile o no? Le trappole classiche](#14-sintetizzabile-o-no-le-trappole-classiche)
15. [Cheat sheet finale](#15-cheat-sheet-finale)

---

## 1. Prima di tutto: perché un linguaggio per l'hardware?

Disegnare a mano uno schema con 4 porte logiche è divertente. Disegnarne uno con 400.000 molto meno. Per questo esistono gli **HDL** (*Hardware Description Languages*): testi che **descrivono un circuito**, e che un tool può poi **simulare** (vedere se funziona) e **sintetizzare** (trasformarlo in hardware vero).

Dove finisce quell'hardware? In una delle due grandi famiglie di dispositivi:

| | **ASIC** | **FPGA** |
|---|---|---|
| Nome esteso | *Application Specific Integrated Circuit* | *Field Programmable Gate Array* |
| Programmazione | In fabbrica, **una volta per sempre** | Dall'utente, **quante volte vuoi** |
| Ideale per | Grandi volumi (milioni di chip) | Piccoli volumi, prototipi, ricerca, test |
| Analogia | Una statua di marmo | Un set di Lego infinito |

Entrambi si programmano con un HDL, e i due grandi rivali sono:

- **Verilog / SystemVerilog** → più usato per gli ASIC, dominante negli **USA**;
- **VHDL** → prevalente nel mondo **FPGA**, dominante in **Europa**. 🇪🇺

Nel corso useremo il VHDL, su FPGA (Artix-7 della scheda Nexys A7, vedi [NEXYS_A7.md](NEXYS_A7.md)).

### E la tecnologia conta?

Eccome. Sapere **quali mattoncini offre il dispositivo target** (LUT, flip-flop, blocchi RAM, DSP…) ti permette di:

- scrivere codice che il sintetizzatore **mappa bene** sui componenti disponibili;
- capire quando vale la pena **ottimizzare a mano** e quando no;
- stimare **area occupata** e **tempi di risposta** del design.

Morale: il VHDL non vive nel vuoto, vive sopra un pezzo di silicio.

---

## 2. Il cambio di mentalità: non stai programmando

**VHDL** sta per **V**HSIC **H**ardware **D**escription **L**anguage, dove VHSIC = *Very High Speed Integrated Circuits*. Sì, è un acronimo dentro un acronimo. Benvenuto nell'ingegneria.

La frase più importante di tutta la lezione:

> Il VHDL **non descrive quali operazioni un esecutore deve svolgere** per ottenere un risultato, ma **descrive gli elementi che costituiscono il circuito** in grado di effettuare l'elaborazione.

Tradotto: in C scrivi una **ricetta**; in VHDL disegni la **cucina**.

E soprattutto: **il VHDL è un linguaggio concorrente**. Guarda:

```vhdl
y <= a and b;
z <= y or c;
```

In C, prima calcoleresti `y` e poi `z`. In VHDL queste due righe sono **due pezzi di hardware che esistono contemporaneamente**: una porta AND e una porta OR, collegate da un filo `y`. Se le scrivi al contrario, **il circuito è identico**. L'ordine non conta, perché i fili non fanno la fila. 🧵

| Software (C, Java, Python) | Hardware (VHDL) |
|---|---|
| Istruzioni eseguite una dopo l'altra | Tutto "gira" in parallelo, sempre |
| Variabili in memoria | Segnali = fili e registri |
| Un `for` ripete nel tempo | Un `for` **replica** nello spazio |
| Il risultato arriva quando il programma finisce | Il risultato è sempre lì, e cambia con gli ingressi |

---

## 3. Anatomia di un file VHDL

Ogni design VHDL ha (almeno) tre ingredienti:

```vhdl
-- 1) LIBRERIE: cosa mi serve importare
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;   -- std_logic e std_logic_vector
use IEEE.NUMERIC_STD.ALL;      -- signed/unsigned e aritmetica

-- 2) ENTITY: la "scatola nera" vista da fuori (i piedini)
entity porta_and is
    port (
        a : in  std_logic;
        b : in  std_logic;
        y : out std_logic
    );
end porta_and;

-- 3) ARCHITECTURE: cosa c'è dentro la scatola
architecture dataflow of porta_and is
begin
    y <= a and b;
end dataflow;
```

Pensala così:

- l'**entity** è il **datasheet** del chip: nome e piedini, niente di più;
- l'**architecture** è il **circuito interno**. Una stessa entity può avere più architecture (es. una `dataflow` e una `behavioral`), come due modi diversi di costruire lo stesso oggetto.

### Direzioni delle porte

| Modo | Significato |
|---|---|
| `in` | ingresso: lo leggi e basta |
| `out` | uscita: la scrivi (in VHDL-2008 puoi anche leggerla) |
| `inout` | bidirezionale (bus, pin tri-state) |
| `buffer` | uscita rileggibile internamente (poco usato, meglio un segnale interno) |

### Piccole regole di sopravvivenza

- Il VHDL **non distingue maiuscole e minuscole**: `SIGNAL`, `Signal` e `signal` sono la stessa cosa.
- I commenti iniziano con `--`.
- L'assegnazione a un segnale si scrive `<=`, quella a una variabile `:=` (ne riparliamo nella sezione 11).
- Ogni istruzione finisce con `;`, **tranne l'ultima porta nella `port`**. Classico errore numero uno.

---

## 4. I tipi di dato (e il misterioso `std_logic`)

### `std_logic`: un bit con carattere

Un filo vero non è solo 0 o 1. Può essere scollegato, conteso da due uscite, non inizializzato… Per questo `std_logic` ha **9 valori**:

| Valore | Significato | Quando lo vedi |
|---|---|---|
| `'0'` | zero forte | sempre |
| `'1'` | uno forte | sempre |
| `'Z'` | alta impedenza | bus tri-state |
| `'U'` | non inizializzato | in simulazione, all'inizio: segnale mai assegnato |
| `'X'` | sconosciuto / conflitto | due driver che litigano 🥊 |
| `'-'` | don't care | ottimizzazioni |
| `'W'`, `'L'`, `'H'` | versioni "deboli" | pull-up/pull-down, raramente |

Se in simulazione vedi forme d'onda **rosse con `X` o `U`**, il simulatore ti sta dicendo qualcosa: ascoltalo.

### I tipi che userai davvero

| Tipo | Esempio | Uso |
|---|---|---|
| `std_logic` | `'1'` | un singolo bit |
| `std_logic_vector(7 downto 0)` | `"10100101"` | un bus di bit "generico" |
| `unsigned(7 downto 0)` | `to_unsigned(42, 8)` | numero naturale (per fare aritmetica) |
| `signed(7 downto 0)` | `to_signed(-3, 8)` | numero in complemento a 2 |
| `integer range 0 to 15` | `7` | contatori, indici |
| `boolean` | `true` | condizioni |
| tipi enumerativi | `type stato_t is (IDLE, RUN, STOP);` | stati delle FSM |

Attenzione alla sintassi: un bit si scrive tra **apici singoli** `'1'`, un vettore tra **apici doppi** `"1010"`.

### `downto` vs `to`

```vhdl
signal a : std_logic_vector(7 downto 0);  -- a(7) è l'MSB: la convenzione standard
signal b : std_logic_vector(0 to 7);      -- b(0) è l'MSB: evitalo se non hai motivi
```

### Conversioni: la tabella da tatuarsi

Si usa **solo `numeric_std`** (non `std_logic_arith`/`std_logic_unsigned`, che sono librerie non standard):

```vhdl
unsigned(v)             -- std_logic_vector → unsigned
std_logic_vector(u)     -- unsigned         → std_logic_vector
to_integer(u)           -- unsigned         → integer
to_unsigned(n, 8)       -- integer          → unsigned a 8 bit
```

### Operatori utili

- Logici: `and`, `or`, `nand`, `nor`, `xor`, `xnor`, `not`
- Relazionali: `=`, `/=` (diverso!), `<`, `<=`, `>`, `>=`
- Aritmetici (su `unsigned`/`signed`/`integer`): `+`, `-`, `*`
- Concatenazione: `&` → `"00" & a` attacca due zeri davanti ad `a`
- Aggregato: `(others => '0')` → tutti i bit a zero, qualunque sia la larghezza. Comodissimo.

> ⚠️ In VHDL `and` e `or` hanno **la stessa precedenza**: `a and b or c` non compila. Usa le parentesi: `(a and b) or c`.

---

## 5. I livelli di astrazione

Lo stesso circuito si può descrivere in modi diversi, come una casa si può descrivere con la planimetria, con l'elenco dei mattoni o con "tre camere e vista mare".

| Stile | Idea | Tipico per | Metafora |
|---|---|---|---|
| **Dataflow** | Ogni segnale = un'espressione booleana | Circuiti combinatori | La formula |
| **Structural** | Componenti + fili che li collegano | Composizione gerarchica | Il Lego |
| **Behavioral** | Descrivo *cosa fa*, non *com'è fatto* | Combinatori e sequenziali, testbench | La descrizione a parole |

Due livelli in più da conoscere:

- **RTL (Register Transfer Level)**: descrivi il design in termini di **registri** e della logica combinatoria tra un registro e l'altro. I mattoni sono RAM, ROM, flip-flop, registri, mux, demux, sommatori, moltiplicatori… È **il livello a cui lavorerai quasi sempre**.
- **Gate/transistor level**: il livello più basso, aderente ai componenti elementari della tecnologia target. Di solito lo genera il tool di sintesi, non tu.

> ⚠️ **Attenzione**: una descrizione behavioral **potrebbe non essere sintetizzabile**. Si usa spesso per i **testbench** o come **segnaposto** per componenti di cui non conosci ancora la struttura.

Vediamo ora ogni stile all'opera, usando sempre lo stesso esempio: un **multiplexer 2:1**.

---

## 6. Dataflow: il circuito come espressione

Nello stile dataflow ogni segnale riceve il risultato di un'espressione. Il circuito è visto come una combinazione di porte elementari (`and`, `or`, `xor`…).

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2 is
    port (
        a, b : in  std_logic;
        s    : in  std_logic;
        y    : out std_logic
    );
end mux2;

architecture dataflow of mux2 is
begin
    y <= (a and not s) or (b and s);
end dataflow;
```

Esistono due costrutti concorrenti molto comodi per scrivere mux e decoder in modo leggibile.

**`when … else`** (assegnazione condizionale, con priorità):

```vhdl
y <= a when s = '0' else b;
```

**`with … select`** (assegnazione selezionata, senza priorità, perfetta per i mux grandi):

```vhdl
-- mux 4:1
with sel select
    y <= a when "00",
         b when "01",
         c when "10",
         d when others;   -- "others" copre tutti gli altri casi (incluse X, Z, ...)
```

Un classico, il **full adder**:

```vhdl
entity full_adder is
    port (
        a, b, cin : in  std_logic;
        s, cout   : out std_logic
    );
end full_adder;

architecture dataflow of full_adder is
begin
    s    <= a xor b xor cin;
    cout <= (a and b) or (cin and (a xor b));
end dataflow;
```

Due righe, un sommatore. Non male.

---

## 7. Structural: il circuito come Lego

Nello stile structural non scrivi logica: **prendi componenti già fatti e li colleghi**. È il modo in cui si costruiscono i sistemi complessi, "per composizione ed estensione di circuiti noti" (proprio come dice l'obiettivo del corso).

Esempio: un **ripple-carry adder a 4 bit** costruito con 4 full adder.

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rca4 is
    port (
        a, b : in  std_logic_vector(3 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(3 downto 0);
        cout : out std_logic
    );
end rca4;

architecture structural of rca4 is
    -- fili interni che portano il riporto da uno stadio al successivo
    signal c : std_logic_vector(4 downto 0);
begin
    c(0) <= cin;

    FA0: entity work.full_adder port map (a => a(0), b => b(0), cin => c(0), s => s(0), cout => c(1));
    FA1: entity work.full_adder port map (a => a(1), b => b(1), cin => c(1), s => s(1), cout => c(2));
    FA2: entity work.full_adder port map (a => a(2), b => b(2), cin => c(2), s => s(2), cout => c(3));
    FA3: entity work.full_adder port map (a => a(3), b => b(3), cin => c(3), s => s(3), cout => c(4));

    cout <= c(4);
end structural;
```

Cose da notare:

- `FA0:` è l'**etichetta** dell'istanza, obbligatoria e unica.
- `entity work.full_adder` istanzia direttamente l'entity dalla libreria di lavoro `work`.
- `port map (porta_del_componente => segnale_locale)` è l'**associazione per nome**: più verbosa, ma immune agli errori di ordine. Usala sempre.
- I `signal` dichiarati tra `architecture` e `begin` sono i **fili interni**.

### La forma "classica" con `component`

Nei materiali più datati (e nel codice generato da molti tool) trovi anche questa forma, dove prima si **dichiara** il componente e poi lo si istanzia:

```vhdl
architecture structural of rca4 is
    component full_adder is
        port (a, b, cin : in std_logic; s, cout : out std_logic);
    end component;
    signal c : std_logic_vector(4 downto 0);
begin
    FA0: full_adder port map (a => a(0), b => b(0), cin => c(0), s => s(0), cout => c(1));
    -- ...
end structural;
```

Il risultato è identico: scegli uno stile e sii coerente.

---

## 8. Behavioral: il circuito come comportamento

Qui entra in scena il **`process`**: un blocco al cui interno le istruzioni sono scritte **in modo sequenziale** (con `if`, `case`, `for`…), ma che **nel suo insieme** è un'unica istruzione concorrente.

```vhdl
architecture behavioral of mux2 is
begin
    process (a, b, s)          -- sensitivity list
    begin
        if s = '0' then
            y <= a;
        else
            y <= b;
        end if;
    end process;
end behavioral;
```

La **sensitivity list** `(a, b, s)` dice al simulatore: "risveglia questo process ogni volta che uno di questi segnali cambia". Per la logica combinatoria **deve contenere tutti i segnali letti**, altrimenti simulazione e hardware sintetizzato si comportano in modo diverso. In VHDL-2008 puoi scrivere `process (all)` e dormire sonni tranquilli. 😴

Lo stesso mux 4:1 con un `case`:

```vhdl
process (all)
begin
    case sel is
        when "00"   => y <= a;
        when "01"   => y <= b;
        when "10"   => y <= c;
        when others => y <= d;
    end case;
end process;
```

Regola d'oro: `if` dentro un process ↔ `when … else` fuori; `case` dentro un process ↔ `with … select` fuori. Stesso hardware, vestito diverso.

---

## 9. Il mondo sequenziale: clock, registri, contatori

Finora il circuito "dimenticava" tutto: l'uscita dipendeva solo dagli ingressi attuali. Per ricordare serve un **clock** e dei **flip-flop**.

### Il flip-flop D, l'atomo della memoria

```vhdl
process (clk)
begin
    if rising_edge(clk) then
        q <= d;
    end if;
end process;
```

`rising_edge(clk)` = "sul fronte di salita del clock". Il sintetizzatore riconosce questo schema e ci mette un flip-flop. Tutto qui.

### Reset sincrono vs asincrono

```vhdl
-- Reset SINCRONO: agisce solo sul fronte di clock (consigliato su FPGA Xilinx)
process (clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            q <= '0';
        else
            q <= d;
        end if;
    end if;
end process;

-- Reset ASINCRONO: agisce subito, il clock non serve
process (clk, rst)
begin
    if rst = '1' then
        q <= '0';
    elsif rising_edge(clk) then
        q <= d;
    end if;
end process;
```

Sulle FPGA Xilinx le linee guida del produttore preferiscono il **reset sincrono** (e, dove possibile, pochi reset in generale). È il tipo di "coding guideline" di cui il corso parla.

### Un contatore modulo 16 con enable

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_mod16 is
    port (
        clk, rst, en : in  std_logic;
        count        : out std_logic_vector(3 downto 0)
    );
end counter_mod16;

architecture rtl of counter_mod16 is
    signal cnt : unsigned(3 downto 0) := (others => '0');
begin
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                cnt <= (others => '0');
            elsif en = '1' then
                cnt <= cnt + 1;        -- 15 + 1 torna a 0 da solo: overflow gratuito
            end if;
        end if;
    end process;

    count <= std_logic_vector(cnt);
end rtl;
```

Nota lo schema tipico: un **segnale interno** `unsigned` per fare i conti, e un'assegnazione concorrente che lo porta sulla porta di uscita convertito in `std_logic_vector`.

> 💡 Sulla scheda il clock è a 100 MHz: un contatore così conterebbe 100 milioni di volte al secondo. Per vedere i LED lampeggiare serve un **divisore di frequenza** (un contatore più grande che genera un impulso di enable ogni tanto).

---

## 10. Macchine a stati finiti (FSM)

Le FSM sono il cervello di ogni unità di controllo, e il VHDL le descrive in modo elegantissimo grazie ai **tipi enumerativi**.

Esempio: un **riconoscitore della sequenza "101"** (macchina di Moore, con sovrapposizione).

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seq101 is
    port (
        clk, rst : in  std_logic;
        x        : in  std_logic;
        found    : out std_logic
    );
end seq101;

architecture rtl of seq101 is
    type state_t is (S0, S1, S10, S101);   -- nomi parlanti, il tool sceglie la codifica
    signal state, next_state : state_t;
begin
    -- 1) Registro di stato (sequenziale)
    state_reg: process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= S0;
            else
                state <= next_state;
            end if;
        end if;
    end process;

    -- 2) Logica di stato prossimo (combinatoria)
    next_logic: process (state, x)
    begin
        next_state <= state;               -- default: evita i latch!
        case state is
            when S0   => if x = '1' then next_state <= S1;   end if;
            when S1   => if x = '0' then next_state <= S10;  end if;
            when S10  => if x = '1' then next_state <= S101; else next_state <= S0; end if;
            when S101 => if x = '1' then next_state <= S1;   else next_state <= S10; end if;
        end case;
    end process;

    -- 3) Logica d'uscita (Moore: dipende solo dallo stato)
    found <= '1' when state = S101 else '0';
end rtl;
```

La struttura a **tre blocchi** (registro di stato, stato prossimo, uscita) è la ricetta standard: leggibile, facile da debuggare, e il sintetizzatore la riconosce al volo. Se l'uscita dipendesse anche da `x`, avresti una **macchina di Mealy**.

---

## 11. Signal vs Variable: la differenza che fa impazzire tutti

| | `signal` | `variable` |
|---|---|---|
| Dove si dichiara | nell'architecture (prima del `begin`) | dentro un process |
| Assegnazione | `<=` | `:=` |
| Quando cambia valore | **alla fine** del process (dopo un *delta cycle*) | **subito** |
| Visibilità | tutta l'architecture | solo quel process |
| Cosa rappresenta | un filo o un registro | un valore intermedio di calcolo |

L'esempio che chiarisce tutto:

```vhdl
-- con i SIGNAL: a e b si SCAMBIANO
process (clk)
begin
    if rising_edge(clk) then
        a <= b;
        b <= a;   -- legge il VECCHIO valore di a
    end if;
end process;
```

Entrambe le assegnazioni leggono i valori "di prima" e vengono applicate insieme alla fine: ottieni due registri che si scambiano il contenuto a ogni colpo di clock. Con le variabili, invece, la seconda riga vedrebbe già il nuovo valore e alla fine avresti `a = b = vecchio b`.

Consiglio pratico per chi inizia: **usa i signal**. Le variabili sono utili, ma solo quando sai esattamente che hardware generano.

---

## 12. Generic e generate: circuiti parametrici

Perché scrivere un RCA a 4 bit, uno a 8 e uno a 32 quando puoi scriverne **uno a N bit**?

```vhdl
entity rcaN is
    generic ( N : positive := 8 );                    -- parametro, con valore di default
    port (
        a, b : in  std_logic_vector(N-1 downto 0);
        cin  : in  std_logic;
        s    : out std_logic_vector(N-1 downto 0);
        cout : out std_logic
    );
end rcaN;

architecture structural of rcaN is
    signal c : std_logic_vector(N downto 0);
begin
    c(0) <= cin;

    GEN_FA: for i in 0 to N-1 generate                -- replica NELLO SPAZIO, non nel tempo
        FA: entity work.full_adder
            port map (a => a(i), b => b(i), cin => c(i), s => s(i), cout => c(i+1));
    end generate;

    cout <= c(N);
end structural;
```

E al momento di istanziarlo scegli la taglia:

```vhdl
U_ADD16: entity work.rcaN
    generic map ( N => 16 )
    port map ( a => x, b => y, cin => '0', s => sum, cout => open );  -- "open" = uscita non collegata
```

Il `for … generate` è il modo giusto per pensare ai cicli in hardware: **N copie fisiche** dello stesso blocco, tutte presenti contemporaneamente.

---

## 13. Il testbench: mettere alla prova il circuito

Un testbench è un file VHDL **senza porte** che istanzia il circuito da testare (la *UUT*, Unit Under Test), gli manda stimoli e controlla le risposte. Vive **solo in simulazione**: qui il behavioral non sintetizzabile è di casa (`wait for`, `report`, `assert`…).

```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux2 is
end tb_mux2;                                  -- nessuna porta: è il "mondo esterno"

architecture sim of tb_mux2 is
    signal a, b, s, y : std_logic := '0';
begin
    UUT: entity work.mux2 port map (a => a, b => b, s => s, y => y);

    stimuli: process
    begin
        a <= '0'; b <= '1'; s <= '0'; wait for 10 ns;
        assert y = '0' report "Errore: con s=0 mi aspettavo a" severity error;

        s <= '1';                     wait for 10 ns;
        assert y = '1' report "Errore: con s=1 mi aspettavo b" severity error;

        report "Test completato 🎉";
        wait;                         -- ferma il process per sempre
    end process;
end sim;
```

Per i circuiti sequenziali serve anche un clock:

```vhdl
constant T : time := 10 ns;           -- 100 MHz
...
clk_gen: process
begin
    clk <= '0'; wait for T/2;
    clk <= '1'; wait for T/2;
end process;
```

> 💡 Un process **senza sensitivity list** deve contenere almeno un `wait`, altrimenti il simulatore gira in loop infinito. Un process **con** sensitivity list non può contenere `wait`.

---

## 14. Sintetizzabile o no? Le trappole classiche

Il simulatore accetta quasi tutto; il sintetizzatore no. Ecco i crimini più comuni. 🚨

**1. Il latch involontario.** Se in un process combinatorio un segnale non viene assegnato in **tutti** i rami, il tool deve "ricordarne" il valore e inserisce un latch.

```vhdl
-- ❌ SBAGLIATO: se en = '0', y "si ricorda" il valore → latch
process (en, d)
begin
    if en = '1' then
        y <= d;
    end if;
end process;

-- ✅ GIUSTO: un valore di default in cima, oppure un else
process (en, d)
begin
    y <= '0';
    if en = '1' then
        y <= d;
    end if;
end process;
```

**2. Driver multipli.** Un segnale assegnato da **due process diversi** (o da un process e un'assegnazione concorrente) è un corto circuito logico: in simulazione vedi `X`, in sintesi un errore. Ogni segnale ha **un solo padrone**.

**3. `wait for` e `after` nel design.** `y <= a after 5 ns;` in sintesi viene ignorato: l'hardware non sa contare i nanosecondi. I ritardi reali li decide il silicio.

**4. Sensitivity list incompleta.** Simulazione e hardware non combaciano più. Usa `process (all)`.

**5. Clock "fatti in casa".** Non generare clock con la logica (`clk2 <= clk and en`): usa un **enable** sul clock principale oppure le risorse dedicate (MMCM/PLL).

**6. Aritmetica su `std_logic_vector`.** Converti in `unsigned`/`signed`, fai i conti, riconverti.

**7. Loop con limiti non costanti.** Un `for` è sintetizzabile solo se il numero di iterazioni è noto **in fase di compilazione**, perché deve diventare N copie fisiche.

---

## 15. Cheat sheet finale

> Promemoria di sintassi, non un design da compilare: qui `y` viene assegnato in più punti solo per mostrare le alternative (nel codice vero sarebbe un driver multiplo!).

```vhdl
-- ============ SCHELETRO ============
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity nome is
    generic ( N : positive := 8 );
    port ( clk : in std_logic; d : in std_logic_vector(N-1 downto 0); q : out std_logic_vector(N-1 downto 0) );
end nome;

architecture rtl of nome is
    signal tmp : unsigned(N-1 downto 0);
begin
    -- concorrenti
    y <= a and b;
    y <= a when s = '0' else b;
    with sel select y <= a when "00", b when "01", c when others;

    -- combinatorio
    process (all) begin
        y <= '0';                              -- default anti-latch
        case sel is
            when "00"   => y <= a;
            when others => y <= b;
        end case;
    end process;

    -- sequenziale
    process (clk) begin
        if rising_edge(clk) then
            if rst = '1' then q <= (others => '0');
            else              q <= d;
            end if;
        end if;
    end process;

    -- istanza
    U1: entity work.comp generic map (N => 4) port map (a => x, b => open);

    -- replica
    G: for i in 0 to N-1 generate
        z(i) <= a(i) xor b(i);
    end generate;
end rtl;
```

### Le 7 regole d'oro

1. **Pensa in hardware**: prima disegna il circuito (anche a matita), poi scrivi il VHDL.
2. Ogni riga concorrente è **un pezzo di circuito**, non un'istruzione.
3. Usa **`std_logic` / `std_logic_vector`** sulle porte e **`numeric_std`** per i conti.
4. Nei process combinatori: **`process (all)`** e **valori di default**.
5. Nei process sequenziali: **solo `rising_edge(clk)`**, un solo clock, reset sincrono.
6. Un segnale, **un solo driver**.
7. **Simula sempre** con un testbench prima di caricare sulla scheda: il debug sulla FPGA è molto più doloroso.

---

### Cosa c'è dopo

Il corso parte da qui e sale di livello: macchine combinatorie e sequenziali "notevoli", la loro composizione in sistemi complessi, protocolli di comunicazione tra entità, e infine sistemi completi su **board FPGA** con un **IDE professionale** (Vivado) seguendo le **coding guidelines del produttore**.

Per la parte pratica sulla scheda: 👉 [NEXYS_A7.md](NEXYS_A7.md). Buon hardware! 🔌
