library(readr)
library(naniar)
library(dplyr)

dat <- read_csv("data/F2022-NHIS-MentalHealth_raw.csv")

dat <- dat %>% 
  replace_with_na_at(.vars = c("HRSLEEP"), condition = ~.x == 0)

dat$sleep_mt7hr <- ifelse(dat$HRSLEEP < 7, TRUE, FALSE)

dat <- dat %>% 
  replace_with_na_at(.vars = c("AEFFORT", "AHOPELESS", "ANERVOUS", "ARESTLESS", "ASAD", "AWORTHLESS"), condition = ~.x == 0)

dat <- dat %>% 
  mutate(kessler_score = AEFFORT + AHOPELESS + ANERVOUS + ARESTLESS + ASAD + AWORTHLESS)

dat$mentalhealth_severe <- ifelse(dat$kessler_score < 13, FALSE, TRUE)

dat <- dat %>% 
  replace_with_na_at(.vars = c("AGE", "POORYN"), condition = ~.x == 0)

write.csv(x = dat, file = "MentalHealth_clean.csv", row.names = FALSE)



