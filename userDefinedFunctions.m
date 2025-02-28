%%%%%%%%%%%%%%%%%%
%% Plot Results %%
%%%%%%%%%%%%%%%%%%
%% INITIALIZATION
close all

%% Create a folder for plots
Te = waves.period;
Hs = waves.height;
Type = waves.type;
Config = Configuration;
folder_name = sprintf('plots_%s_%s_%gs%gm', Config, Type, Te, Hs);
folder_name = strrep(folder_name, '.', '');
if ~exist(folder_name, 'dir') % Check if folder already exists
    mkdir(folder_name);
end
save(fullfile(folder_name, 'output.mat'))
%% EXTERNAL INPUTS
% Wind
figure()
plot(output.windTurbine.time, output.windTurbine.windSpeed);
grid off;
title('Wind speed at hub height')
xlabel('Time (s)')
ylabel('(m/s)')

% Maximize and save
set(gcf, 'WindowState', 'maximized');
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
saveas(gcf, fullfile(folder_name, 'Wind speed at hub height.fig'));
saveas(gcf, fullfile(folder_name, 'Wind speed at hub height.png'));

% Waves
waves.plotElevation(simu.rampTime);
grid off
set(gcf, 'WindowState', 'maximized');
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
saveas(gcf, fullfile(folder_name, 'Wave Elevation.fig'));
saveas(gcf, fullfile(folder_name, 'Wave Elevation.png'));

try 
    waves.plotSpectrum();
    grid off
    title('Wave Spectrum')
    set(gcf, 'WindowState', 'maximized');
    set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
    set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
    set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
    saveas(gcf, fullfile(folder_name, 'Wave Spectrum.fig'));
    saveas(gcf, fullfile(folder_name, 'Wave Spectrum.png'));
catch
end

sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
spreadfigures(1:sf);
j = sf + 1;

%% RESPONSE
for nb = 1:length(output.bodies)
    for i = 1:6
        output.plotResponse(nb, i);
        grid off
        Response=gca;
        HydroF_title=Response.Title.String;
        set(gcf, 'WindowState', 'maximized');
        set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
        set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
        set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
        saveas(gcf, fullfile(folder_name,[char(HydroF_title),'.fig']));
        saveas(gcf, fullfile(folder_name,[char(HydroF_title),'.png']));
    end
    sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
    spreadfigures(j:sf);
    j = sf + 1;
end

%% ROTOR SPEED/Power
figure()
plot(output.windTurbine.time, output.windTurbine.rotorSpeed);
grid off;
title('Rotor Speed')
xlabel('Time (s)')
ylabel('(rmp)')
set(gcf, 'WindowState', 'maximized');
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
saveas(gcf, fullfile(folder_name, 'Rotor Speed.fig'));
saveas(gcf, fullfile(folder_name, 'Rotor Speed.png'));

figure()
plot(output.windTurbine.time, output.windTurbine.turbinePower);
grid off;
title('Power')
xlabel('Time (s)')
ylabel('(MW)')
set(gcf, 'WindowState', 'maximized');
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
saveas(gcf, fullfile(folder_name, 'Power.fig'));
saveas(gcf, fullfile(folder_name, 'Power.png'));

sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
spreadfigures(j:sf);
j = sf + 1;

%% CONTROLLED INPUTS
% C gen
figure()
plot(output.windTurbine.time, output.windTurbine.genTorque);
grid off;
title('Generator Torque')
xlabel('Time (s)')
ylabel('(Nm)')
set(gcf, 'WindowState', 'maximized');
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
saveas(gcf, fullfile(folder_name, 'Generator Torque.fig'));
saveas(gcf, fullfile(folder_name, 'Generator Torque.png'));

% Bladepitch
figure()
plot(output.windTurbine.time, output.windTurbine.bladePitch);
grid off;
title('Blade Pitch')
xlabel('Time (s)')
ylabel('(deg)')
set(gcf, 'WindowState', 'maximized');
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
saveas(gcf, fullfile(folder_name, 'Blade Pitch.fig'));
saveas(gcf, fullfile(folder_name, 'Blade Pitch.png'));

sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
spreadfigures(j:sf);
j = sf + 1;

%% HYDRO FORCES
for nb = 1:length(output.bodies)
    for i = 1:6
        output.plotForces(nb, i);
        grid off
        HydroF=gca;
        HydroF_title=HydroF.Title.String;
        set(gcf, 'WindowState', 'maximized');
        set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
        set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
        set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
        saveas(gcf, fullfile(folder_name,[char(HydroF_title),'.fig']));
        saveas(gcf, fullfile(folder_name,[char(HydroF_title),'.png']));
    end
    sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
    spreadfigures(j:sf);
    j = sf + 1;
end

%% TOWER LOADS
loadtitles = ["Fx", "Fy", "Fz", "Mx", "My", "Mz"];
for i = 1:6
    figure()
    plot(output.windTurbine.time, output.windTurbine.towerTopLoad(:, i)); 
    hold on
    plot(output.windTurbine.time, output.windTurbine.towerBaseLoad(:, i)); 
    grid off
    title(join(['Tower Loads: ' loadtitles(i)]));
    xlabel('Time (s)');
    ylabel('(N) or (Nm)');
    legend('Tower Top', 'Tower Base', 'Location', 'best');
    set(gcf, 'WindowState', 'maximized');
    set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
    set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
    set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
    saveas(gcf, fullfile(folder_name, sprintf('Tower_Loads_%s.fig', loadtitles(i))));
    saveas(gcf, fullfile(folder_name, sprintf('Tower_Loads_%s.png', loadtitles(i))));
end
sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
spreadfigures(j:sf);
j = sf + 1;

%% BLADE1 LOADS
for i = 1:6
    figure()
    plot(output.windTurbine.time, output.windTurbine.bladeRootLoad(:, i)); 
    grid off
    title(join(['Blade1 Loads: ' loadtitles(i)]));
    xlabel('Time (s)');
    ylabel('(N) or (Nm)');
    set(gcf, 'WindowState', 'maximized');
    set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
    set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
    set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
    saveas(gcf, fullfile(folder_name, sprintf('Blade1_Loads_%s.fig', loadtitles(i))));
    saveas(gcf, fullfile(folder_name, sprintf('Blade1_Loads_%s.png', loadtitles(i))));
end
sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
spreadfigures(j:sf);
j = sf + 1;

%% MOORING
for i = 1:6
    figure()
    plot(output.windTurbine.time, output.mooring.forceMooring(:, i)); 
    grid off
    title(join(['Mooring Forces: ' loadtitles(i)]));
    xlabel('Time (s)');
    ylabel('(N) or (Nm)');
    set(gcf, 'WindowState', 'maximized');
    set(findall(gcf, '-property', 'FontSize'), 'FontSize', 18);
    set(findall(gcf, '-property', 'FontWeight'), 'FontWeight', 'bold');
    set(findall(gcf, '-property', 'LineWidth'), 'LineWidth', 2);
    saveas(gcf, fullfile(folder_name, sprintf('Mooring_Forces_%s.fig', loadtitles(i))));
    saveas(gcf, fullfile(folder_name, sprintf('Mooring_Forces_%s.png', loadtitles(i))));
end
sf = length(findobj(allchild(0), 'flat', 'Type', 'figure'));
spreadfigures(j:sf);
j = sf + 1;


close all
