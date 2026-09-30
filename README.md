# ASDI

ASDI exam support repository

## Struttura della repository

```
ASDI/
├── elaborato_v2/                    # elaborato LaTeX: orchestratore + subagenti Claude Code
│   ├── .claude/                     # agenti e comandi del progetto
│   ├── CLAUDE.md                    # istruzioni e invarianti per gli agenti
│   ├── latex/                       # sorgenti del documento (main.tex, capitoli/, codice/, ...)
│   ├── out/                         # PDF compilato e log di build
│   ├── prompt.md                    # compito dell'orchestratore
│   ├── riferimenti/                 # elaborati modello (stile, struttura)
│   ├── vivado/                      # un progetto/esercizio per sottocartella
│   └── work/                        # scratchpad: stato, piano, inventario, estratti
├── pics/                            # immagini usate nella documentazione
├── references/                      # elaborati modello (copia di riferimento)
├── NEXYS_A7.md                      # guida alla scheda Nexys A7 e a Vivado
├── vhdl.md                          # introduzione al VHDL (lezione 1)
├── macchine_sequenziali.md          # guida alle macchine sequenziali (lucidi 12-17)
├── plan.md                          # piano di preparazione dell'elaborato
├── clean.ps1                        # pulizia ricorsiva dei file temporanei LaTeX
├── .gitignore
└── README.md
```

- **[elaborato_v2/](elaborato_v2/)** → elaborato LaTeX da presentare all'esame, prodotto da un orchestratore Claude Code con subagenti dedicati (uno per esercizio); il PDF finale è in `out/elaborato.pdf`
- **[plan.md](plan.md)** → piano di preparazione: spiegazione di ogni traccia, difficoltà, checklist teoriche e tracker di avanzamento
- **[NEXYS_A7.md](NEXYS_A7.md)** → guida completa alla Digilent Nexys A7: teoria FPGA, hardware, Vivado 2023.1, vincoli XDC ed esempi di integrazione dei circuiti del corso
- **[vhdl.md](vhdl.md)** → introduzione al VHDL: sintassi, costrutti, esempi, trappole classiche
- **[macchine_sequenziali.md](macchine_sequenziali.md)** → guida di studio sulle macchine sequenziali, sincrone e asincrone
