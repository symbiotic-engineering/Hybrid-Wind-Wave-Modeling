%% Simulation class

simu = simulationClass();                           % Initialize Simulation Class
simu.simMechanicsFile = 'WT5MW_float_OC3.slx';            % Specify Simulink Model File
simu.mode = 'normal';                               % Specify Simulation Mode ('normal','accelerator','rapid-accelerator')
simu.explorer='on';                                 % Turn SimMechanics Explorer (on/off)
simu.startTime = 0;                                 % Simulation Start Time [s]
simu.rampTime = 20;                                 % Wave Ramp Time [s]
simu.endTime = 900;                                % Simulation End Time [s]    
simu.rho = 1025;                                    % Water density [kg/m3]
simu.solver = 'ode4';                               % simu.solver = 'ode4' for fixed step & simu.solver = 'ode45' for variable step 
simu.dt = 0.02;                                     % Simulation Time-Step [s]
simu.b2b = 0;                   	                % Turn B2B interactions 'off'
simu.stateSpace = 0;                                % Flag for convolution integral or state-space calculation, Options: 0 (convolution integral), 1 (state-space)
simu.domainSize = 100;                              % Size of free surface and seabed. This variable is only used for visualization. 
simu.cicEndTime = 60;                               % Specify Convolution integral Time [s]
simu.gravity = 9.80665;                             % Gravity acceleration [m/s2]

Configuration = 'Hybrid';

%% Wave class
% Regular Wave
waves = waveClass('regular');                     % Initialize Wave Class and Specify Type
waves.height = 6.75;                              % Significant Wave Height [m]
waves.period = 14.5;                               % Peak Period [s]

% % Irregular Waves using Jonswap Spectrum
% waves = waveClass('irregular');                     % Initialize WaveClass and Specify Type
% waves.phaseSeed = 1;                                % Needed to create different random waves
% waves.height = 6.75;                                % Significant Wave Height [m]
% waves.period = 14.5;                                 % Peak Period [s]
% waves.spectrumType = 'JS';                          % Specify Spectrum Type JS=Jonswap, PM=Pierson-Moskovitz
% waves.direction = 0;                                % Wave Directionality [deg]

%% Body class 

% Float
body(1) = bodyClass('hydroData/5MW_float_OC3.h5');                                                  % Initialize bodyClass (giving hydro data file as input)
body(1).geometryFile = 'geometry/float_geom.stl';                                                   % Location of Geomtry File
body(1).mass = 'equilibrium';                                                                       % User-Defined mass [kg]
body(1).inertia = [20907301 21306090.66 37085481.11];                                      % Moment of Inertia [kg*m^2]     

% OC3
body(2) = bodyClass('hydroData/5MW_float_OC3.h5');                                                   % Initialize bodyClass (giving hydro data file as input)
body(2).geometryFile = 'geometry/oc3_geom.stl';                                                % Geometry File 
body(2).mass = 7466330;                                                                        % User-Defined mass [kg]
body(2).inertia = [4229230000 4229230000 164230000];                                           % Moment of Inertia [kg-m^2]
body(2).linearDamping = [100000     0       0             0             0             0        %AddBLin  - Additional linear damping(N/(m/s), N/(rad/s), N-m/(m/s), N-m/(rad/s))        [If NBodyMod=1, one size 6*NBody x 6*NBody matrix; if NBodyMod>1, NBody size 6 x 6 matrices]
                            0    100000     0             0             0             0
                            0       0    130000           0             0             0
                            0       0       0             0             0             0
                            0       0       0             0             0             0
                            0       0       0             0             0         13000000];

%%  Mooring class
% Moordyn
mooring(1) = mooringClass('mooring');                   % Initialize mooringClass
mooring(1).moorDyn = 1;                                 % Initialize MoorDyn                                                                    
mooring(1).moorDynLines = 3;                            % Specify number of lines
mooring(1).moorDynNodes = 21;                           % Specify number of nodes per line
mooring(1).initial.displacement = [0 0 -89.915-.21];    % Initial Displacement (body cg + body initial displacement)

%% Windturbine class

windTurbine(1) = windTurbineClass('NREL5MW');                                                                                             % Initialize turbine size and Specify Type
windTurbine(1).control = 1;                                                                                                               % Controltype: 0-->Baseline, 1-->ROSCO 
windTurbine(1).aeroLoadsName = fullfile('mostData','windTurbine','aeroloads','aeroloads_5MW.mat');                                        % Aeroloads filename
windTurbine(1).turbineName = fullfile('mostData','windTurbine','turbine_properties','Properties_5MW.mat');                                % Windturbine properties filename
windTurbine(1).controlName = fullfile('mostData','windTurbine','control','Control_5MW.mat');                                              % Controller filename
windTurbine(1).omega0 = 7.55*pi/30;                                                                                                       % Initial value for rotor speed

%% Wind class

wind = windClass('turbulent');                                                                          % Initialize windClass with windtype as input: constant or turbulent
wind.turbSimFile = fullfile('mostData','turbSim',strcat('WIND_',num2str(12),'mps.mat'));                % Turbulent wind filename
wind.meanVelocity = 12;                                                                                 % Wind mean speed

%% PTO and Constraint Parameters
% Floating (6DOF) Joint
constraint(1) = constraintClass('floating'); % Initialize Constraint Class for Constraint1
constraint(1).location = [0 0 0];               % Constraint Location [m]

% Translational PTO
pto(1) = ptoClass('PTO1');                      % Initialize PTO Class for PTO1
pto(1).stiffness = 0;                           % PTO Stiffness [N/m]
pto(1).damping = 1200000;                       % PTO Damping [N/(m/s)]
pto(1).location = [0 0 0];                      % PTO Location [m]