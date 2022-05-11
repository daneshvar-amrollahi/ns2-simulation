# ns2-simulation

In this project, we simulate a simple network topology of 9 nodes using *NS2*.
The experiments are carried out with three different bandwidths. Also, the tracefiles are analyzed using Python scripts to calculate and plot **end-to-end delays**, **throughputs**, and **packet delivery ratios**. 

Project structure:
```
.
├── Documentation
│   ├── CA#2-Report.pdf
│   ├── Description.pdf
│   └── plots
│       ├── E2E-Delay
│       │   ├── 155-0-7.png
│       │   ├── 155-2-8.png
│       │   ├── 1p5-0-7.png
│       │   ├── 1p5-2-8.png
│       │   ├── 55-0-7.png
│       │   └── 55-2-8.png
│       └── Throughput
│           ├── 155-7.png
│           ├── 155-8.png
│           ├── 1p5-7.png
│           ├── 1p5-8.png
│           ├── 55-7.png
│           └── 55-8.png
├── README.md
├── Sample
│   ├── wired
│   │   ├── namout.nam
│   │   ├── test.tcl
│   │   └── trout.tr
│   └── wireless
│       ├── test.tcl
│       ├── wireless.nam
│       └── wireless.tr
└── Scripts
    ├── 155mbps
    │   ├── script.tcl
    │   ├── wireless.nam
    │   └── wireless.tr
    ├── 1p5mbps
    │   ├── script.tcl
    │   ├── wireless.nam
    │   └── wireless.tr
    ├── 55mbps
    │   ├── script.tcl
    │   ├── wireless.nam
    │   └── wireless.tr
    ├── e2edelay-plot.ipynb
    ├── e2edelay.py
    ├── throughput-plot.ipynb
    ├── throughput.py
    └── transfer_ratio.py
```