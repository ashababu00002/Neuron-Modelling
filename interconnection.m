I0 = 10;
T0 = 150;

[V,h,n,t]                         = HH0(I0,T0);
[V_f,h_f,n_f,t_f]                 = FSN(I0, T0);
[V_o,m_o,h_o,n_o,a_o,b_o,r_o,t_o] = OLMI(I0,T0);
I_E_feedback                      = (V+V_o)-(V+V_f)-(V_f+V_f) - (V_o+V_f);
V_feedback                        = V - I_E_feedback;

subplot(2,1,1);
plot (t,V,'k');
hold on
plot(t,V_feedback,'r');
hold off
title ('Pyramidal cell excitation');
xlabel('Time (mS)');
ylabel('Voltage (mV)')
legend ('V', 'V_feedback')

subplot(2,1,2);
plot(t,h,'b');
hold on
plot (t,n,'g');
hold off;
title ('Gates');
xlabel('Time (mS)');
ylabel('Voltage (mV)')
legend ('h','n') ;
b = normalize(V_feedback);
