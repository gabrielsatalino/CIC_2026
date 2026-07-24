require(Ternary)
require(comstab)


data = read.csv("data_for_collaborators.csv", header = TRUE, sep = ",")
View(data)

# Creating relative contribution of each stabilizing effect

data$log_tau <- data$log_Delta + data$log_Psi + data$log_omega # Summing up the three effects

data$Delta_cont <- data$log_Delta / data$log_tau # Dominance effect
data$Psi_cont   <- data$log_Psi   / data$log_tau # Asynchrony effect
data$omega_cont <- data$log_omega / data$log_tau # Averaging effect


# Basic configuration for the ternary plot
oldpar <- par(no.readonly = TRUE) # First expand the margins
par(mar = c(0, 0, 0, 0))

# Ternary plot
TernaryPlot(alab = "Dominance", blab = "Asynchrony", clab = "Averaging")

TernaryPoints(
  data.frame(data$Delta_cont, data$Psi_cont, data$omega_cont),
  col = "steelblue", pch = 16, cex = 0.8
) # Using contributions to plot points

# Arrumar a proporção do TernaryPlot de acordo com os valores de Delta, Psi e omega;
# Criar pontos com formato e cores diferentes para áreas invadidas e não-invadidas;
# Aumentar o tamanho dos pontos e arrumar a estética do gráfico
# Leia a documentação do pacote Ternary ;)

par(oldpar)
