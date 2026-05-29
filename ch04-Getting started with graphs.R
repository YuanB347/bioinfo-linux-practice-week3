#install.packages(c("ggplot2", "mosaicData"))
library(ggplot2)
library(mosaicData)
data(CPS85)
ggplot(data = CPS85, mapping = aes(x = exper, y = wage))
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point()
CPS85 <- CPS85[CPS85$wage < 40, ]
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point()
ggplot(data = CPS85, mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue", alpha = .7, size = 1.5) +
  theme_bw()
ggplot(data = CPS85, 
       mapping = aes(x = exper, y = wage)) +
  geom_point(color = "cornflowerblue", alpha = .7, size = 1.5) +
  theme_bw() +
  geom_smooth(method = "lm")
ggplot(data = CPS85, 
       mapping = aes(x = exper, y = wage,
                     color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  theme_bw()
ggplot(data = CPS85,
       mapping = aes(x = exper, y = wage,
                     color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5)) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  theme_bw()
ggplot(
  data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1.5) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  theme_bw()
ggplot(
  data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap(~sector) +
  theme_bw()
ggplot(
  data = CPS85,
  mapping = aes(x = exper, y = wage,
                color = sex, shape = sex, linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3","cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender", shape = "Gender", linetype = "Gender") +
  theme_bw()
ggplot(data = CPS85,
       mapping = aes(x = exper, y = wage, color = sex, shape=sex,
                     linetype = sex)) +
  geom_point(alpha = .7) +
  geom_smooth(method = "lm", se = FALSE) +
  scale_x_continuous(breaks = seq(0, 60, 10)) +
  scale_y_continuous(breaks = seq(0, 30, 5),
                     label = scales::dollar) +
  scale_color_manual(values = c("indianred3", "cornflowerblue")) +
  facet_wrap(~sector) +
  labs(title = "Relationship between wages and experience",
       subtitle = "Current Population Survey",
       caption = "source: http://mosaic-web.org/",
       x = " Years of Experience",
       y = "Hourly Wage",
       color = "Gender", shape="Gender", linetype="Gender") +
  theme_minimal()
ggplot(CPS85,
       mapping = aes(x = exper, y = wage, color = sex)) +
  geom_point(alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1)
ggplot(CPS85, aes(x = exper, y = wage)) +
  geom_point(aes(color = sex), alpha = .7, size = 1.5) +
  geom_smooth(method = "lm", se = FALSE, size = 1)
myplot <- ggplot(data = CPS85, aes(x = exper, y = wage)) +
  geom_point()

myplot
myplot2 <- myplot + geom_point(size = 3, color = "blue")
myplot2
myplot + geom_smooth(method = "lm") +
  labs(title = "Mildly interesting graph")
ggplot(CPS85, aes(x = exper, y = wage, color = "blue")) +
  geom_point()
ggplot(CPS85, aes(x = exper, y = wage)) +
  geom_point(color = "blue")
head(CPS85)
str(CPS85)
names(CPS85)
ggplot(data = CPS85, aes(x = exper, y = wage))
ggplot(data = CPS85, aes(x = exper, y = wage)) +
  geom_point()
CPS85_sub <- CPS85[CPS85$wage < 40, ]
geom_smooth(method = "lm")
geom_smooth(method = "lm", se = FALSE)
aes(color = sex)
aes(color = sex, shape = sex, linetype = sex)
scale_x_continuous(breaks = seq(0, 60, 10))
scale_y_continuous(breaks = seq(0, 30, 5))
scale_color_manual(values = c("indianred3", "cornflowerblue"))
scale_y_continuous(breaks = seq(0, 30, 5), labels = scales::dollar)
labs(
  title = "...",
  subtitle = "...",
  x = "...",
  y = "...",
  color = "...",
  shape = "..."
)
theme_bw()
theme_minimal()
theme_classic()
facet_wrap(~sector)
p1 <- ggplot(CPS85, aes(x = exper, y = wage)) + geom_point()
p2 <- p1 + geom_smooth(method = "lm")
p3 <- p2 + labs(title = "...")
facet_grid(sex ~ sector)
aes(color = union)
aes(shape = married)
facet_wrap(~union)
geom_smooth(method = "lm")
geom_smooth()
ggsave("chapter4_plot.png", width = 8, height = 6, dpi = 300)
data(mpg)
head(mpg)
str(mpg)
names(mpg)
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
ggplot(mpg, aes(displ, hwy, color = drv)) +
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy, color = drv, shape = class)) +
  geom_point()
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  scale_x_continuous(breaks = seq(1, 7, 1)) +
  scale_y_continuous(breaks = seq(10, 45, 5))
#ggplot2 里的 geom_*()、scale_*()、facet_*()、theme_*()、labs()都要加到一个已有的图对象后面，不能自己单独用 + 连起来运行
scale_color_manual(values = c("red", "blue", "darkgreen"))
facet_wrap(~year)
facet_wrap(~class)
labs(
  title = "...",
  subtitle = "...",
  x = "...",
  y = "...",
  color = "...",
  caption = "..."
)
p <- ggplot(mpg, aes(x = displ, y = hwy))
p + geom_point()
p + geom_point() + geom_smooth(method = "lm")
p + geom_point() + geom_smooth(method = "lm") + facet_wrap(~year)
