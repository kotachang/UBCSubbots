%% Calculating the various parameters needed for the preamplifier for the
%%AS-1 hydrophone
% Info about the hydrophone can be found at
% https://www.aquarianaudio.com/AqAudDocs/AS-1_manual.pdf. 

% Hydrophone impedance changes as a function of frequency; within our
% specified frequency range, we see a farily linear response between approximately 9k and 4k

%Pre-amp requirements: 
%Gain: Max!
%Bandwidth: Bandpass: 20-45 kHz
% Input Impedance: (Either max or matched). 
% Output Impedance: (Either min or matched). 


%Since we know the low frequency cut-off frequency (20kHz) we can use the
%following formula to find the input impedance: 
low_freq_pole=10000;
Zin=1/(0.000000038*low_freq_pole) 

%We therefore see that our input impedance will be close to being matched
%by the AS-1 (an approximate factor of 2 off). 


%% Figuring out approximatetly how loud the pingers will be, so we can
%%calculate required gain: 

%The pinger used at the robo-sub competition can be found at
%http://www.teledynemarine.com/alp-365-pinger. It's acoustic output is
%power dependent and ranges between 162 dB and 177 dB. I think it's safe to
%assume that the lower power modes will be used at the competition, as
%there will be many pingers operating at the same time in relatively small
%pool space. 

%A helpful seeming source resource on Linear/Nonlinear acoustics
%https://benthowave.com/resources/default.html 

%Sound transmission Loss underwater: 
    %Spherical Spreading
     dist_from_pinger=50; %meters
     Spher_SL=20*log(dist_from_pinger); %spherical spreading loss
    
    %Absorption Coefficient (dB/km): 
    midband_freq= 30; %kHz
    ABS_coef=1.0936*((0.1*midband_freq^2)/(1+midband_freq^2)+40*(midband_freq^2)/(4100+midband_freq^2))
        %Another resource appears to be
        %http://resource.npl.co.uk/acoustics/techguides/seaabsorption/ ,
        %which provides values smaller than the calculation performed
        %above. We'll take a conservative stance and assume greater
        %absorption ~8 dB/km as opposed to the ~5 dB/km provided online
        
   %Scattering Coefficient - Reflects in media - ??
        
        m_to_km=1/1000;
        
 SL=20*(log(PL)+log(dist_from_pinger));
 
 TL= Spher_SL+ ABS_coef*dist_from_pinger*m_to_km;

%Hydrophone Output voltage: 
SPL=162; %Sound pressure level in dB
PL=10^(-6)*10^(SPL/20); %Pressure level in Pa

V=40*10^(-6)*PL %5 mV - We can therefore expect around 5 mV from hydrophone. Therefore to get a signal 0-5 V, we want a gain somewhere around 1000
OCV=-208;

%Vrms=SPL+OCV;

% Receiving Sensitivity: 
R_sensitivity=-208; %dB, referenced to 1 V/uPa
test=((10^((R_sensitivity)/20))*1000000)




