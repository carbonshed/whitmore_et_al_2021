# "Spatiotemporal Variability of Gas Transfer Velocity in a Tropical High-Elevation Stream Using Two Independent Methods"
## Authors: Keridwen M. Whitmore*, Nehemiah Stewart*, Andrea Encalada, Esteban Suarez, Diego Riveros-Iregui

*These authors contributed equally to this work. 

This repository serves to host data and analyses used in the research supporting the work in *"Spatiotemporal Variability of Gas Transfer Velocity in a Tropical High-Elevation Stream Using Two Independent Methods"*, submitted to *Ecosphere*.

## Purpose  
  To provide access to the data and make analyses reproducible for others. All figures presented in the paper were created using R statistical software. Scripts and data files for creating our figures are provided within this repository. If you have Rstudio installed on your computer, you should be able to 'fork' this repository and run it on your local computer to reproduce the anlayses in this paper without any alterations.
  
## Instructions to run this code
This code was written and run with R version 3.6.2 and R Studio version 1.2.5001. You can download this repository to your local computer and open the project file *Whitmore_et_al_2021.Rproj*. We use the [here package](https://github.com/jennybc/here_here) to ensure that the code will run on any computer without having to change any file paths. 
  
## Guide to Folders  

### data

- File: **"KatStn1_df.csv"**  

*these data are used to create figures 3 & 4  *  
  
 
| Column Name | Description |
| :--- | :---------- |
| DateTime | Date and Time of collection |
| Flux_1 | Carbon dioxide flux, unit no 1 (umole per meter squared per sec)  |
| airTemp_c | Air Temperature (c)  |
| tempC_421 | Temperature (c) at station 1 |
| stn1_Q | Discharge at station 1 (m<sup>3</sup>s<sup>-1</sup>) |
| air_pressure_kPa | Air pressure (kPa)  |
| V1_adjusted | partial pressure of CO<sub>2</sub> adjusted for temperature and pressure at Station 1 (ppm)  |
| CO2_air_ppm | estimated partial pressure of atmospheric CO<sub>2</sub> (ppm) |
| air_pressure_atm | Barometric pressure (atm) |
| VaporPressure_atm | Vapor pressure (atm) |
| TotalAir_atm | air pressure as dry air (atm) |
| Total_air_MolperL | air pressure as dry air (moles per Liter) |
| CO2_air_MolesPerLiter | CO<sub>2</sub> concentration in air (moles per Liter) |
| CO2_air_gCO2asCPerLiter | CO<sub>2</sub> concentration in air (grams of CO<sub>2</sub> as C per Liter) |
| WaterTemp_K| water temperature (kelvin) |
| KH_mol.L.atm | Henry's constant (moles per Liter per atm) |
| CO2_water_gCO2asCPerLiter| CO<sub>2</sub> concentration in the water (grams of CO<sub>2</sub> as C per Liter) |
| deltaCO2_gCO2asCperM3 | difference between CO<sub>2</sub> concentration in the air and dissolved CO<sub>2</sub> concentration (grams of CO<sub>2</sub> as C per Liter) |
| Flux_gCO2asCperM2perDay | Carbon dioxide flux, unit no 1 (grams per meters squared per day) |
| k_m.d | gas transfer velocity (meters squared per sec) |
| Sc | Schmidt number |
| K600.effective | measured k<sub>600</sub> at station 1 (meters squared per sec) |
| kkin | kinematic K<sub>600</sub> label |
| K600.eq1 | kinematic k<sub>600</sub> at station 1 (meters squared per sec) |


<strong>______________________________________________________________________</strong>

  
- File: **"KatStn4_df.csv"**  

*these data are used to create supplementary figure 3  * 
  
 | Column Name | Description |
| :--- | :---------- |
| DateTime | Date and Time of collection |
| Flux_2 | Carbon dioxide flux, unit no 2 (umole per meter squared per sec)  |
| airTemp_c | Air Temperature (c)  |
| tempC_421 | Temperature (c) at station 1 |
| stn1_Q | Discharge at station 1 (m<sup>3</sup>s<sup>-1</sup>) |
| air_pressure_kPa | Air pressure (kPa)  |
| V4_adjusted | partial pressure of CO<sub>2</sub> adjusted for temperature and pressure at Station 4 (ppm)  |
| CO2_air_ppm | estimated partial pressure of atmospheric CO<sub>2</sub> (ppm) |
| air_pressure_atm | Barometric pressure (atm) |
| CO2_air_gCO2asCPerLiter | CO<sub>2</sub> concentration in air (grams of CO<sub>2</sub> as C per Liter) |
| WaterTemp_K| water temperature (kelvin) |
| KH_mol.L.atm | Henry's constant (moles per Liter per atm) |
| CO2_water_gCO2asCPerLiter| CO<sub>2</sub> concentration in the water (grams of CO<sub>2</sub> as C per Liter) |
| deltaCO2_gCO2asCperM3 | difference between CO<sub>2</sub> concentration in the air and dissolved CO<sub>2</sub> concentration (grams of CO<sub>2</sub> as C per Liter) |
| Flux_gCO2asCperM2perDay | Carbon dioxide flux, unit no 2 (grams per meters squared per day) |
| k_m.d | gas transfer velocity at station 4 (meters squared per sec) |
| Sc | Schmidt number |
| K600.E.stn4 | measured k<sub>600</sub> at station 4 (meters squared per sec) |

<strong>______________________________________________________________________</strong>
   
- File name: **PrecipitationData.csv**

*these data are used to create Supplimentary figure 1 *

| Column Name | Description |
| :--- | :---------- |
| DateTime | Date and Time of collection |
| ppt_mm | precipitation accumulation at 15 min intervals [mm]  |
| ppt24Tot | 24-hour total precipitation [mm]  |
| stn1_Q | Discharge at station 1 (m<sup>3</sup>s<sup>-1</sup>) |

<strong>______________________________________________________________________</strong>

- File: **Synoptic_Kin600.csv**

*these data are used to create figures 5 & 6* 

  | Column Name | Description |
  | :--- | :---------- |
  | Date | Date of collection |
  | transect| synoptic transect |
  | dist.m | distance from outlet (meters) | 
  | elev.m | elevation (meters) | 
  | slope.unitless | slope (unitless) | 
  | depth.m | water depth (meters) | 
  | velocity.m.s | velocity (meters per sec) |
  | Discharge.m3.s | discharge (cubic meters per sec) | 
  | K600.eq1 | kinematic k<sub>600</sub> (meters squared per sec) | 

<strong>______________________________________________________________________</strong>

- File: **Synoptic_Kin600.csv**

*these data are used to create figures 5 & 6* 

 | Column Name | Description |
  | :--- | :---------- |
  | DOY | Day of year of collection |
  | slope.unitless | slope (unitless) | 
  | depth.m | water depth (meters) | 
  | velocity.m.s | velocity (meters per sec) |
  | dist.m.AVE | distance from outlet (meters) | 
  | CO2_ppm | dissolved CO<sub>2</sub> concentration (ppm) | 
  | ave.time | median time of collection during synoptic collection date |
  | Synoptic_no | synoptic location sampled |
  | Flux_ave_umol_m3_s | Average of 3 Flux measurments collected at sample location (umol per cubic meters per sec)  | 
  | Flux_StdDev | Standard deviation of 3 Flux measurments collected at sample location (umol per cubic meters per sec)  | 
  | WaterTemp_c| water temperature (celcius) |
  | Q_m3perS | Average discharge during sample period  (cubic meter per sec) |
  | air_pressure_kPa | Air pressure (kPa)  |
  | Date | Date of collection |
  | K600.eq1 | kinematic k<sub>600</sub> (meter squared per sec) |
  | air_pressure_atm | Air pressure (atm)  |
  | VaporPressure_atm | Vapor pressure (atm)  | 
  | CO2_air_MolesPerLiter | atmospheric CO<sub>2</sub> (moles per liter) |
  | CO2_air_gCO2asCPerLiter | atmospheric CO<sub>2</sub> (grams of CO<sub>2</sub> as C per liter) |
  | WaterTemp_K| water temperature (kelvin) |
  | KH_mol.L.atm | Henry's constant (moles per Liter per atm) |
  | CO2_water_gCO2asCPerLiter| CO<sub>2</sub> concentration in the water (grams of CO<sub>2</sub> as C per liter)|
  | deltaCO2_gCO2asCperM3 | difference between CO<sub>2</sub> concentration in the air and in the water (grams of CO<sub>2</sub> as C per m^3) |
  | Flux_gCO2asCperM2perDay | Carbon dioxide flux, unit no 1 (grams of CO<sub>2</sub> as C per meters squared per day) |
  | k_m.d | gas transfer velocity (meters squared per sec) |
  | Sc | Schmidt number |
  | K600.effective | measured k<sub>600</sub> (meters squared per sec) |

<strong>______________________________________________________________________</strong>

<strong>______________________________________________________________________</strong>
  
## scripts

| File Name | Type | Description |
| :------- | :--: |:---------- |
| Fig3.R | R code | figure 3 |
| Fig4.R | R code| figure 4 |
| Fig5.R | R code | figure 5 |
| Fig6.R | R code | figure 6 | 
| SuppFig1.R |	R code | supplementary figure 1 |
| SuppFig2.R |	R code | supplementary figure 2 |
| SuppFig3.R |	R code | supplementary figure 3 |

<strong>______________________________________________________________________</strong>
  
## Points of contact  

Direct **questions about the paper** to Dr. Diego Riveros-Iregui: <diegori@email.unc.edu>

Direct **questions about the code** to Kriddie Whitmore: kriddie@email.unc.edu>


