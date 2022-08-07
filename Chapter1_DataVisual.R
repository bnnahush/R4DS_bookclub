# R4DS Book club https://www.youtube.com/watch?v=0NdiQuuM0vw&list=PL3x6DOfs2NGjk1sPsrn2CazGiel0yZrhc&index=2
#Chapter 2 & 3

# Data Visualization with ggplot2

library(tidyverse)

#example dataset
mpg
#details of the example dataset
?mpg

#Basic Structure of ggplot
# 
# ggplot(data =<DATA>) +
#   <GEOM_FUNC>(
#     mapping = aes(<Mapping>),
#     stat = <Stat>,
#     position = <Position>,
#   ) +
#   <COORD_FUNC> +
#   <FACET_FUNC>

#aes Examples
  
ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy))

#Group by color
ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy, color = class))

#Group by size

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy, size = class))

#Group by transperacy

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy, alpha = class))

#Group by shape

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy, shape = class))

#Manual changes for <GEOM_FUNC>

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy), color ='blue')

#Facets
ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy)) +
  facet_wrap(~class, nrow =2)

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy,color = class)) +
  facet_grid(drv ~ cyl)

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy,color = class)) +
  facet_grid(. ~ cyl)

ggplot(data =mpg) +
  geom_point(mapping = aes(x =drv, y=cyl,color = class)) +
  facet_grid(drv ~ cyl)

# geom: Geometrical Objects

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy))

ggplot(data =mpg) +
  geom_smooth(mapping = aes(x =displ, y=hwy))

ggplot(data =mpg) +
  geom_smooth(mapping = aes(x =displ, y=hwy, linetype = drv))

ggplot(data =mpg) +
  geom_smooth(mapping = aes(x =displ, y=hwy, group = drv))

ggplot(data =mpg) +
  geom_smooth(mapping = aes(x =displ, y=hwy, color = drv), 
              show.legend = FALSE)

#multiple geoms

ggplot(data =mpg) +
  geom_point(mapping = aes(x =displ, y=hwy)) +
  geom_smooth(mapping = aes(x =displ, y=hwy))

# or

ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color = class)) +
  geom_smooth()


#Subsetting data in some geoms
ggplot(data = mpg, mapping = aes(x =displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == 'subcompact'),
    se =FALSE
    )

#Ex1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point() +
  geom_smooth(se=F)
#Ex2
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se=F)
#Ex3
ggplot(data = mpg, mapping = aes(x = displ, y = hwy,color = drv))+
  geom_point() +
  geom_smooth(se=F)
#Ex4
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(se =F)
#Ex5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(linetype = drv), se =F)


#Bar plot
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(data = diamonds) +
  stat_count( mapping = aes(x = cut) )

#stat = 'identity' when you want to map bar height as given value and not compute stat_count

demo <- tribble(
  ~cut,         ~freq,
  "Fair",       1610,
  "Good",       4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)

ggplot(data =demo) + 
  geom_bar(mapping = aes(x = cut, y = freq), stat='identity')

#stat based on proportion

ggplot(data =diamonds) +
  geom_bar(mapping = aes(x = cut, y= stat(prop), group = 2))

#check out more stat
ggplot(data = diamonds)+
  stat_summary(mapping = aes(x = cut, y = depth),
               fun.min = min,
               fun.max = max,
               fun = median)


ggplot(data = diamonds) +
  geom_col(mapping = aes(x = cut,y = price))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = after_stat(prop)))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color, y = after_stat(prop)))

#Bar plot color

ggplot(diamonds) +
  geom_bar(aes(x =cut,color =cut))

ggplot(diamonds) +
  geom_bar(aes(x =cut,fill =cut))

#Positional adjustments
ggplot(diamonds) +
  geom_bar(aes(x =cut,fill =clarity))


# 3 types of position

#position = 'identity', not useful with bar, mainly it just draws on top of each other and is the default

ggplot(diamonds, aes(x = cut,fill= clarity)) + 
  geom_bar(position = 'identity', alpha = 1/5)

ggplot(diamonds, aes(x = cut,color= clarity)) + 
  geom_bar(position = 'identity', fill =NA)

#position = 'fill', is like stacking and outputs in proportion.

ggplot(diamonds )+
  geom_bar(aes(x= cut, fill = clarity), position = 'fill')

#position = 'dodge', keeps overlapping odjects next to each other earier to compare individual entities.
ggplot(diamonds)+
  geom_bar(aes(x = cut, fill=clarity), position ='dodge')

#position, works in different ways in different geoms. In geom_point it can be used to reduce overplatting.
#not all points are visible by default as closeby points are grouped.
ggplot(mpg)+
  geom_point(aes(displ,hwy))
#position ='jitter'

ggplot(mpg)+
  geom_point(aes(displ,hwy), position ='jitter')

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = 'jitter')


ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) + 
  geom_point(position = position_jitter(width = 1,height = 1))


#Coordinate systems

ggplot(mpg, aes(class,hwy))+
  geom_boxplot()

ggplot(mpg, aes(class,hwy))+
  geom_boxplot()+
  coord_flip()

#coord_quickmap for auto aspect ration correction
nz = map_data('nz')

ggplot(nz,aes(long,lat,group=group))+
  geom_polygon(color = 'black',fill='white')

ggplot(nz,aes(long,lat,group=group))+
  geom_polygon(color = 'black',fill='white')+
  coord_quickmap()


#coord_polar for cozcombhart and pie
ggplot(diamonds)+
  geom_bar(aes(x = cut,fill=cut))+
  coord_flip()

ggplot(diamonds)+
  geom_bar(aes(x = cut,fill=cut))+
  coord_polar()


ggplot(diamonds)+
  geom_bar(aes(x = 1,fill=cut))+
  coord_polar(theta = 'y')
