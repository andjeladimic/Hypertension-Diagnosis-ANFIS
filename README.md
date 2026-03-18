# Hypertension Risk Diagnosis using ANFIS

A soft computing project for estimating the **risk of hypertension** using an **ANFIS (Adaptive Neuro-Fuzzy Inference System)** model trained on synthetic patient data, implemented entirely in **MATLAB**. The project includes model training, evaluation, surface visualization, and an interactive GUI application built with MATLAB App Designer.

---

## Table of Contents

- [Overview](#overview)
- [What is ANFIS?](#what-is-anfis)
- [Dataset](#dataset)
- [Model Architecture](#model-architecture)
- [Project Structure](#project-structure)
- [Results & Visualizations](#results--visualizations)
- [Tools & Technologies](#tools--technologies)
- [How to Run](#how-to-run)

---

## Overview

Hypertension (high blood pressure) is one of the most common chronic conditions and a leading risk factor for cardiovascular disease. This project builds an intelligent diagnostic system that takes four key patient parameters — systolic blood pressure (SBP), diastolic blood pressure (DBP), age, and BMI — and outputs a continuous **hypertension risk score** between 0 and 1.

The ANFIS model is trained on 1000 synthetically generated patient records, using subtractive clustering to automatically generate the initial fuzzy rule base.

---

## What is ANFIS?

**ANFIS (Adaptive Neuro-Fuzzy Inference System)** is a hybrid model that integrates:

- **Fuzzy Logic** — represents medical knowledge through linguistic rules and Gaussian membership functions (e.g., *"if blood pressure is high and age is old, then risk is high"*)
- **Neural Networks** — learns and optimizes fuzzy membership function parameters and rule consequents from training data

This combination makes ANFIS especially well-suited for medical diagnosis, where both data-driven learning and interpretable rules are needed.

---

## Dataset

The dataset consists of **1000 synthetically generated patient records** created directly in MATLAB.

### Input Features

| Feature | Range | Description |
|---|---|---|
| **SBP** | 90 – 200 mmHg | Systolic blood pressure |
| **DBP** | 60 – 120 mmHg | Diastolic blood pressure |
| **Age** | 18 – 90 years | Patient age |
| **BMI** | 15 – 45 kg/m² | Body mass index |

All inputs are normalized to [0, 1] using min-max scaling before being fed to the model.

### Output

| Output | Range | Description |
|---|---|---|
| **Risk** | 0 – 1 | Hypertension risk score (sigmoid-transformed) |

### Risk Formula

The ground-truth risk is computed as a weighted linear combination of normalized parameters, passed through a sigmoid function:

```
risk_linear = 0.4·SBP_norm + 0.3·DBP_norm + 0.2·BMI_norm + 0.1·Age_norm
risk = 1 / (1 + exp(-5 · risk_linear))
```

SBP has the highest weight (0.4), reflecting its dominant role in hypertension diagnosis.

### Train/Test Split

- **Training set:** 80% (800 samples)
- **Checking set:** 20% (200 samples)

---

## Model Architecture

The ANFIS model uses a **Sugeno-type** fuzzy inference system generated via **subtractive clustering** (`genfis2`) with a cluster influence radius of 0.5.

| Parameter | Value |
|---|---|
| FIS type | Sugeno |
| Number of inputs | 4 (SBP, DBP, Age, BMI) |
| Number of outputs | 1 (risk score) |
| Number of rules | 9 |
| Membership function type | Gaussian (`gaussmf`) |
| MFs per input | 9 |
| Output MF type | Linear |
| Training epochs | 50 |
| And method | Product |
| Defuzzification | Weighted average |

---

## Project Structure

```
Hypertension-Diagnosis-ANFIS/
│
├── hipertenzija_anfis_model.m          # Main script: data generation, training, evaluation
├── AnfisModel_Hipertenzija.fis         # Saved trained ANFIS model
├── hipertenzija_app_designer.mlapp     # MATLAB App Designer GUI for interactive diagnosis
└── Projektni zadatak - Medicinska dijagnostika.pdf   # Full project report (Serbian)
```

### File Descriptions

| File | Description |
|---|---|
| `hipertenzija_anfis_model.m` | Generates synthetic data, normalizes inputs, trains ANFIS via `genfis2` + `anfis`, plots training error and predictions, saves the `.fis` model, and generates a 3D surface plot of SBP vs DBP effect on risk |
| `AnfisModel_Hipertenzija.fis` | Pre-trained Sugeno FIS with 9 Gaussian MFs per input and 9 linear output rules — load directly with `readfis()` |
| `hipertenzija_app_designer.mlapp` | Interactive GUI — enter patient values (SBP, DBP, Age, BMI) and get an instant risk score |
| `Projektni zadatak - Medicinska dijagnostika.pdf` | Full project documentation |

---

## Results & Visualizations

The training script produces three plots:

**1. Training Error Curve** — MSE on training and checking sets across 50 epochs, showing model convergence.

**2. Actual vs Predicted Values** — Comparison of true and ANFIS-predicted risk scores on the checking set.

**3. 3D Surface Plot** — Visualization of the model's output surface as a function of SBP and DBP (Age fixed at 50, BMI fixed at 25), showing how the two blood pressure parameters jointly influence the risk score.

---

## Tools & Technologies

- **MATLAB** with the following toolboxes:
  - **Fuzzy Logic Toolbox** — `genfis2`, `anfis`, `evalfis`, `writeFIS`, `readfis`
  - **App Designer** — for the interactive GUI (`.mlapp`)

> **Note:** A valid MATLAB license with the **Fuzzy Logic Toolbox** is required to run this project.

---

## How to Run

### Training the Model from Scratch

1. Open MATLAB and navigate to the project folder.
2. Run the main script:
   ```matlab
   run('hipertenzija_anfis_model.m')
   ```
   This will generate a new synthetic dataset, train the ANFIS model for 50 epochs, display the three result plots, and save `AnfisModel_Hipertenzija.fis`.

### Using the Pre-trained Model

Load and evaluate the saved model directly:
```matlab
fis = readfis('AnfisModel_Hipertenzija.fis');

% Input: [SBP_scaled, DBP_scaled, Age_scaled, BMI_scaled]
% Scale your inputs to [0,1] using:
% min_vals = [90, 60, 18, 15]; max_vals = [200, 120, 90, 45];
input_scaled = ([150, 95, 55, 28] - [90, 60, 18, 15]) ./ ([200, 120, 90, 45] - [90, 60, 18, 15]);

risk = evalfis(fis, input_scaled);
fprintf('Hypertension risk: %.2f\n', risk);
```

### Running the GUI Application

1. Open `hipertenzija_app_designer.mlapp` in MATLAB:
   - Double-click the file in the MATLAB browser, or run `open('hipertenzija_app_designer.mlapp')`
2. Click **Run** in App Designer to launch the interface.
3. Enter patient values and get an instant risk score.

---

## Documentation

📄 A full project report covering methodology, results, and analysis is available here:

[Projektni zadatak - Medicinska dijagnostika.pdf](./Projektni%20zadatak%20-%20Medicinska%20dijagnostika.pdf)

---

## Author

**Anđela Dimić**
