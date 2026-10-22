library(dplyr)
library(ggplot2)

t = tribble(
  ~make, ~model, ~year, ~miles, ~price, ~source, ~comment,
            "Toyota", "Corolla", 9, 150, 2.2, NA , NA, 
  "", "Corolla", 9, 147, 3.6, NA, NA,
  "", "Corolla", 9, 63, 7, "ebay", NA,
  "", "Corolla", 9, 116, 3, "CL", NA,
"", "Corolla", 9, 151, 4.9, NA, NA,
"","Corolla", 9, 180, 2.4, NA, NA,
"", "Corolla", 10, 140, 4.5, NA, NA,
"", "Corolla", 10, 127, 5, NA, NA,
"", "Corolla", 10, 116, 5.5, NA, NA,
"", "Corolla", 10, 106, 4.8 , "FB", NA,
"", "Corolla", 10, 113, 5.5,"FB", NA,
"", "Corolla", 10, 96, 13, "Carvenna", NA,
"", "Corolla", 10, 100, 12.6, "Carvenna",  NA,
"", "Corolla", 10, 150, 5.5, "CL",  NA,
"", "Corolla", 10, 113, 10., "CL",  NA,
"", "Corolla", 10, 143, 10, "FB", NA,
"", "Corolla", 10, 74, 8.5, "FB", NA,
"", "Corolla", 10, 155, 5.5, "FB", NA,
"", "Corolla", 10, 104, 5.5, "FB", NA,
"", "Corolla", 10, 120, 5.4, "FB", NA,
"", "Corolla", 10, 149, 5.4, "FB", NA,
"", "Corolla", 10, 138, 6.5, "FB", NA,
"", "Corolla", 11, 152, 7.5, NA,NA,
"", "Corolla", 11, 146, 8.9, NA, NA,
"", "Corolla", 11, 143, 8, NA, NA,
"", "Corolla", 11, 144, 8, NA, NA,
"", "Corolla", 11, 144, 8, NA, NA,
"", "Corolla", 11, 49, 15.3, NA, NA,
"", "Corolla", 11, 106, 4.8, NA, NA,
"", "Corolla", 11, 81, 9, NA, NA,
"", "Prius", 2, 146,4, NA,NA,
"", "Prius", 2, 139,5.5, NA,NA,
"", "Prius", 2, 123,5.5,NA,NA,
"", "Prius", 2, 158,6.5, NA,NA,
"", "Prius", 2, 169,4.5, NA,NA,
"", "Prius", 2, 139,5.5, NA,NA,
"", "Prius", 2, 123,5.5, NA,NA,
"", "Prius", 2, 220,3, NA,NA,
"", "Prius", 2, 139,7, NA,NA,
"", "Prius", 2, 190,6, NA,NA,
"", "Prius", 2, 183,4.2, NA,NA,
"", "Prius", 2, 63.4,8, NA,NA,
"", "Prius", 3, 177, 7, NA,NA,
"", "Prius", 3, 187, 6.3, NA,NA,
"", "Prius", 3, 121, 6.1, NA,NA,
"", "Prius", 3, 165, 7, NA,NA,
"", "Prius", 3, 180, 4.2, NA,NA,
"", "Prius", 3, 150, 6.8, NA,NA,
"", "Prius", 3, 131, 7.2, NA,NA,
"", "Prius", 3, 115, 7.5, NA,NA,
"", "Prius", 3, 260, 5, NA,NA,
"", "Prius", 3, 165, 7, NA,NA,
"", "Prius", 3, 115, 7, NA,NA,
"", "Prius", 3, 95, 7.7, "Reddit", "good buy",
"", "Prius", 3, 149, 7.5,"FB",NA,
"", "Prius", 3, 170, 8, "FB",NA,
"", "Prius", 3, 143, 6, "FB",NA,
"", "Prius", 3, 146, 6.5, "FB", NA
)
t

# boxplot
p <- ggplot(data=t,  aes(x=miles, y=price, fill=year)) + geom_boxplot()
p


#  scatterplot
ds = t |> dplyr::filter(model=="Prius")

p = ggplot(ds, aes(x=miles, y=price, color=factor(year))) + 
    geom_point(shape=1) +
    geom_smooth(method=lm,   # Add linear regression lines
                se=FALSE) +   # Don't add shaded confidence region
  #labs(title="Corolla", subtitle="9th=2000+, 10th=2006+, 11th=2012+")
  labs(title="Prius", subtitle="gen 2 = 2003+, gen 3 = 2009 +")
p

