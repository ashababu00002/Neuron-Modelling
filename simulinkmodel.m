clear all;
close all;
clc;
pars=[0.02  0.2  -65  8  14;
      0.1   0.2  -65  2  15;
      0.02  0.25 -65  2  20];

a = pars(1,1);
b = pars(1,2);
c = pars(1,3);
d = pars(1,4);
I = pars(1,5);

a1 = pars(2,1);
b1 = pars(2,2);
c1 = pars(2,3);
d1 = pars(2,4);
I1 = pars(2,5);

a2 = pars(3,1);
b2 = pars(3,2);
c2 = pars(3,3);
d2 = pars(3,4);
I2 = pars(3,5);

STOP = 500;

%%
figure;
subplot(2,1,1);
plot(out.tout,out.Pyramidal);
xlabel('Time (ms)');
ylabel('Voltage(mV) @ I = 20 ');
title('Excitation of Regular Spiking cell');
subplot(2,1,2);
plot(out.tout, out.input);
xlabel('Time (ms)');
ylabel('Recovery Variable u @ I = 20 ');
title('recovery variable @ I = 20');