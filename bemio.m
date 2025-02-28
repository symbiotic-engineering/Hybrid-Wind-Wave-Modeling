hydro = struct();

caseFolder = pwd;

hydro = readNEMOH(hydro,caseFolder);
hydro = radiationIRF(hydro,60,[],[],[],[]);
hydro = radiationIRFSS(hydro,[],[]);
hydro = excitationIRF(hydro,157,[],[],[],[]);

hydroDataDir = fullfile(caseFolder, 'hydroData');

if ~exist(hydroDataDir, 'dir')
    mkdir(hydroDataDir);
end

cd(hydroDataDir);

writeBEMIOH5(hydro)
plotBEMIO(hydro)

cd(caseFolder)

close all