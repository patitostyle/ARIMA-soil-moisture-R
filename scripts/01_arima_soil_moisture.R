# =============================================================
# ARIMA MODEL FOR SOIL MOISTURE TIME SERIES
# Master's Degree - Time Series Analysis
# Data: Volumetric water content at different times (0, 2, 4, 6, 8)
# =============================================================

# 1. LOAD LIBRARIES
if (!require("pacman")) install.packages("pacman")
pacman::p_load(aTSA, forecast, ggplot2, stats)

# 2. LOAD DATA (Relative path for GitHub compatibility)
# CSV must have columns: distance, time_0, time_2, time_4, time_6, time_8
data <- read.csv("data/datos_humedad.csv")

# 3. EXTRACT TIME 0 SERIES
time_0 <- data$time_0

# 4. VISUALIZATION
plot(data$distance, time_0, type = "l", 
     xlab = "Distance (m)", ylab = "Volumetric Water Content (%)",
     main = "Soil Moisture Profile at Time 0")

# 5. PAIRWISE SCATTERPLOT (all time points)
datos_tiempos <- data[, c('time_0', 'time_2', 'time_4', 'time_6', 'time_8')]
pairs(datos_tiempos, lower.panel = NULL, main = "Scatterplot Matrix by Time")

# 6. STATIONARITY TESTS (ADF and PP)
cat("\n=== Phillips-Perron Test ===\n")
pp.test(time_0)

cat("\n=== Augmented Dickey-Fuller Test ===\n")
adf.test(time_0)

# 7. ACF AND PACF (to identify AR/MA orders)
par(mfrow = c(1, 2))
acf(time_0, main = "ACF - Time 0")
pacf(time_0, main = "PACF - Time 0")
par(mfrow = c(1, 1))

# 8. AUTOMATIC ARIMA SELECTION (auto.arima)
cat("\n=== Running auto.arima on Time 0 ===\n")
auto.arima(time_0, trace = TRUE)

# 9. SPECIFIC ARIMA(2,1,3) MODEL (chosen from previous exploration)
mod1 <- arima(time_0, c(2, 1, 3))

# Plot fitted vs actual
par(mfrow = c(1, 2))
plot(time_0, main = "Observed vs Fitted (ARIMA 2,1,3)")
lines(time_0 - mod1$residuals, col = "red")
plot(mod1$residuals, main = "Residuals of ARIMA(2,1,3)")
par(mfrow = c(1, 1))

# 10. RESIDUAL DIAGNOSTICS (Ljung-Box test and plots)
checkresiduals(mod1)

# 11. (OPTIONAL) SIMULATION EXAMPLES - Uncomment to run theoretical models
# These simulate AR, MA, ARMA processes to compare ACF/PACF patterns
# AR(1)
# ar1 <- arima.sim(model = list(ar = c(0.9)), n = 1000)
# ts.plot(ar1)
# acf(ar1); pacf(ar1)

# MA(1)
# ma1 <- arima.sim(model = list(ma = c(0.9)), n = 200)
# ts.plot(ma1)
# acf(ma1); pacf(ma1)

# ARMA(2,2)
# arma22 <- arima.sim(model = list(ma = c(0.5, 0.2), ar = c(0.7, -0.5)), n = 1000)
# ts.plot(arma22)
# acf(arma22); pacf(arma22)
