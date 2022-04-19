# # cps_data <- read_csv(here("Data/cps_00002.csv.gz"))
# #
# # 
# # cps_data <- read_csv(here("Data/cps_00001.csv.gz")) %>% 
# #    filter(is.na(FTOTVAL)) %>% 
# #    mutate(month_year = make_date(YEAR,MONTH))
# # 
# # cps_data <- inner_join(cps_data,state_mapping) %>% 
# #   filter(AHRSWORKT != 999)
# # 
# # Hmisc::describe(data)
# # 
# # ggplot(data = cps_data, aes(x = month_year, y = AHRSWORKT, color = ST_INC_TAX))+
# #   geom_point()
# # 
# # ggplot(data = cps_data, aes(x = AHRSWORKT))+
# #   geom_histogram(binwidth = 1)+
# #   facet_wrap(~ST_INC_TAX+YEAR)
# #   
# # qplot(x = month_year,y=AHRSWORKT,data = cps_data)
# # 
##############################################################
acs_data <- read_csv(here("Data/usa_00003.csv.gz"))
state_mapping <- read_csv(here("Data/state_mapping.csv")) %>% 
  mutate(ST_INC_TAX = as.factor(ST_INC_TAX))
acs_data <- inner_join(acs_data,state_mapping)

#Might remove 2020 due to COVID need to do more research on when survey was collected
acs_data <- acs_data %>% 
  filter(YEAR != 2020)

#cleaning data

acs_data <- acs_data %>% 
  filter(CLASSWKR == 2) %>% #removes self-employed
  filter(UHRSWORK > 0) #removes workers with zero hours



plot_1 <- ggplot(data = acs_data, aes(x = YEAR, y = UHRSWORK, color = ST_INC_TAX,group = ST_INC_TAX)) +
  geom_smooth(method="gam", formula = y ~ s(x, bs = "cs", k=5))+
  geom_vline(xintercept = 2018,linetype = "dashed")+
  theme_fivethirtyeight()
