# ASDI

ASDI exam support repository

## Struttura della repository

```
ASDI/
├── elaborato_v2/                    # elaborato LaTeX
│   ├── latex/                       # sorgenti del documento
│   ├── out/                         # PDF compilato e log di build
│   └── vivado/                      # un progetto/esercizio per sottocartella
├── pics/                            # immagini usate nella documentazione
├── NEXYS_A7.md                      # guida alla scheda Nexys A7 e a Vivado
├── vhdl.md                          # introduzione al VHDL (lezione 1)
├── macchine_sequenziali.md          # guida alle macchine sequenziali (lucidi 12-17)
├── plan.md                          # piano di preparazione dell'elaborato
├── clean.ps1                        # pulizia ricorsiva dei file temporanei LaTeX
├── .gitignore
└── README.md
```

- **[elaborato_v2/](elaborato_v2/)** → elaborato LaTeX da presentare all'esame. Il PDF finale è in `out/elaborato.pdf`
- **[plan.md](plan.md)** → piano di preparazione: spiegazione di ogni traccia, difficoltà, checklist teoriche e tracker di avanzamento
- **[NEXYS_A7.md](NEXYS_A7.md)** → guida completa alla Digilent Nexys A7: teoria FPGA, hardware, Vivado 2023.1, vincoli XDC ed esempi di integrazione dei circuiti del corso
- **[vhdl.md](vhdl.md)** → introduzione al VHDL: sintassi, costrutti, esempi, trappole classiche
- **[macchine_sequenziali.md](macchine_sequenziali.md)** → guida di studio sulle macchine sequenziali, sincrone e asincrone
