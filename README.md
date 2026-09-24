# ASDI

ASDI exam support repository

## Struttura della repository

```
ASDI/
├── elaborato/                      # documento LaTeX da presentare all'esame
│   ├── traccia/                    # tracce degli esercizi e template dell'elaborato
│   ├── main.tex
│   └── structure.tex
├── esercitazioni/                  # esercitazioni tenute durante il corso
│   ├── contatore_modulo16_seriale/
│   ├── full_adder/
│   ├── lab01_mux/
│   ├── lab02/
│   ├── RCA/
│   ├── sim/
│   └── src/
├── pics/                           # immagini usate nella documentazione
├── NEXYS_A7.md                     # guida alla scheda Nexys A7 e a Vivado
├── plan.md                         # piano di preparazione dell'elaborato
├── clean.ps1                       # pulizia ricorsiva dei file temporanei LaTeX
├── .gitignore
└── README.md
```

- **elaborato** → documento LaTeX da presentare all'esame
- **esercitazioni** → esercitazioni tenute durante il corso
- **[plan.md](plan.md)** → piano di preparazione: spiegazione di ogni traccia, difficoltà, checklist teoriche e tracker di avanzamento
- **[NEXYS_A7.md](NEXYS_A7.md)** → guida completa alla Digilent Nexys A7: teoria FPGA, hardware, Vivado 2023.1, vincoli XDC ed esempi di integrazione dei circuiti del corso
