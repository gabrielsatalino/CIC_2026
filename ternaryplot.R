# Plotando objetos comstab e TernPlots
### Exemplo

z <- comTS(nsp = 10, ny = 30, even = 0.6, mvs = 1.5, sync = "0") # Runs the partitioning of the community coefficient of variation:
x <- partitionR(z) # Plots the result plot(x)

# A função ternStab() plota a contribuição relativa de cada componente da partição (diagrama triangular Jules)

#Exemplo
require(Ternary)
# Simulates a custom community time series using 'comTS()': z \<- comTS(nsp = 10, ny = 30, even = 0.6, mvs = 1.5, sync = "0") 
# Runs the partitioning of the community coefficient of variation: x \<- partitionR(z) 
# Plots the relative contributions oldpar \<- par(no.readonly = TRUE) par(mar = c(0, 0, 0, 0)) ternStab(x) plot(x) 
# Adds a second community on the ternary plot z2 \<- comTS(nsp = 15, ny = 30, even = .7, mvs = 1.1, sync = "1") x2 \<- partitionR(z2) ternStab(x2, add = TRUE, col = "red") par(oldpar)

#Teste: Comparando as contribuições dos componentes da partição sobre a estabilidade local e regional

data <- read.csv("dados_comvar_fish_inv_semfiltar.csv", header = T , sep = ",")

#Escala local
st_local1 \<- data\[,-2\]

st_local2\<- split(st_local1, f = st_local1\$SiteID)

st_local3 \<-lapply(st_local2, function(x) { x %\>% select(Year, Species, Abundance) %\>% group_by(Year, Species) %\>% summarise(Abundance = sum(Abundance, na.rm = TRUE), .groups = "drop") %\>% pivot_wider(names_from = Species, values_from = Abundance, values_fill = 0) %\>% column_to_rownames("Year") %\>% as.matrix() })

st_local4 \<- lapply(st_local3, partitionR)

#como plotar objetos comstab

plot(st_local4\$S10447)

plot(st_local4\$S10075)

#Como adicionar sítios individuais no plot comparativo

ternStab(st_local4\$S12520) #plot comparativo inicial

ternStab(st_local4\$S10075, add = TRUE, col = "red") #adição de sítios

ternStab(st_local4\$S11610, add = TRUE, col = "navy") #adição de sítios

#problema a ser resolvido: #como juntar os sítios e compara-los a partir dos parâmetros de "invasão" #Invadido :sim ou não, proporção de invasão...
#Outro problema encontrado: Muitos sítios com valor Relative = NA.

#Exemplo:
st_local4$S10291$Relative

#tentativa de solução: Filtrar os sítios com problemas
na_flags \<- sapply(st_local4, function(x) any(is.na(x\$Relative))) sum(na_flags) \# quantos sítios foram afetados names(st_local4)\[na_flags\] \# quais SiteIDs
st_local4_valido \<- st_local4\[!na_flags\]
ternStab(st_local4_valido\[\[1\]\]) for (i in 2:length(st_local4_valido)) { ternStab(st_local4_valido\[\[i\]\], add = TRUE) }

#Escala regional st_reg \<- data\[,-4\]