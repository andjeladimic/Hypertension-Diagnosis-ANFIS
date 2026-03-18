# Hypertension Diagnosis using ANFIS

A soft computing project for medical diagnosis of hypertension using an **ANFIS (Adaptive Neuro-Fuzzy Inference System)** model, implemented in **MATLAB**. The project combines the learning capabilities of neural networks with the interpretability of fuzzy logic to build a system capable of diagnosing hypertension based on patient data.

---

## Table of Contents

- [Overview](#overview)
- [What is ANFIS?](#what-is-anfis)
- [Project Structure](#project-structure)
- [Tools & Technologies](#tools--technologies)
- [How to Run](#how-to-run)
- [Documentation](#documentation)

---

## Overview

Hypertension (high blood pressure) is one of the most prevalent chronic conditions worldwide and a major risk factor for cardiovascular disease. Early and accurate diagnosis is critical for timely treatment.

This project applies **soft computing** techniques — specifically ANFIS — to build an intelligent diagnostic system. The system learns from patient data and uses fuzzy rules to produce interpretable diagnostic outputs, bridging the gap between black-box neural networks and transparent rule-based expert systems.

A **MATLAB App Designer GUI** is also included, providing a user-friendly interface for entering patient parameters and obtaining a real-time diagnosis.

---

## What is ANFIS?

**ANFIS (Adaptive Neuro-Fuzzy Inference System)** is a hybrid intelligent model that integrates:

- **Fuzzy Logic** — handles uncertainty and imprecision in medical data through linguistic rules (e.g., *"if blood pressure is high and age is old, then risk is elevated"*)
- **Neural Networks** — automatically learns and optimizes the fuzzy membership functions and rule parameters from training data

This makes ANFIS especially well-suited for medical diagnosis, where both data-driven learning and human-interpretable rules are valuable.

---

## Project Structure

```
Hypertension-Diagnosis-ANFIS/
│
├── hipertenzija_anfis_model.m          # Main MATLAB script — ANFIS model training & evaluation
├── AnfisModel_Hipertenzija.fis         # Trained ANFIS model (fuzzy inference system)
├── hipertenzija_app_designer.mlapp     # MATLAB App Designer GUI for interactive diagnosis
└── Projektni zadatak - Medicinska dijagnostika.pdf   # Full project report (in Serbian)
```

### File Descriptions

| File | Description |
|---|---|
| `hipertenzija_anfis_model.m` | Loads data, trains the ANFIS model, evaluates performance, and saves the `.fis` file |
| `AnfisModel_Hipertenzija.fis` | The trained fuzzy inference system — can be loaded directly into MATLAB |
| `hipertenzija_app_designer.mlapp` | Interactive GUI app — enter patient data and get an instant diagnosis |
| `Projektni zadatak - Medicinska dijagnostika.pdf` | Detailed project documentation covering methodology and results |

---

## Tools & Technologies

- **MATLAB** — primary development environment
  - Fuzzy Logic Toolbox — for building and training the ANFIS model
  - App Designer — for the graphical user interface
- **ANFIS** — adaptive neuro-fuzzy inference system

> **Note:** A valid MATLAB license with the **Fuzzy Logic Toolbox** is required to run this project.

---

## How to Run

### Running the ANFIS Model

1. Open MATLAB and navigate to the project directory.
2. Open and run `hipertenzija_anfis_model.m`:
   ```matlab
   run('hipertenzija_anfis_model.m')
   ```
   This will train the model (or load the pre-trained `.fis` file) and display evaluation results.

### Running the GUI Application

1. In MATLAB, open `hipertenzija_app_designer.mlapp`:
   - Double-click the file in the MATLAB file browser, or
   - Run: `open('hipertenzija_app_designer.mlapp')`
2. Click **Run** in App Designer to launch the interface.
3. Enter patient parameters and click the diagnosis button to get a result.

### Loading the Pre-trained Model Directly

```matlab
fis = readfis('AnfisModel_Hipertenzija.fis');
output = evalfis(fis, inputData);
```

---

## Documentation

A full project report (in Serbian) covering the problem background, ANFIS methodology, model design, and results is available here:

[Projektni zadatak - Medicinska dijagnostika.pdf](./Projektni%20zadatak%20-%20Medicinska%20dijagnostika.pdf)

---

## Author

**Anđela Dimić**
