# 🧬 RNA Expression Analysis (v1.0)

This project provides a basic R script for **simulated RNA expression analysis**, including differential expression testing and visualization using base R functions.  
It serves as a simple example for beginners learning how to perform RNA-seq–like data analysis without requiring specialized libraries.

---

## 📘 Overview

This first version focuses on:
- Simulating RNA expression count data for a small set of genes  
- Calculating fold change and log2 fold change between control and treatment groups  
- Performing significance testing (t-test and Benjamini–Hochberg correction)  
- Generating basic visualizations including **volcano plots** and **bar plots**

---

## 📊 Features

| Step | Description |
|------|--------------|
| **Data Simulation** | Creates example RNA count data for 5 genes under control and treatment conditions |
| **Normalization** | Scales counts to counts per million (CPM) |
| **Differential Expression** | Calculates fold change, log2 fold change, and performs two-sided t-tests |
| **Multiple Testing Correction** | Adjusts p-values using Benjamini–Hochberg (BH) correction |
| **Visualization** | Generates a volcano plot and a bar plot of mean expression levels |
| **Classification** | Labels genes as *Significant*, *Up-regulated*, *Down-regulated*, or *No change* |

---

## 🧠 Workflow Summary

1. **Simulate Data**
   ```r
   counts <- data.frame(
     Gene = c("GeneA", "GeneB", "GeneC", "GeneD", "GeneE"),
     Control_1 = c(100, 500, 50, 200, 10),
     Control_2 = c(110, 520, 60, 190, 12),
     Control_3 = c(90, 480, 55, 210, 9),
     Treat_1 = c(300, 480, 20, 195, 30),
     Treat_2 = c(280, 490, 25, 200, 40),
     Treat_3 = c(320, 470, 15, 190, 35)
   )
