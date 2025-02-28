# Hybrid Wind-Wave Modeling
 
This repository is an open source coupling framework that couples **WEC-Sim** with **MOST** and **MoorDyn** to model hybrid wind-wave systems by integrating floating wind turbine (FWT) with wave energy converter (WEC) on a mooring platform. The FWT used is **NREL 5MW** , the WEC is the **RM3** WEC, and a spar platform is used for mooring foundation.

**Context**

The project is part of research in the [Symbiotic Engineering Analysis (SEA) Lab](https://sea.mae.cornell.edu/)



**Authors**
- Alaa Ahmed, alaa.ahmed@cornell.du
- Maha Haji, maha@cornell.edu


**File Structure**
- `geometry`: Contains the geometry files for visualization.
- `hydroData`: Contains the file for hydrodynamics coefficients in a .h5 extension. The file is generated using `bemio.m`.
- `Mooring`: Contains the file needed as input for MoorDyn. 
- `mostData`: Contains **MOST** code to model the aerodynamics and electrical generator for the FWT.


**How to use**
- To run the coupled code, open `wecSimInputFile.m` and update the excitation conditions then run `wecSim.m`. 


**License**

This project is released open-source under the MIT License. The hydrodynamics data was generated from WAMIT and WEC-Sim, which is publicly available.
