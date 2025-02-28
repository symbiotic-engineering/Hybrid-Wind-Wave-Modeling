function bladedata = BladeData()
%% Function to create bladedata struct
load('Properties_5MW');

%% Blade
bladefile=importdata('BladeData/NRELOffshrBsline5MW_AeroDyn_blade.dat',' ',6);
bladedata.radius=bladefile.data(:,1)+WTcomponents.hub.Rhub;
bladedata.BlCrvAC=bladefile.data(:,2);
bladedata.BlSwpAC=bladefile.data(:,3);
bladedata.BlCrvAng=bladefile.data(:,4);
bladedata.twist=bladefile.data(:,5);
bladedata.chord=bladefile.data(:,6);
bladedata.airfoil_index=bladefile.data(:,7);

%% Airfoils
airfoilfile=importdata(['BladeData/airfoil' num2str(1) '.dat'],' ',54);
bladedata.airfoildata=zeros(size(airfoilfile.data,2),size(airfoilfile.data,2),length(bladedata.airfoil_index));

for i=1:8
airfoilfile=importdata(['BladeData/airfoil' num2str(i) '.dat'],' ',54);
bladedata.airfoildata(1:size(airfoilfile.data,1),:,i)=airfoilfile.data;
end


%%

bladedata.airfoil (:,:,1) = bladedata.airfoildata(:,:,1);
bladedata.airfoil (:,:,2) = bladedata.airfoildata(:,:,1);
bladedata.airfoil (:,:,3) = bladedata.airfoildata(:,:,1);
bladedata.airfoil (:,:,4) = bladedata.airfoildata(:,:,2);
bladedata.airfoil (:,:,5) = bladedata.airfoildata(:,:,3);
bladedata.airfoil (:,:,6) = bladedata.airfoildata(:,:,4);
bladedata.airfoil (:,:,7) = bladedata.airfoildata(:,:,4);
bladedata.airfoil (:,:,8) = bladedata.airfoildata(:,:,5);
bladedata.airfoil (:,:,9) = bladedata.airfoildata(:,:,6);
bladedata.airfoil (:,:,10) = bladedata.airfoildata(:,:,6);
bladedata.airfoil (:,:,11) = bladedata.airfoildata(:,:,7);
bladedata.airfoil (:,:,12) = bladedata.airfoildata(:,:,7);
bladedata.airfoil (:,:,13) = bladedata.airfoildata(:,:,8);
bladedata.airfoil (:,:,14) = bladedata.airfoildata(:,:,8);
bladedata.airfoil (:,:,15) = bladedata.airfoildata(:,:,8);
bladedata.airfoil (:,:,16) = bladedata.airfoildata(:,:,8);
bladedata.airfoil (:,:,17) = bladedata.airfoildata(:,:,8);
bladedata.airfoil (:,:,18) = bladedata.airfoildata(:,:,8);
bladedata.airfoil (:,:,19) = bladedata.airfoildata(:,:,8);






%% Save
save('Bladedata_5MW.mat','bladedata')

end
