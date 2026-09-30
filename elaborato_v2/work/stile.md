# Guida di stile (ricavata da `riferimenti/elaborato_tony.pdf`)

Il documento modello è un elaborato di gruppo, molto pratico: poca teoria, listati integrali, spiegazioni brevi, figure poche e sobrie. Questa guida descrive cosa fa, non cosa "dovrebbe" fare un buon elaborato. Dove il template LaTeX offre un ambiente che il modello non ha, è indicato come usarlo senza tradire la struttura. Per le frasi: mai copiarle, solo riprendere lessico e ritmo.

## 1. Registro e voce

- Persona: prevalentemente impersonale/passiva ("viene utilizzato", "è stato scelto", "si riporta di seguito"). Il "noi" compare a tratti, soprattutto come invito alla lettura ("visioniamo", "presentiamo", "varieremo le sole selezioni"); la prima singolare compare raramente e in modo informale nei commenti ai test ("mi aspetto il valore ..."): da non imitare. Regola per l'elaborato: impersonale come base, "noi" espositivo ammesso per il raccordo ("vediamo il codice"), mai "io".
- Tempi: presente per descrivere ciò che il codice o la rete fa ("l'entità ha tre porte", "il process si attiva alla variazione di address"); passato prossimo per le scelte ("è stato scelto un periodo di 1 us"); futuro per rimandi ("verrà presentato nell'esercizio 7", "il sistema elaborerà il risultato per 30 ns").
- Formalità: medio-alta tecnica, scolastica, senza aggettivi valutativi né enfasi. Nessuna domanda retorica, nessun esclamativo (un solo "Rappresentazione in decimale!" da non riprendere).
- Frasi: di 20-30 parole in media, spesso con due incisi o elenchi in linea ("a(0), a(1), a(2) e a(3)"). Paragrafi di 3-6 righe; un paragrafo per componente o per idea.
- Prosa vs elenchi: prosa dominante. Elenchi numerati (1., 2., 3.) solo per: componenti del sistema (`Control Unit; ROM; Macchina M; Memoria; Contatore`), i tre casi di un algoritmo, i passi di un test, le microistruzioni, la spiegazione di segnali (TBE, RDA, PE...). Elenchi puntati per passi di verifica. Mai elenchi per sostituire una spiegazione discorsiva.
- Lunghezza: consegna e commento sono brevi rispetto al codice; il testo spiega il "cosa" a livello di blocco, non ogni riga.

## 2. Struttura di un esercizio

Ogni esercizio è una sezione numerata (N.M) con il titolo dell'esercizio. Sequenza fissa, con titoli in grassetto corsivo/piccoli, non numerati (nel template: `\progetto`, `\implementazione`, `\simulazione`, `\sintesiboard`, `\timinganalysis`):

| Ordine | Parte | Titolo usato | Contenuto tipico | Lunghezza |
|---|---|---|---|---|
| 1 | Consegna | nessun titolo, paragrafo subito sotto l'intestazione | testo della traccia riformulato quasi identico | 2-5 righe (nell'elaborato: ambiente `traccia`) |
| 2 | Progetto | "Progetto e Architettura" (`\progetto`) | scelta architetturale, componenti, cenno sul comportamento, schema a blocchi con frase di richiamo | 1-3 paragrafi (5-12 righe) + figura |
| 3 | Implementazione | "Implementazione" (`\implementazione`) | per ciascun componente: 2-5 righe di descrizione dell'entità (porte, larghezza) e dell'architettura (stile, costrutto principale), poi il listato integrale; componenti in ordine bottom-up e top module per ultimo | 1 paragrafo + listato per componente |
| 4 | Simulazione | "Simulazione" (`\simulazione`) | il testbench (listato) e il suo commento, poi forma d'onda e lettura di uno o due casi | 1 paragrafo + listato + figura + 2-5 righe |
| 5 | Board (solo sottopunti "su board") | "Sintesi su board di sviluppo" (`\sintesiboard`) | descrizione dell'uso, foto della scheda, poi "Nel file dei constraint sono state decommentate le seguenti righe" + listato .xdc | 1-2 paragrafi + figura + listato |
| 6 | Timing (solo 6.3) | "Timing Analysis" come sezione a sé (`\timinganalysis`) | definizione (slack, WNS, FMAX), tentativi successivi, formula | vedi sotto |

Varianti:
- Combinatorio (1.x, 2.x): Progetto più corto, spesso una sola frase + schema; Simulazione con un solo caso spiegato (valore di controllo, valore atteso, uscita).
- FSM (3.x, 8.1, 10.1): il diagramma degli stati/automa sta in Progetto (8, 10, 12) oppure subito dopo il listato del riconoscitore (3.1), con una nota di lettura (colori dei sottografi = modi). Elenco delle uscite/ingressi della FSM a parole.
- Sequenziale/strutturale (4.1, 5.1): sottosezioni per approccio (comportamentale/strutturale); schema con MUX e FF; commento sul testbench come elenco di passi.
- PO/PC e aritmetica (6.1, 7.1): elenco dei componenti, schema PO/PC, un paragrafo e un listato per ciascun componente, top module, testbench.
- Board (x.2): Progetto e Implementazione ridotti a "cosa si aggiunge" rispetto al punto precedente (debouncer, input manager, display); nessuna ripetizione dell'esercizio base ("Per completezza si ripresenta" è ammesso solo quando serve).
- Timing (6.3): definizione teorica in 1 paragrafo; poi ciclo ripetuto: listato `create_clock` (con periodo diverso) → immagine del riepilogo → una frase ("Abbiamo un valore negativo, continuiamo"); chiusura con periodo ottimale e formula FMAX = 1/(T - WNS) con sostituzione numerica.
- Prova d'esame (12.1): consegna a punti (1-4); sottosezioni "Punto numero N" che seguono i punti della traccia; ogni punto ha figura + poche righe; il punto 4 ha listati, simulazione e figura finale.
- Processore (9.1): "PUNTO A / PUNTO B"; per ogni istruzione: descrizione a parole, listato microcodice, elenco numerato delle microistruzioni.
- Appendice: un titolo per componente, una riga di contesto ("verrà usato nell'esercizio 7"), listato, nient'altro.

Nell'elaborato: il titolo di ogni esercizio è `\esSezione`, le parti interne (Progetto, Implementazione...) si ottengono con i comandi standard `\progetto` ecc., non con `\esSottosezione`, che si riserva ai sottopunti del modello (4.1.1, 4.1.2: comportamentale/strutturale) o alle sezioni "Punto numero N".

## 3. Mappa delle figure

Sono presenti soltanto: schemi a blocchi, diagrammi di stati, forme d'onda, foto della scheda, screenshot del riepilogo di timing, un'immagine di codice (una volta). Il modello non contiene: schematici RTL/sintesi, tabelle di utilizzo, tabelle di verità, mappe di Karnaugh. Se l'elaborato ha quei materiali (dai progetti Vivado), vanno trattati come schemi/screenshot con lo stesso stile.

| Tipo immagine | Parte dell'esercizio | Cosa la introduce nel testo | Cosa segue |
|---|---|---|---|
| Schema a blocchi / architettura | in Progetto, dopo il paragrafo che spiega la composizione | frase con rimando: "lo schema è visibile in figura X" oppure "la figura seguente illustra l'architettura"; a volte senza rimando, solo un titolo di paragrafo | spiegazione a parole di chi collega cosa (ruoli di MUX, contatori) o passaggio a Implementazione |
| FSM / stati | in Progetto (esercizi con handshake, UART, prova) o dopo il listato (3.1) | "le unità di controllo sono descritte dalle FSM nelle figure X e Y" | nota di lettura (colori, stati); nessuna tabella delle transizioni |
| Forme d'onda (`simulazione`) | in Simulazione, dopo il testbench e il suo commento | "il risultato della simulazione è il seguente" oppure "nell'immagine riportata in figura X" | 2-5 righe che leggono UN caso: valore di controllo/ingresso (dec, bin, hex), valore atteso, uscita osservata; talvolta elenco dei passi di test |
| Foto della scheda (`scheda`) | in Sintesi su board | "ad esempio:" o "nella figura X viene illustrato l'output in funzione dell'input ..." | commento sui LED/display accesi; poi frase e listato dei constraint |
| Sottofigure a/b (due foto affiancate) | in Sintesi su board | "ad esempio:" | didascalie (a) Valore 0100 (b) Valore 0110 + didascalia generale |
| Screenshot timing (`timing`) | in Timing Analysis, uno per tentativo | dopo il listato `create_clock` del tentativo | commento sul WNS (positivo/negativo, vincoli soddisfatti o no) |
| Schema DMUX/switch elementare | in Implementazione del componente | "ha un'architettura ben precisa, presentata in figura X" | listato del componente |
| Tabella di verità / logica | assenti nel modello | — | usare eventualmente elenco puntato o tabella breve |
| `rtl`, `sintesi`, `utilizzo` | assenti nel modello | — | se presenti nel progetto, inserirli in Implementazione/Sintesi con didascalia breve e una riga di lettura |

- Larghezza tipica: schemi 50-70% della larghezza testo; forme d'onda 80-100%; foto scheda a piena larghezza (o due sottofigure da ~45% ciascuna); screenshot timing 70-90%.
- Numerazione: "Figura capitolo.progressivo", sempre sotto l'immagine, centrata, corpo piccolo.
- Didascalia: breve, nominale, senza punto finale ("Simulazione MUX 16:1", "Architettura del Cronometro", "FSM dell'unità A", "LED su Board", "Timing Analysis numero 2"); mai frasi lunghe. Non descrive il contenuto: lo fa il testo.
- Richiamo nel testo: quasi sempre con "figura N.M" (in minuscolo) prima dell'immagine; ogni figura è citata almeno una volta. Nell'elaborato: `\ref{fig:...}` e ambiente `figure[H]` con `\includegraphics[width=...]{figure/<slug>/<file>}`, `\caption{}` e `\label{fig:<slug>:<nome>}`. NON usare `\screenshot` del template: cerca i file in `figure/screenshot/`, che non è la convenzione dell'elaborato (correzione dell'orchestratore).
- Una figura non sta mai da sola tra due listati senza frase che la introduce.

## 4. Codice

- Listato integrale di ogni componente (nessun estratto parziale, salvo il testbench lunghissimo) con numerazione di riga; titolo del listato sopra ("Listing 1.1: Implementazione MUX 4:1"); nell'elaborato: `\vhdlfile{<slug>/<file>.vhd}{didascalia}{lst:<slug>:<nome>}` con la didascalia nel formato "Implementazione X"/"Testbench X"/"Constraint".
- Posizione: prima la frase di presentazione ("il codice seguente implementa ..."), poi il listato, poi (spesso) i paragrafi che spiegano ciò che è appena stato mostrato ("Nel blocco architetturale è dichiarato un segnale ..."). Le due disposizioni convivono; regola: presentazione breve prima, spiegazione per blocchi dopo.
- Spiegazione: per blocchi logici, mai riga per riga. Ordine: entità (porte con larghezza e ruolo) → architettura (stile: dataflow/behavioral/structural, costrutto usato: `with select`, process con sensitivity list, `port map`) → segnali interni → comportamento nei casi limite (selezione non valida, reset).
- Commenti nel codice: scarsi o assenti; il funzionamento su board è spiegato in un commento all'inizio del top module e il testo rimanda ("il funzionamento è descritto nei commenti del codice").
- I listati dei componenti già mostrati non si ripetono: si rimanda ("come nell'esercizio 2", "in appendice"). Le ripetizioni sono dichiarate ("per completezza, si ripresenta").
- Constraint: listato .xdc dopo il commento della board, introdotto dalla formula fissa "nel file dei constraint sono state decommentate le seguenti righe".

## 5. Simulazione e verifica

- Il testbench si presenta con il listato e un paragrafo che ne spiega la struttura: entità senza porte perché non istanziabile, istanza `uut` (Unit Under Test), `stim_proc` che genera gli ingressi con ciclo `for`, `wait for` tra i test, `assert ... report ... severity failure` per il controllo automatico, `wait;` finale per terminare.
- Il commento alle forme d'onda descrive UN caso campione con valori espliciti: ingresso in esadecimale e binario tra parentesi, selezione, uscita attesa e osservata ("il valore di control è 6 (0110): l'uscita è input[6], ossia 0"). Per gli esempi con più passi si usa un elenco: caricamento di x"6F5D", shift a destra → B7AE, shift a sinistra, ecc.
- Se la simulazione è modificata per velocità (periodo del clock diviso di 1 us invece di 1 s), lo si dichiara subito prima della figura.
- Si spiega un fenomeno temporale non ovvio (uscita che cambia insieme all'ingresso perché il fronte del clock è lo stesso) con un paragrafo dopo la figura.
- Nessuna tabella di verifica, nessuna tabella di casi: solo testo/elenco. Nessun cronogramma disegnato a mano.
- Timing: non si commentano cifre non mostrate dal report; si riporta WNS/periodo e la formula FMAX.

## 6. Formule, tabelle, notazione

- Tabelle: assenti nel modello. Tabelle di verità e mappe di Karnaugh non compaiono mai. Se servono si usano `booktabs` compatte (template) ma senza abbondare.
- Equazioni: pochissime, in linea ("FMAX = 1/(T - WNS) = 1/(4 - 0,269) = 1/3,731"); virgola come separatore decimale. Nell'elaborato: `\SI{}{}` per unità.
- Segnali e nomi nel testo: monospaziato (nome di entità, porta, segnale, file); nomi con underscore resi in testo; entità citate col nome del codice ("l'entità mux4_1").
- Valori: bit singoli tra apici (`'1'`, `'-'`), vettori tra virgolette ("0110", "1010"), esadecimali come 0xBD oppure x"6F5D", con l'equivalente binario tra parentesi; pedici per la base (0110 con 2 a pedice; 28 con 10 a pedice) - resa nell'elaborato con `$0110_2$`, `$28_{10}$`.
- Numeri di riga citati tra parentesi solo quando serve; non si fa riferimento al numero di riga del listato per spiegare.
- Sigle: PO/PC, CU, FSM, WNS, FMAX, LUT scritte in maiuscolo, espanse alla prima occorrenza (Worst Negative Slack).

## 7. Lessico ricorrente

Termini preferiti (ripresi spesso): "progettare, implementare in VHDL e testare mediante simulazione" (formula della traccia); "sintetizzare ed implementare su board"; "Progetto e Architettura"; "Implementazione"; "Simulazione"; "Sintesi su board di sviluppo"; "top module" (mai "modulo principale"); "unità di controllo"/"Control Unit"/"CU"; "macchina combinatoria M"; "parte operativa / parte di controllo"; "componente" per le entità istanziate; "istanziare", "port mapping", "process", "testbench" (senza trattino, in inglese), "generic", "sensitivity list", "clock", "reset", "fronte di salita/discesa", "segnale", "uscita/ingresso", "board", "constraint", "debouncer", "wait", "handshaking", "tempificazione" (dal linguaggio del corso), "approccio comportamentale/strutturale", "architettura dataflow/behavioral/structural".
Raccordi tipici: "Di seguito", "Si riporta di seguito", "Il codice è il seguente", "Visioniamo", "Presentato/a X, occorre presentare Y", "Definita tale entità", "In conclusione", "Per completezza", "Nello specifico", "in particolare", "difatti", "Infine", "Successivamente", "A differenza di ...".
Traduzioni: si tengono in inglese process, testbench, top module, clock, reset, load, enable, debouncer, generic, wait, assert; si traducono segnale, uscita, ingresso, registro, contatore, memoria, moltiplicatore, sommatore, forme d'onda (nel modello si dice "simulazione" per l'immagine).
Cose che il documento non fa mai: note a piè di pagina; bibliografia; confronti tra soluzioni alternative o considerazioni di area/consumo; citazioni; metafore; tabelle; equazioni sviluppate; riassunti a fine capitolo; ringraziamenti; grafici di risorse (LUT/FF); commenti su limiti/difetti dell'implementazione (salvo la "NOTA" su un componente rimandato).

## 8. Introduzioni e conclusioni

- Parti e capitoli: nessuna introduzione discorsiva; il titolo di Parte è una pagina a sé; il capitolo si apre subito con il primo esercizio. Non c'è introduzione generale al corso: sull'elaborato provvede il template.
- Esercizi: l'esercizio non ha paragrafo conclusivo. Si chiude con il commento all'ultima figura o con il listato dei constraint (esercizi su board). Se serve una NOTA (es. rimando ad altro esercizio, significato di segnali) è in coda alla parte, con l'etichetta "NOTA" in maiuscolo. Nell'elaborato: usare `osservazione` per questi casi (max una per esercizio), `attenzione` solo se c'è un vero limite, `risultato` per l'esito verificato di simulazione/board (una riga con i valori mostrati dalla figura), `scelta` per le scelte progettuali dichiarate ("è stato scelto di...") quando l'esercizio ne ha una decisiva (max una per esercizio).
- Nessun confronto con altri esercizi, tranne rimandi (es. "seguendo l'implementazione dell'esercizio 2").
- L'appendice raccoglie i componenti riutilizzati, e dal testo si rimanda ad essa.

## 9. Checklist per il revisore (sì/no)

1. L'esercizio segue la sequenza consegna → Progetto e architettura → Implementazione → Simulazione (→ Sintesi su board → constraint), senza parti inventate in più (nessuna "Conclusioni")?
2. La consegna sta subito sotto il titolo, parafrasata, ed è di 2-5 righe?
3. La voce è impersonale (con "noi" solo come raccordo), mai prima persona singolare, senza enfasi né aggettivi valutativi?
4. Ogni componente ha una presentazione di 2-5 righe (porte con larghezza, stile dell'architettura, costrutto principale) prima o dopo il listato integrale?
5. La spiegazione del codice è per blocchi, senza commento riga per riga e senza numeri di riga?
6. Ogni figura ha didascalia breve senza punto finale, è richiamata nel testo prima di comparire ed è seguita da una lettura di un caso concreto?
7. Le forme d'onda sono lette con almeno un caso con valori espliciti (bin/hex/decimale), e i valori corrispondono all'immagine?
8. Nomi di segnali/entità/file sono in monospaziato, i valori con la notazione del modello (`'1'`, `"0110"`, 0xBD, pedici di base)?
9. Il lessico è quello del modello (top module, testbench, process, port mapping, unità di controllo, "Visioniamo", "Di seguito"), con le parole inglesi non tradotte?
10. Ci sono solo elementi presenti nel modello (niente tabelle di risorse o confronti di area/frequenza non forniti dal progetto), e ogni cifra è mostrata da un'immagine o da un report?
11. Le sezioni su board terminano con foto/descrizione dell'uso e il listato dei constraint introdotto dalla formula tipica?
12. I componenti già presentati non sono ripetuti, ma richiamati con un rimando?
