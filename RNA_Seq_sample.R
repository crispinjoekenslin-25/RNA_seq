# RNA - expression analysis

# Simulated RNA expression counts
counts <- data.frame(
  Gene = c("GeneA", "GeneB", "GeneC", "GeneD", "GeneE"),
  Control_1 = c(100, 500, 50, 200, 10),
  Control_2 = c(110, 520, 60, 190, 12),
  Control_3 = c(90, 480, 55, 210, 9),
  Treat_1 = c(300, 480, 20, 195, 30),
  Treat_2 = c(280, 490, 25, 200, 40),
  Treat_3 = c(320, 470, 15, 190, 35)
)

counts
#Taking row meand
counts$control_mean <- rowMeans(counts[,c("Control_1","Control_2","Control_3")])

counts$treatment_means <- rowMeans(counts[,c("Treat_1","Treat_2","Treat_3")])
# Rounding off values

counts$control_mean <- round(counts$control_mean,2)
counts

#Fold changes

counts$FC <- counts$treatment_means/counts$control_mean
counts$log2FC <- log2(counts$FC)

# Normalizing data

totals <- colSums(counts[,2:7])
totals

counts[,2:7] <- sweep(counts[,2:7],2,totals,FUN="/") * 1e6
counts

# Checking significance for the genes using t.test

pvalues <- c()

for (i in 1:nrow(counts)){
  control <- as.numeric(counts[i,c("Control_1","Control_2","Control_3")])
  treatment <- as.numeric(counts[i,c("Treat_1","Treat_2","Treat_3")])
  test <- t.test(treatment,control,alternative="two.sided")
  pvalues[i] <- test$p.value
}

pvalues

counts$pvalue <- pvalues

counts$adj_pvalue <- p.adjust(pvalues,method = "BH")

counts$Significance <- ifelse(abs(counts$log2FC) >= 1 & counts$adj_pvalue< 0.05, "Significant","Not Significant")

# Volcano plots - (log2FC vs −log10(p-value))

plot(counts$log2FC,-log10(counts$pvalue))

plot(counts$log2FC, -log10(counts$pvalue),
     pch = 19, col = ifelse(counts$Significant == "Significant", "red", "grey"),
     xlab = "Log2 Fold Change", ylab = "-log10(p-value)",
     main = "Volcano Plot (Base R)")
text(counts$log2FC, -log10(counts$pvalue), labels = counts$Gene, pos = 3)

# barplot
barplot(rbind(counts$control_mean, counts$treatment_means),
        beside = TRUE,
        col = c("skyblue", "salmon"),
        names.arg = counts$Gene,
        legend.text = c("Control", "Treatment"),
        main = "Average Expression per Gene")
counts[, c("Gene", "control_mean", "treatment_means", "log2FC", "pvalue", "adj_pvalue", "Significance")]

counts$regulation <- ifelse(
  counts$Significance == "Significant" & counts$log2FC > 1, "Up regulated",
  ifelse(
    counts$Significance == "Significant" & counts$log2FC < 1, " Down regulated","No change"
  )
)

counts


























