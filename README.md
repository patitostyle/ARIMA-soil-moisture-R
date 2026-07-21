# ARIMA Model for Soil Moisture Time Series

[![R](https://img.shields.io/badge/R-4.3+-blue.svg)](https://www.r-project.org/)

## Project Context

This repository contains a univariate time series analysis applied to soil moisture data (volumetric water content) measured at different time points (0, 2, 4, 6, 8 hours). The objective is to model the temporal dynamics of soil moisture using ARIMA methodology.

## Methodology

1. **Exploratory Analysis**: Pairwise scatterplots to examine relationships across time points.
2. **Stationarity Testing**: ADF and Phillips-Perron tests.
3. **Model Identification**: ACF and PACF plots.
4. **Model Selection**: `auto.arima` for automated selection, followed by manual ARIMA(2,1,3) specification.
5. **Diagnostics**: Residual analysis (Ljung-Box test, ACF/PACF of residuals).

## How to Run

1. Clone the repository.
2. Place your dataset as `data/datos_humedad.csv` with columns `distance`, `time_0`, `time_2`, `time_4`, `time_6`, `time_8`.
3. Run `scripts/01_arima_soil_moisture.R`.

## Libraries Used

- `forecast` – ARIMA estimation and diagnostics.
- `aTSA` – Unit root tests.
- `ggplot2` – Visualizations (optional).

## Contact

**Patricio Hernandez**  
[LinkedIn](https://www.linkedin.com/in/patricio-hernandez-ludeha) | [GitHub](https://github.com/patitostyle)
