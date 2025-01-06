setwd("~/Masters/MTHM601/Roadkill Report")
rk <- read.csv("records-2024-12-03.csv")

library(ggplot2)
species <- rk$Common.name

##DATA VISUALISATION

#Count species occurrences


species_counts <- as.data.frame(table(species)) #create species count
colnames(species_counts) <- c("species", "count") #rename columns 

# Plot
ggplot(species_counts, aes(x = species, y = count, fill = species)) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Species Distribution", x = "Species", y = "Count")

#Too many to actually be displayed - try genus level

genus_counts <- as.data.frame(table(rk$Genus)) #create species count
colnames(genus_counts) <- c("Genus", "count") #rename columns 

# Plot
ggplot(genus_counts, aes(x = Genus, y = count, fill = Genus)) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Genus Distribution", x = "Genus", y = "Count")

#Still too many - Family level

family_counts <- as.data.frame(table(rk$Family)) #create species count
colnames(family_counts) <- c("family", "count") #rename columns 

# Plot
ggplot(family_counts, aes(x = family, y = count, fill = family)) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Family Distribution", x = "Family", y = "Count")

#Can see one family is much higher but can't determine from the graph - too many families so the colours are too similar
#Try Order

order_counts <- as.data.frame(table(rk$Order)) #create species count
colnames(order_counts) <- c("order", "count") #rename columns 

# Plot
ggplot(order_counts, aes(x = order, y = count, fill = order)) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Order Distribution", x = "Order", y = "Count")

#Can see that Carnivora is the highest 
#Try Class - Might be time to remove some and focus on just mammals? 

class_counts <- as.data.frame(table(rk$Class)) #create species count
colnames(class_counts) <- c("Class", "count") #rename columns 

# Plot
ggplot(class_counts, aes(x = Class, y = count, fill = Class)) +
  geom_bar(stat = "identity", color = "black") +
  theme_minimal() +
  labs(title = "Class Distribution", x = "Class", y = "Count")

#