clc;
clear all
close all

a1 = 0.02;
b1 = 0.2;
c1 = -65;
d1 = 8;


a2 = 0.1;
b2 = 0.2;
c2 = -65;
d2 = 2;

a3 = 0.02;
b3 = 0.25;
c3 = -65;
d3 = 2;




T0 = 100; 
dt = 0.01; 
T = ceil(T0/dt);
I_pre = 10; 

v1(1) = -65; 
u1(1) = b1 * v1;

v2(1) = -65; 
u2(1) = b2 * v2;

v3(1) = -65;
u3(1) = b3 * v3;

t = linspace(0, T0);
% Synaptic weight
gII = 0.1; gOI = 0.2; gIO = 0.5; gIE = 0.1; %gOE = 0.1; 
gEI = 0.1;
gEO = 0.01; IE = 1.3; II = 0.8; IO = -1; gOE = 0.08;

v_peak = 30; 
for i=1:T-1

    v1(i+1) = v1(i) + ((0.04 * v1(i)^2) + (5 * v1(i)) + 140 - u1(i) + I_pre)*dt;
    u1(i+1) = u1(i)+ (a1 * (b1 * v1(i) - u1(i)))*dt;
    if v1(i) >= v_peak
        v1(i) = c1;
        u1(i) = u1(i) + d1;
    end
end

for i=1:T-1

    v2(i+1) = v2(i) + ((0.04 * v1(1)^2) + (5 * v1(1)) + 140 - u1(1) + gEI*I_pre)*dt;
    u2(i+1) = u2(i) + (a2 * (b2 * v2(i) - u2(i)))*dt;
    if v2(i) >= v_peak
        v2(i) = c2; 
        u2(i) = u2(i) + d2; 
    end
    v3(i+1) = v3(i) + ((0.04 * v1(1)^2) + (5 * v1(1)) + 140 - u1(1) + gEO*I_pre)*dt;
    u3(i+1) = u3(i) + (a3 * (b3 * v3(i) - u3(i)))*dt;
    if v3(i) >= v_peak
        v3(i) = c3;
        u3(i) = u3(i) + d3; 
    end
    v3(i+1) = v3(i) + ((0.04 * v2(i)^2) + (5 * v2(i)) + 140 - u2(i) + gIO*I_pre)*dt;
    u3(i+1) = u3(i) + (a3 * (b3 * v3(i) - u3(i)))*dt;
    if v3 >= v_peak
        v3(i) = c3; 
        u3(i) = u3(i) + d3; 
    end
    v2(i+1) = v2(i) + ((0.04 * v3(i)^2) + (5 * v3(i)) + 140 - u3(i) + gOI*I_pre)*dt;
    u2(i+1) = u2(i) + (a2 * (b2 * v2(i) - u2(i)))*dt;
    if v2(i) >= v_peak
        v2(i) = c2; 
        u2(i) = u2(i) + d2; 
    end
    v2(i+1) = v2(i) + ((0.04 * v2(i)^2) + (5 * v2(i)) + 140 - u2(i) + gII*I_pre)*dt;
    u2(i+1) = u2(i) + (a2 * (b2 * v2(i) - u2(i)))*dt;
    if v2(i) >= v_peak
        v2(i) = c2;
        u2(i) = u2(i) + d2; 
    end
    v1(i+1) = v1(i) + ((0.04 * v2(i)^2) + (5 * v2(i)) + 140 - u2(i) + gIE*I_pre)*dt;
    u1(i+1) = u1(i) + (a2 * (b2 * v2(i) - u2(i)))*dt;
    if v1(i) >= v_peak
        v1(i) = c1; 
        u1(i) = u1(i) + d2; 
    end
    v1(i+1) = v1(i) + ((0.04 * v3(i)^2) + (5 * v3(i)) + 140 - u3(i) + gOE*I_pre)*dt;
    u1(i+1) = u1(i) + (a2 * (b2 * v2(i) - u2(i)))*dt;
    if v2(i) >= v_peak
        v2(i) = c2;
        u2(i) = u2(i) + d2; 
    end
    
end


% Plot membrane potential of postsynaptic neuron
time = 1:length(v1);
figure;
subplot(2,1,1);
plot(time, v1);
xlabel('Time (ms)');
ylabel('Membrane Potential (mV) ');
title('Membrane Potential of Postsynaptic Neuron @ I = 5');

subplot(2,1,2);
plot(time, u1);
xlabel('Time (ms)');
ylabel('Recovery Variable u ');
title('recovery variable @ I = 5');
y = fft(v1);
y2 = abs(y);

sd = 0.05;        
prf = 1;          
ff = 50000000;   
cpp = 2500000;   
wave_length = 10000;


fs = wave_length / sd; 
t1 = linspace(0, sd, wave_length); 


Us = 4*sin(2 * pi * ff * t1);


num_pulses = ceil(prf * sd);
ultrasound_wave = repmat(Us, 1, num_pulses);


ultrasound_wave = ultrasound_wave(1:wave_length);


for i = 1:length(v1)
    
    if v1(i) > 0
        peak_value = v1(i); 
        peak_index = i;         
        effect = ultrasound_wave + v1;
    end
   
    if v1(i) < 0
        trough_value = v1(i); 
        trough_index = i;        
        effect1 = v1;
    end
end
p=(u1)';
figure;
subplot(2,1,1);
plot(time, effect);
xlabel('Time (ms)');
ylabel('Membrane Potential (mV) ');
title('Effect of Ultrasound to Peak of the Theta wave');

subplot(2,1,2);
plot(time, effect1);
xlabel('Time (ms)');
ylabel('Membrane Potential (mV) ');
title('Effect of Ultrasound to trough of the Theta wave');
%1:54,55:106,107:156,157:204;