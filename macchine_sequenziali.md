# Macchine sequenziali

Guida allo studio dei richiami sulle macchine sequenziali (lucidi 12–17). La prima parte è una mappa per orientarsi; la seconda guarda le macchine notevoli come scatole nere, per capire quando usare cosa; la terza è un approfondimento verticale sulla distinzione tra macchine asincrone e sincrone, con le quattro domande chiave sviluppate per esteso.

Dove un passaggio va oltre quanto scritto nei lucidi (una deduzione o un collegamento con la pratica su FPGA), è segnalato come *osservazione*.

---

## Indice

**Parte I — Orientarsi**
1. [Roadmap di studio](#1-roadmap-di-studio)
2. [Il filo conduttore in una pagina](#2-il-filo-conduttore-in-una-pagina)

**Parte II — Le macchine notevoli viste da fuori**

3. [Mealy o Moore](#3-mealy-o-moore)
4. [Elementi di memoria: latch e flip-flop](#4-elementi-di-memoria-latch-e-flip-flop)
5. [Registri](#5-registri)
6. [Contatori](#6-contatori)
7. [Memorie](#7-memorie)

**Parte III — Asincrone e sincrone, in verticale**

8. [La vera differenza tra asincrono e sincrono](#8-la-vera-differenza-tra-asincrono-e-sincrono)
9. [Macchine asincrone: come ragionarci](#9-macchine-asincrone-come-ragionarci)
10. [Macchine sincrone: perché serve un sincronismo](#10-macchine-sincrone-perché-serve-un-sincronismo)
11. [La tempificazione dell'abilitazione nel latch D](#11-la-tempificazione-dellabilitazione-nel-latch-d)
12. [Come il flip-flop risolve il problema](#12-come-il-flip-flop-risolve-il-problema)
13. [Perché il comportamento master-slave è il più desiderabile](#13-perché-il-comportamento-master-slave-è-il-più-desiderabile)
14. [Macchine a sincronizzazione esterna, con esempi](#14-macchine-a-sincronizzazione-esterna-con-esempi)
15. [Riepilogo per il ripasso](#15-riepilogo-per-il-ripasso)

---

# Parte I — Orientarsi

## 1. Roadmap di studio

I sei lucidi formano una catena: ognuno usa i concetti del precedente. Conviene seguirli in ordine, ma con pesi diversi.

```
 12 Automi e macchine sequenziali      il modello: ASF, Mealy/Moore, Huffman,
            |                          asincrono vs sincrono
            v
 13 Latch e flip-flop                  il cuore del corso: come si memorizza
            |                          un bit e perché la tempificazione conta
            v
 14 Progetto di macchine sincrone      la procedura: dalla specifica al circuito
            |
            v
 15 Riconoscitori di sequenze          la procedura applicata, passo per passo
            |
            v
 16 Registri e contatori               macchine notevoli costruite con i flip-flop
            |
            v
 17 Memorie                            la macchina sequenziale "per antonomasia"
```

| Lucido | Cosa portarsi via | Peso |
|---|---|---|
| **12** | Quintupla dell'ASF, differenza Mealy/Moore, modello di Huffman (rete combinatoria + memoria di stato), definizione di macchina asincrona e sincrona, ruolo dei ritardi nella retroazione | Alto: è il vocabolario di tutto il resto |
| **13** | Latch vs flip-flop, tabelle di transizione ed eccitazione, vincoli sull'abilitazione del latch D, edge-triggered vs master-slave, T e JK come macchine intrinsecamente sincrone | Massimo: qui stanno quasi tutte le domande concettuali |
| **14** | Le fasi di progetto: automa, codifica degli stati, scelta dei flip-flop, tabella delle eccitazioni, minimizzazione | Medio: è breve, ma è il metodo che userai sempre |
| **15** | Riconoscitori con e senza sovrapposizione, minimizzazione per stati equivalenti, sintesi con D e con JK | Medio: da fare a mano almeno una volta, poi basta la logica |
| **16** | Tipi di registro e a cosa servono, contatori sincroni vs seriali, progetto per composizione e per riduzione, reset/load sincroni e asincroni | Alto: sono i mattoni che userai in VHDL |
| **17** | Decoder di indirizzo, MUX in lettura, DMUX in scrittura, chip select, composizione per capacità e per parallelismo | Basso: concetti semplici, da conoscere come scatola nera |

Un percorso ragionevole:

1. **Prima passata sul 12**, fino a saper spiegare a voce perché una macchina con soli ingressi a livelli funziona solo se è asincrona.
2. **Il 13 con calma**, con carta e penna: disegna i diagrammi temporali del latch D e dei flip-flop. Le sezioni 11–13 di questa guida seguono esattamente questo percorso.
3. **14 e 15 insieme**: leggi le fasi di progetto e poi rifai da solo il riconoscitore di 1011 senza guardare le soluzioni.
4. **16 e 17** come catalogo di componenti: per ciascuno chiediti "che problema risolve" e "perché è fatto con flip-flop e non con latch".

---

## 2. Il filo conduttore in una pagina

L'intera sequenza di lucidi risponde a una domanda: **come si costruisce una macchina che ricorda?**

1. Una macchina sequenziale è un automa a stati finiti: l'uscita dipende dall'ingresso **e dallo stato**, cioè dalla storia passata.
2. Il **modello di Huffman** separa la parte che calcola (una rete combinatoria che produce stato prossimo e uscita) dalla parte che ricorda (la memoria di stato, che riporta lo stato prossimo in ingresso come stato presente).
3. La memoria di stato può essere di due tipi:
   - **semplici fili di retroazione**, se la macchina raggiunge sempre uno stato stabile (macchina **asincrona**);
   - **veri elementi di memoria**, se la macchina altrimenti continuerebbe a evolvere (macchina **sincrona**).
4. Gli elementi di memoria sono a loro volta macchine sequenziali, e devono essere **asincrone**: in fondo alla catena ci sono sempre porte logiche e fili di retroazione.
5. Il modo in cui l'elemento di memoria reagisce al segnale di sincronismo (a livello o sul fronte) decide se la macchina sincrona costruita sopra funziona in modo affidabile. Da qui latch, flip-flop edge-triggered e master-slave.
6. Una volta chiarito questo, il progetto di una macchina sincrona diventa una procedura: automa, codifica, scelta dei flip-flop, sintesi della rete combinatoria. Registri, contatori e memorie sono i casi notevoli.

---

# Parte II — Le macchine notevoli viste da fuori

## 3. Mealy o Moore

| | Mealy | Moore |
|---|---|---|
| Funzione di uscita | ω: Q × I → U | ω: Q → U |
| Dove sta l'uscita nel grafo | sugli archi (`ingresso/uscita`) | sui nodi (`stato/uscita`) |
| Numero di stati | tipicamente minore | tipicamente maggiore |
| Reattività | l'uscita risponde subito all'ingresso | l'uscita cambia solo con lo stato |
| Natura dell'uscita in una macchina sincrona | impulsiva: significativa in corrispondenza del sincronismo | a livelli: stabile per tutto il ciclo |
| Esempi dai lucidi | distributore di bibite, riconoscitore di sequenza | controllo disponibilità parcheggio, contatori |

I due modelli sono equivalenti: si passa dall'uno all'altro con opportune trasformazioni. Moore ha più stati perché, se in uno stato si arriva con uscite diverse, bisogna sdoppiarlo (nell'esempio dei lucidi serve un quarto stato S3 associato all'uscita 1).

**Quando usare cosa.** La regola del lucido 14: se l'uscita dipende in modo naturale dagli ingressi, usa Mealy. Un riconoscitore "si accorge" della sequenza nel momento in cui arriva l'ultimo bit, quindi è naturalmente Mealy. Un contatore mostra il proprio stato, quindi è naturalmente Moore. Se ti serve un'uscita stabile e pulita per tutto il ciclo (per pilotare altri blocchi), Moore è la scelta più sicura.

---

## 4. Elementi di memoria: latch e flip-flop

Un **bistabile** è una macchina di Moore con due stati stabili (memorizza 0, memorizza 1) e l'uscita coincide con lo stato. Di solito offre Q e !Q.

### Due classificazioni indipendenti

**Per modalità di memorizzazione:**

- **Latch**: sensibile al *livello*. Finché è abilitato, l'uscita segue gli ingressi (è "trasparente").
- **Flip-flop**: sensibile al *fronte* dell'abilitazione. Cambia stato solo in corrispondenza della transizione 0→1 o 1→0.

**Per tipo di ingresso dato:**

| Tipo | Ingressi | Cosa fa | Equazione di stato |
|---|---|---|---|
| **D** | D | memorizza D | Q' = D |
| **RS** | R, S | S=1 imposta, R=1 azzera, 00 mantiene, 11 vietato | Q' = S + !R·Q |
| **T** | T | T=1 commuta, T=0 mantiene | Q' = T ⊕ Q |
| **JK** | J, K | come RS (J=set, K=reset), ma JK=11 commuta | Q' = J·!Q + !K·Q |

### Tabelle di eccitazione

Rispondono alla domanda che ti farai durante ogni progetto: *quali ingressi devo dare al bistabile per passare da Q a Q'?*

| Q → Q' | D | S R | T | J K |
|:---:|:---:|:---:|:---:|:---:|
| 0 → 0 | 0 | 0 – | 0 | 0 – |
| 0 → 1 | 1 | 1 0 | 1 | 1 – |
| 1 → 0 | 0 | 0 1 | 1 | – 1 |
| 1 → 1 | 1 | – 0 | 0 | – 0 |

### Quale scegliere e perché

| Scelta | Quando | Perché |
|---|---|---|
| **Latch** | Quasi mai come memoria di stato di una macchina sincrona | La trasparenza durante l'abilitazione crea i problemi di tempificazione della sezione 11 |
| **Flip-flop D** | Scelta di default | Progetto immediato: l'ingresso D coincide con lo stato prossimo, quindi la tabella delle eccitazioni è la tabella degli stati. È il flip-flop che trovi nelle FPGA |
| **Flip-flop T** | Contatori | Il comportamento "commuta" è esattamente quello di un contatore mod-2 |
| **Flip-flop JK** | Quando vuoi reti combinatorie più semplici | La tabella di eccitazione ha molti don't care, che la minimizzazione sfrutta. Collegando J=K si ottiene un T |
| **RS** | Soprattutto per ragioni storiche e didattiche | È il latch fondamentale, ma ha la combinazione vietata 11. Il latch D si ottiene da un RS abilitato con S = A·D, R = A·!D, ed elimina il problema |

Una conseguenza importante, che torna nella sezione 13: T e JK sono **intrinsecamente sincroni**. Con T=1 (o JK=11) applicato a livello la macchina oscilla tra i due stati senza fermarsi. Per usarli serve o un ingresso impulsivo, o una realizzazione sensibile ai fronti.

---

## 5. Registri

Un registro è un insieme di flip-flop sincronizzati sullo stesso clock, più eventuale logica che decide cosa caricare. Si classificano per come si scrive e come si legge: in parallelo o in serie.

| Registro | Ingresso → Uscita | A cosa serve |
|---|---|---|
| Parallelo-parallelo | k bit → k bit | Memorizzare una parola |
| A scorrimento (serie-serie) | 1 bit → 1 bit | Ritardare un flusso seriale di k colpi di clock |
| Serie-parallelo | 1 bit → k bit | Ricevere bit in serie e ricomporre un byte (telecomunicazioni) |
| Parallelo-serie | k bit → 1 bit | Serializzare una parola; generare sequenze |
| Circolare | l'uscita rientra in ingresso | Sequenze periodiche; contatore ad anello |
| Sinistra/destra | MUX su ogni ingresso | Moltiplicazione e divisione per 2^i |

Scelte di progetto ricorrenti:

- **Selezionare la modalità con i multiplexer**: un MUX davanti a ogni flip-flop, comandato da un segnale di controllo, sceglie tra ingresso parallelo, bit precedente, bit successivo. È lo stesso schema per circolare/normale, sinistra/destra, caricamento parallelo/scorrimento.
- **Contatore ad anello**: un registro circolare di n bit con un solo 1 che gira è un contatore mod-n. Costa più flip-flop del necessario (4 invece di 2 per il mod-4), ma lo stato è già decodificato.
- **Mai latch in un registro a scorrimento.** Con un latch trasparente il dato attraverserebbe più stadi nello stesso impulso di abilitazione. È la stessa ragione della sezione 11, vista su una catena di bistabili.

---

## 6. Contatori

Un contatore è una macchina di Moore senza ingressi dato, che percorre una sequenza fissa di stati a ogni impulso di conteggio. Il **modulo** è la lunghezza della sequenza. Ingressi opzionali: EN (abilitazione), RESET, LOAD. Uscita opzionale: **CO** (riporto o divisore), alta quando il conteggio raggiunge n–1.

### Tre strade per progettarne uno

1. **Come macchina sincrona generica**: automa, flip-flop, sintesi. Per il mod-16 con JK si ottiene una regola elegante: il bit i commuta quando tutti i bit meno significativi valgono 1.
   ```
   J0 = K0 = EN
   J1 = K1 = Q0 · EN
   J2 = K2 = Q0 · Q1 · EN
   J3 = K3 = Q0 · Q1 · Q2 · EN
   CO      = Q0 · Q1 · Q2 · Q3 · EN
   ```
2. **Per composizione**: si collegano contatori di modulo più piccolo. Unità, decine e centinaia per il mod-1000; più contatori mod-2 per un mod-2^m; due contatori mod-16 collegati tramite CO per un mod-256.
3. **Per riduzione**: si parte da un contatore di modulo M > N e si accorcia il ciclo con RESET o LOAD.

### Schema parallelo o seriale

| | Parallelo (sincrono) | Seriale (a cascata, "ripple") |
|---|---|---|
| Clock | arriva a tutti gli stadi | solo al primo; gli altri sono pilotati dall'uscita del precedente |
| Frequenze diverse | ottenute con logica combinatoria sul clock e sulle uscite | ottenute naturalmente dalla cascata |
| Velocità | alta | bassa per molti bit: i ritardi si sommano |
| Valori transitori | nessuno | sì: da 3 a 4 passa per 3 → 2 → 0 → 4 |
| Consumo | più alto | basso: si attiva solo la parte che commuta |

Negli schemi composti gli stadi successivi devono commutare sul **fronte di discesa** del proprio impulso: se commutassero sul fronte di salita, il secondo stadio scatterebbe subito insieme al primo e il conteggio andrebbe in modo sbagliato (decrescente, nel caso di contatori mod-2).

### Reset e load: sincroni o asincroni

- **Sincrono**: ha effetto solo al fronte attivo del clock. Per un mod-11 da un mod-16 si alza il reset quando il conteggio vale **10**: al fronte successivo il contatore va a 0 invece che a 11.
- **Asincrono**: ha effetto appena si attiva, indipendentemente dal clock. Nell'esempio dei lucidi il reset è attivo sul passaggio 1→0: lo si alza quando il conteggio vale 10; al fronte successivo il conteggio diventa 11, la condizione viene meno, il reset si abbassa e le uscite si azzerano subito. Il valore 11 esiste quindi solo per un istante.
- **Load sincrono**, mod-10 da un mod-16: Load = Q3·Q0, attivo quando il conteggio vale 9 (1001). Tutti i valori sopra il 9 sono don't care e la rete si semplifica.

---

## 7. Memorie

Una memoria è una matrice di celle, ciascuna un registro di n bit. Come scatola nera ha:

- **k linee di indirizzo** → 2^k celle selezionabili, tramite un **decoder**;
- in **scrittura**, un **DMUX** che instrada il dato verso la cella selezionata;
- in **lettura**, un **MUX** che porta in uscita la cella selezionata;
- un **chip select (CS)**, che abilita l'intero modulo; quando non è attivo, le uscite tri-state lasciano il bus libero.

Per costruire memorie più grandi con moduli piccoli:

| Obiettivo | Come |
|---|---|
| Più **celle** (capacità) | Stessi dati, un decoder aggiuntivo sui bit alti di indirizzo pilota i CS dei moduli in modo mutuamente esclusivo |
| Più **bit per cella** (parallelismo) | Moduli affiancati con stessi indirizzi e stesso CS; ognuno fornisce una porzione della parola |

---

# Parte III — Asincrone e sincrone, in verticale

## 8. La vera differenza tra asincrono e sincrono

L'errore più comune è pensare che "sincrono" voglia dire "ha un clock". La definizione dei lucidi è diversa, e più profonda.

> **Macchina asincrona**: partendo da **qualsiasi** stato e applicando **qualsiasi** ingresso, anche per un tempo lunghissimo, raggiunge uno stato **stabile** e ci resta finché l'ingresso non cambia.
>
> **Macchina sincrona**: esiste **almeno una** coppia (stato, ingresso) per cui la macchina continua a evolvere finché l'ingresso è applicato, senza fermarsi.

Il criterio si legge sull'automa o sulla tabella di transizione: una macchina è asincrona se, per ogni colonna di ingresso, qualunque stato di partenza porta prima o poi a uno stato che ha sé stesso come stato prossimo (stato stabile, cerchiato nella tabella).

**L'esempio dei due contatori mod-2** rende tutto concreto:

- *Contatore delle variazioni 0→1* (asincrono): conta i **fronti** dell'ingresso. Ha 4 stati: con ingresso 1 resta fermo su "ho contato 1" per quanto a lungo tu tenga l'1. La sua evoluzione dipende da *quante volte l'ingresso cambia*.
- *Contatore degli 1* (sincrono): conta i **valori** 1. Se tieni l'ingresso a 1 a lungo, oscilla tra 0 e 1 in modo indefinito. La sua evoluzione dipende da *quanto dura l'ingresso* e dai tempi di reazione del circuito.

Da qui tre conseguenze che vale la pena fissare:

1. **La presenza di un ingresso di abilitazione non rende sincrona una macchina.** Il latch D ha un'abilitazione ma è una macchina asincrona.
2. **Una macchina con soli ingressi a livelli funziona solo se è asincrona**, perché solo allora il suo comportamento non dipende dalla durata degli ingressi.
3. **Ogni macchina sincrona contiene macchine asincrone.** Gli elementi di memoria sulla retroazione sono sequenziali, e devono essere asincroni: la loro retroazione è fatta di fili. La gerarchia si chiude sempre su porte e fili.

---

## 9. Macchine asincrone: come ragionarci

### La memoria è il ritardo

In una macchina asincrona la memoria di stato del modello di Huffman è **un filo di retroazione per ogni bit di stato**. Funziona perché la rete combinatoria e le linee hanno un ritardo non nullo: lo stato prossimo ricompare in ingresso come stato presente "un po' dopo", e la macchina si assesta su uno stato stabile.

```
            +---------------------------+
ingressi -->|                           |--> uscite
            |   rete combinatoria       |
     +----->|   (ritardo Ec + Δc)       |---+
     |      +---------------------------+   |
     |                                      |
     +------ linee di retroazione (Δl) -----+
```

### Il vincolo sulla durata degli ingressi

Una transizione tra due stati stabili può attraversare k stati intermedi. Perché si completi, l'ingresso deve durare abbastanza:

```
d > k · (Ec + Δc + Δl)
```

con Ec ritardo inerziale e Δc ritardo puro della rete combinatoria, Δl ritardo delle linee. Se l'ingresso cambia prima, la macchina si ritrova in uno stato intermedio non previsto.

### Le regole del gioco

Progettare una macchina asincrona significa convivere con i transitori. I lucidi insistono su tre punti:

1. **Un bit alla volta.** Le configurazioni degli ingressi (inclusi i bit di stato) devono cambiare tra valori **adiacenti**. Nella realtà due segnali non cambiano mai esattamente insieme: uno arriva prima dell'altro in modo imprevedibile, e la macchina può passare per una configurazione intermedia non voluta. Nelle tabelle le transizioni non adiacenti diventano don't care.
2. **Alee statiche.** Nel latch D, Q' = Q·!A + A·D ha un'alea: quando A cambia, se le due AND hanno ritardi diversi, l'uscita può scendere per un attimo. Si aggiunge l'implicante ridondante Q·D, che "tiene su" l'uscita durante il passaggio: Q' = Q·!A + A·D + Q·D. Qui la forma minima è quella sbagliata.
3. **Corse.** Quando più bit di stato cambiano insieme e il transitorio passa per stati intermedi:
   - **corsa non critica**: la macchina passa per uno stato sbagliato ma arriva comunque a quello giusto. Esempio: latch D con AD da 01 a 10; se A sale prima che D scenda, il latch memorizza 1 per un istante e poi torna a 0;
   - **corsa critica**: il transitorio porta la macchina in uno stato sbagliato **stabile**, da cui non esce più.

### Quando conviene una macchina asincrona

- Quando devi costruire **un elemento di memoria**: latch e flip-flop sono macchine asincrone, anche quelli sensibili al fronte (il flip-flop D edge-triggered è una macchina asincrona a 4 stati, il master-slave anche).
- Quando il comportamento dipende da **eventi**, cioè dai cambiamenti di un segnale e non dalla sua durata: contare fronti, reagire a una transizione.
- Quando serve **reagire subito** senza aspettare un clock.

Il prezzo è un progetto fragile: dipende da ritardi reali, alee, corse. Per questo, sopra il livello del singolo bistabile, si progetta quasi sempre in modo sincrono.

---

## 10. Macchine sincrone: perché serve un sincronismo

In una macchina sincrona certi ingressi producono una catena di transizioni la cui lunghezza dipende da quanto dura l'ingresso. Per renderla prevedibile bisogna garantire **una sola transizione per volta**. I lucidi offrono due strade:

1. **Ingressi impulsivi**: gli ingressi durano esattamente il tempo necessario a una transizione. È una proprietà legata alla realizzazione fisica, difficile da garantire.
2. **Ingressi a livelli più un segnale di sincronismo**: gli ingressi possono restare fermi quanto vogliono, e la transizione avviene solo in presenza del sincronismo.

La seconda strada porta al modello delle **macchine a sincronizzazione esterna**: gli ingressi sono campionati solo in corrispondenza di un segnale di sincronismo impulsivo, il **clock**. Siccome le transizioni avvengono tra stati che in generale non sono stabili, lo stato prossimo va **congelato** in un vero elemento di memoria, da cui verrà riletto al sincronismo successivo.

```
             +---------------------------+
ingressi --->|                           |---> uscite
             |   rete combinatoria       |
      +----->|                           |---+
      |      +---------------------------+   | stato prossimo
      |                                      |
      |      +---------------------------+   |
      +------|   memoria di stato        |<--+
             +---------------------------+
                          ^
                          | sincronismo (clock)
```

Resta una domanda: *quale* elemento di memoria mettere in quella retroazione. Le prossime tre sezioni rispondono.

---

## 11. La tempificazione dell'abilitazione nel latch D

### Il latch D come scatola nera

- A = 1: l'uscita Q segue D (latch trasparente);
- A = 0: Q conserva l'ultimo valore, qualunque cosa faccia D.

Già da solo, come macchina asincrona, ha due vincoli:

- una volta impostato D, **A deve restare alta abbastanza** perché il valore arrivi in memoria (attraversi rete e retroazione);
- **A e D non devono cambiare insieme** (regola dell'adiacenza, sezione 9). Idealmente A torna bassa prima della successiva variazione di D, così due memorizzazioni successive restano distinte.

### Il problema vero: il latch dentro una macchina sincrona

Si può usare un latch D per ogni bit di stato, con un'abilitazione comune A che fa da sincronismo. Sì, ma con un vincolo stretto su A. Siano:

- **T_R** il ritardo della rete combinatoria (dal cambiamento di stato o ingresso al nuovo stato prossimo pronto);
- **T_F** il ritardo del latch (dall'abilitazione al dato memorizzato in uscita).

Seguiamo un impulso di A partendo dallo stato S0, con ingresso i:

| Istante | Cosa succede |
|---|---|
| t0 | Cambia l'ingresso i |
| t0 + T_R | La rete ha calcolato S1 = t(S0, i) e lo presenta su D. **Solo ora si può alzare A** |
| t1 | A sale: il latch diventa trasparente |
| t1 + T_F | Q = S1: lo stato è aggiornato. **Da qui in poi A può scendere** |
| t1 + T_F + T_R | La rete vede il nuovo stato S1 e calcola S2 = t(S1, i). Se A è ancora alta, **il latch cattura anche S2** |

L'ultima riga è il cuore del problema. Il latch è trasparente, quindi l'anello rete combinatoria → latch → rete combinatoria è **chiuso** per tutto il tempo in cui A è alta. Se A dura troppo, lo stato fa più di un passo nello stesso impulso: la macchina torna a comportarsi come una sincrona senza sincronismo, cioè a evolvere in base alla durata di un segnale.

Da qui il vincolo sulla durata di A:

```
T_F  <  durata di A  <  T_F + T_R

A:   _______/‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\_______
            |<---- T_F ---->|<---- T_R ---->|
             troppo presto:   A deve scendere
             dato non ancora  in questo intervallo
             memorizzato
```

E un vincolo sulla posizione di A: deve salire almeno T_R dopo l'ultimo cambiamento degli ingressi.

### Perché è un vincolo scomodo

- **La finestra dipende dai ritardi**, che variano con il circuito, la temperatura, il singolo esemplare. Un segnale di abilitazione tarato su un circuito può non andare bene su un altro.
- *Osservazione:* a rigore il vincolo superiore va calcolato sul **percorso più veloce** della rete combinatoria (è il primo a riportare un valore nuovo su D), il vincolo inferiore e il ritardo di attivazione sul **più lento**. Più la rete è sbilanciata, più la finestra si stringe; con percorsi molto rapidi (una rete quasi senza porte) può chiudersi del tutto.
- **La durata dell'impulso** diventa un parametro di progetto legato alla rete che il clock pilota, invece di essere una proprietà del solo segnale di sincronismo.

Lo stesso ragionamento spiega perché un registro a scorrimento non si fa con i latch: lì la "rete combinatoria" tra uno stadio e il successivo è un semplice filo, T_R è quasi nullo e la finestra praticamente non esiste. Il dato attraverserebbe più stadi in un colpo solo.

---

## 12. Come il flip-flop risolve il problema

L'idea è spostare la sensibilità **dal livello al fronte**. Un flip-flop cambia stato solo in corrispondenza della transizione dell'abilitazione, e **una volta sola per fronte**, qualunque sia la durata dell'impulso.

Rileggiamo la tabella della sezione 11 con un flip-flop edge-triggered sul fronte di salita:

| Istante | Latch D | Flip-flop D |
|---|---|---|
| A sale | diventa trasparente | campiona D **in quell'istante** |
| + T_F | Q = S1 | Q = S1 |
| + T_F + T_R | se A è alta, cattura S2 | **ignora** S2: il fronte è già passato |

L'anello di retroazione è interrotto: il nuovo stato prossimo calcolato dalla rete non può rientrare nella memoria prima del fronte successivo. Il vincolo sulla **durata** di A scompare. Resta solo il vincolo naturale che D sia stabile al momento del fronte.

*Osservazione:* il vincolo sulla durata dell'impulso diventa un vincolo sul **periodo** del clock. Tra un fronte e il successivo devono passare almeno T_F + T_R, cioè il tempo perché il nuovo stato esca dal flip-flop e la rete calcoli il successivo. È un vincolo molto più comodo: si risolve rallentando il clock, non tarando la larghezza di un impulso.

### Come fa il flip-flop a "vedere il fronte"

I lucidi mostrano un modo semplice di ottenere il comportamento edge-triggered: mettere in AND il segnale A con una sua copia ritardata e negata (passata per alcune porte NOT). Per un breve intervallo dopo il fronte di salita entrambi valgono 1, e si ottiene un impulso stretto.

*Osservazione:* questo trucco dice molto. Un flip-flop edge-triggered così costruito è, in sostanza, **un latch con un generatore di impulsi incorporato**. La finestra T_F < A < T_F + T_R del latch viene rispettata *per costruzione*, dentro il componente, invece di essere un problema di chi progetta la macchina.

Come macchina asincrona, il flip-flop D edge-triggered ha quattro stati: i due di memorizzazione più due stati intermedi (q01: "memorizzo 0 ma D è già 1, aspetto il fronte"; q10: il simmetrico). Sono gli stati in cui il flip-flop "si prepara" senza ancora cambiare uscita.

---

## 13. Perché il comportamento master-slave è il più desiderabile

Il flip-flop edge-triggered risolve il problema del latch, ma non è ancora ideale. I lucidi lo mostrano confrontando le tre varianti.

### I difetti degli edge-triggered

**Fronte di salita.** Lo stato cambia una sola volta, ma **cambia mentre A è ancora alta**. Se lo stesso segnale A è visto anche da altri dispositivi che non lavorano sul fronte di salita (un latch, un blocco sensibile al livello), questi vedono lo stato cambiare mentre sono abilitati. L'ideale sarebbe che A fosse già bassa quando lo stato cambia.

**Fronte di discesa.** Lo stato cambia quando A scende, cioè quando A è ormai bassa: il difetto precedente sparisce. Ma il campionamento avviene alla fine dell'impulso, quindi **l'ingresso deve restare stabile per tutto il tempo in cui A è alta**. E con esso gli ingressi della macchina sincrona che il flip-flop serve.

### Cosa fa il master-slave

Il master-slave **separa i due momenti**:

- **sul fronte di salita campiona** l'ingresso (il master lo cattura);
- **sul fronte di discesa lo presenta** in uscita (lo slave lo memorizza).

```
A:        ____/‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\____________/‾‾‾‾‾‾‾‾\____
              ^                ^
          campiona D       aggiorna Q
          (master)         (slave)
```

In questo modo si prende il meglio delle due versioni:

| Proprietà | Salita | Discesa | Master-slave |
|---|:---:|:---:|:---:|
| Una sola memorizzazione per impulso | sì | sì | sì |
| L'ingresso deve essere stabile solo al fronte di salita | sì | no, per tutta la fase alta | sì |
| Quando lo stato cambia, A è già bassa | no | sì | sì |

Il risultato è quello che i lucidi chiamano **comportamento ideale**: il dato viene memorizzato una sola volta e, dopo l'aggiornamento dello stato, l'abilitazione si presenta bassa. L'uscita è una versione traslata in avanti di quella del flip-flop sul fronte di salita.

### Perché questo conta in particolare per l'RS (e per il JK)

La proprietà è la stessa per D, RS e JK: dipende dal modo di tempificare, non dal tipo di ingresso. Nel caso dell'RS pesa di più per due motivi:

1. **L'RS abilitato eredita tutti i problemi del latch D.** I lucidi lo dicono esplicitamente: tutte le considerazioni fatte sul latch D in una macchina sincrona valgono anche per il bistabile RS abilitato. In una macchina sincrona R e S sono segnali di posizionamento calcolati dalla rete combinatoria **a partire dallo stato Q**: se Q cambia mentre il bistabile è sensibile, cambiano anche R e S, e si ricade nella doppia transizione.
2. **Nel master-slave l'uscita è ferma mentre si campiona.** Durante la fase alta di A lo slave non cambia, quindi Q è costante, quindi R e S (funzioni di Q e degli ingressi) sono stabili per tutto il tempo del campionamento. L'anello è aperto in modo pulito: si campiona con lo stato vecchio, si aggiorna quando nessuno sta campionando.

Il master-slave RS ha quattro stati interni che rendono visibile proprio questa separazione: q0c0, q0c1, q1c0, q1c1, cioè "valore memorizzato" più "valore campionato". Un dettaglio sottile dei lucidi: se l'abilitazione sale con RS = 00, qualcosa viene comunque campionato, cioè lo stato da cui si proviene. Il master copia sempre qualcosa, anche quando l'ordine è "mantieni".

*Osservazione:* per il JK (e quindi per il T) la separazione è ancora più preziosa. Con JK = 11 un bistabile sensibile al livello commuterebbe in continuazione finché A è alta, perché ogni nuova uscita riabilita la commutazione. Con il master-slave commuta esattamente una volta per impulso.

### Il costo

Il master-slave è molto più complesso da realizzare: si può ottenere mettendo in cascata un flip-flop sul fronte di salita (master) e uno sul fronte di discesa (slave), oppure due sul fronte di salita con un NOT sull'abilitazione dello slave (16 stati interni, non tutti raggiungibili). Per questo nei sistemi moderni, FPGA inclusi, i flip-flop disponibili sono edge-triggered.

*Osservazione:* in tecnologia CMOS il flip-flop edge-triggered è spesso realizzato proprio con due latch in cascata abilitati su fasi opposte del clock. L'idea master-slave non è sparita: è stata incorporata dentro il flip-flop "sul fronte". In VHDL scriverai `rising_edge(clk)` e il tool userà quel componente.

### Ricapitolando il percorso

```
latch D            una memorizzazione?  solo se A è tarata nella finestra T_F..T_F+T_R
flip-flop salita   una memorizzazione    ma lo stato cambia con A ancora alta
flip-flop discesa  una memorizzazione    ma l'ingresso deve restare fermo per tutto l'impulso
master-slave       una memorizzazione    ingresso stabile solo al fronte, stato cambia con A bassa
```

---

## 14. Macchine a sincronizzazione esterna, con esempi

### Il modello

Una macchina sincrona a sincronizzazione esterna è composta da:

- una **rete combinatoria** che, dagli ingressi L e dallo stato Q, calcola l'uscita e i **segnali di posizionamento P** dei flip-flop;
- una **memoria di stato R** fatta di flip-flop, uno per bit di stato;
- un **ingresso di sincronismo s esterno** che stabilisce *quando* la macchina commuta.

Tre scelte chiave:

- gli **ingressi L sono a livelli**: stabiliscono *verso quale* stato commutare, mentre il clock stabilisce *quando*;
- i **flip-flop sono edge-triggered**, perché la rete deve cambiare stato solo in corrispondenza del fronte del sincronismo;
- le **uscite** sono a livelli per Moore, impulsive per Mealy.

La separazione tra *cosa* (ingressi) e *quando* (clock) è la ragione per cui questo modello domina: chi progetta la rete combinatoria non deve più preoccuparsi di alee, corse e durate. Basta che la rete si sia assestata prima del fronte successivo.

### La procedura di progetto

1. **Dalla specifica all'automa.** Non c'è un algoritmo, ci sono linee guida: individua lo stato iniziale (quello in cui il passato non conta), scegli il modello più naturale (Mealy se l'uscita dipende dagli ingressi), verifica che da ogni stato esca un arco per ogni ingresso.
2. **Minimizzazione degli stati.** Stati con stessa uscita e stesso stato prossimo per ogni ingresso sono equivalenti e si fondono.
3. **Codifica degli stati.** Nel corso: codifica binaria minima sequenziale (5 stati → 3 bit, da 000 a 100). La codifica influenza sia il numero di flip-flop sia la complessità della rete.
4. **Scelta dei flip-flop.** Influisce sul costo della rete.
5. **Tabella delle eccitazioni.** Per ogni riga (ingresso, stato presente): stato prossimo, segnali di posizionamento ricavati dalle tabelle di eccitazione, uscita.
6. **Minimizzazione** di ogni colonna come funzione combinatoria, e disegno del circuito.

### Esempio 1 — Riconoscitore di 101 (lucido 12)

Ingresso seriale x, campionato sul fronte di clock; uscita alta quando gli ultimi tre bit sono 101. Automa di Mealy con tre stati:

| Stato | Significato | x = 0 | x = 1 |
|---|---|---|---|
| S0 | non ho riconosciuto niente | S0 / 0 | S1 / 0 |
| S1 | ho visto "1" | S2 / 0 | S1 / 0 |
| S2 | ho visto "10" | S0 / 0 | **S0 / 1** |

Si noti la scelta Mealy: l'uscita è sull'arco S2 → S0 con x = 1. In Moore servirebbe un quarto stato "ho visto 101".

### Esempio 2 — Riconoscitore di 1011 senza sovrapposizione (lucido 15, flip-flop D)

La macchina legge l'ingresso a **blocchi di 4 bit**: dopo ogni blocco torna allo stato iniziale, e l'uscita vale 1 solo se il blocco era 1011.

Il metodo dei lucidi è istruttivo: si parte da un albero completo (ogni stato ricorda tutti i bit letti finora) e lo si riduce fondendo stati equivalenti. Il risultato ha **7 stati**, organizzati in due "binari":

- il binario **buono**, che ha visto un prefisso corretto: *inizio*, "1", "10", "101";
- il binario **morto**, che ha già visto un bit sbagliato e deve solo contare i bit che mancano alla fine del blocco: ha sbagliato al 1°, 2° o 3° bit.

Con 7 stati servono 3 flip-flop; la configurazione 111 non esiste e diventa un don't care nella minimizzazione. Con i flip-flop D, i segnali di posizionamento coincidono con i bit dello stato prossimo, quindi la tabella delle eccitazioni è la tabella degli stati.

### Esempio 3 — Riconoscitore di 1011 con sovrapposizione (lucido 15, flip-flop JK)

Qui la sequenza non deve essere allineata ai multipli di 4: la macchina analizza **bit per bit**. Bastano 4 stati (S0 inizio, S1 "1", S2 "10", S3 "101") e quindi 2 flip-flop JK, cioè quattro reti da sintetizzare (J0, K0, J1, K1).

Due varianti, che differiscono **solo per la transizione da S3 con x = 1**:

- **sovrapposizione parziale**: dopo il riconoscimento si torna a S0. I bit della sequenza riconosciuta non vengono riusati;
- **sovrapposizione totale**: si va in S1, perché l'ultimo 1 è sia la fine di una sequenza sia l'inizio della successiva.

Sulla stessa sequenza d'ingresso dei lucidi:

```
bit        1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16
x          0  0  1  0  1  1  1  0  1  0  1  1  0  1  1  0

senza sovrapposizione:   y=1 al bit 12   (blocchi 0010 | 1110 | 1011 | 0110)
sovrapposizione parziale: y=1 ai bit 6, 12
sovrapposizione totale:   y=1 ai bit 6, 12, 15
```

Il bit 15 è riconosciuto solo nella variante totale perché la sequenza 1011 che termina lì (bit 12–15) condivide il bit 12 con quella precedente.

Perché qui i JK? Le loro tabelle di eccitazione sono piene di don't care, e le reti risultanti sono molto piccole (alcune si riducono a un solo letterale). Il confronto con l'esempio 2 mostra il peso della scelta del flip-flop sul costo della rete.

### Esempio 4 — Contatore sincrono mod-16 (lucido 16)

Nessun ingresso dato, solo il clock (più EN se presente). È il caso limite: tutta l'informazione sta nello stato. Con JK in modalità toggle si ottiene la regola della sezione 6: il bit i commuta quando tutti i bit meno significativi valgono 1. Tutti i flip-flop ricevono lo **stesso clock**: è sincronizzazione esterna in senso pieno.

Il contrasto con il **contatore seriale** è istruttivo. Lì solo il primo flip-flop riceve il clock esterno, gli altri sono pilotati dall'uscita del precedente. Formalmente sono ancora flip-flop, ma la macchina nel suo insieme non commuta tutta insieme: i ritardi si propagano lungo la catena e compaiono valori transitori sbagliati (3 → 2 → 0 → 4). È proprio quello che la sincronizzazione esterna voleva evitare.

### Esempio 5 — Registri e contatori per riduzione (lucido 16)

- **Registro a scorrimento**: ogni flip-flop campiona l'uscita del precedente sullo stesso fronte. Funziona perché ogni stadio legge il valore *vecchio* del precedente; con dei latch il dato scivolerebbe attraverso più stadi.
- **Contatore mod-11 da un mod-16 con reset sincrono**: il reset è un ingresso a livelli come gli altri, calcolato dalla rete (vale 1 quando il conteggio è 10) e applicato al fronte successivo. Un segnale di controllo sincrono si comporta esattamente come un ingresso della macchina a sincronizzazione esterna.

### Collegamento con il VHDL

Il modello a sincronizzazione esterna è esattamente quello che descriverai in VHDL:

- il `process` sensibile a `rising_edge(clk)` è la memoria di stato R;
- il `process` combinatorio (o le assegnazioni concorrenti) è la rete che calcola stato prossimo e uscita;
- `type state_t is (...)` è l'automa, e la codifica degli stati la sceglie il tool di sintesi.

Vedi la sezione sulle FSM in [vhdl.md](vhdl.md).

---

## 15. Riepilogo per il ripasso

**Sulle definizioni**

- Asincrona: ogni coppia (stato, ingresso) porta a uno stato stabile. Sincrona: almeno una no.
- Un ingresso di abilitazione non rende sincrona una macchina.
- Una macchina con soli ingressi a livelli funziona solo se è asincrona.
- Gli elementi di memoria sono macchine asincrone; ogni macchina sincrona ne contiene.

**Sulle macchine asincrone**

- Memoria = fili di retroazione + ritardi.
- Durata degli ingressi: d > k · (Ec + Δc + Δl).
- Un bit alla volta; attenzione ad alee (implicanti ridondanti) e corse (critiche e non critiche).

**Sul latch D in una macchina sincrona**

- A sale almeno T_R dopo la variazione degli ingressi.
- T_F < durata di A < T_F + T_R.
- Il limite superiore esiste perché il latch trasparente chiude l'anello di retroazione: con A troppo lunga, doppia transizione.

**Sui flip-flop**

- Sensibili al fronte: una transizione per impulso, qualunque sia la durata.
- Il vincolo sulla durata dell'impulso diventa un vincolo sul periodo del clock.
- Fronte di salita: stato che cambia con A alta. Fronte di discesa: ingresso fermo per tutta la fase alta.
- Master-slave: campiona in salita, presenta in discesa. Comportamento ideale, costo maggiore.

**Sul progetto**

- Specifica → automa → minimizzazione → codifica → flip-flop → eccitazioni → reti minime.
- D: progetto più semplice. JK: reti più piccole. T: contatori.
- Mealy se l'uscita dipende naturalmente dall'ingresso, Moore se serve un'uscita stabile.
