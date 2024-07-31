# Quantiles

# pnorm(

# cum.prob
p= pnorm(q=seq(-5, +5, .01), mean=0, sd=1)
plot(q,p)

x=seq(-5, +5, .01)

# normal plot
d= dnorm(x=seq(-5,+5, .01), mean=0, sd=1)
plot(x, d)



tibble(x=q, cum.prob=p) |> dplyr::filter(cum.prob > .4 & cum.prob < .6)

t = tibble(x=q, cum.prob=p) |> dplyr::filter(cum.prob > .4 & cum.prob < .6)
plot(t$x,  t$cum.prob)
t = tibble(x=q, cum.prob=p) |> dplyr::filter(cum.prob > .4 & cum.prob < .6)
plot(t$x,  t$cum.prob)
plot(t$cum.prob, t$x)
  
