function [V_o,m_o,h_o,n_o,a_o,b_o,r_o,t_o] = OLMI(I0,T0)
    dt     = 0.01;
    T      = ceil(T0/dt);
    C_o      = 1.3;
    gL_o   = 0.05;
    gNa_o  = 30;
    gK_o   = 23;
    gA_o   = 16;
    gh_o   = 12;
    VNa_o  = 90;
    VK_o   = -100;
    VA_o   = -90;
    Vh_o   = -32.9;
    VL_o   = -70;
    ta     = 5;
    t_o    = (1:T)*dt;
    V_o    = zeros(T,1);
    m_o    = zeros(T,1);
    h_o    = zeros(T,1);
    n_o    = zeros(T,1);
    a_o    = zeros(T,1);
    b_o    = zeros(T,1);
    r_o    = zeros(T,1);
    V_o(1) = -75.61; 
    m_o(1) = 0.0122;
    h_o(1) = 0.9152;
    n_o(1) = 0.07561;
    a_o(1) = 0.0229;
    b_o(1) = 0.2843;
    r_o(1) = 0.06123;

    for i=1:T-1
        V_o(i+1) = V_o(i) + dt * ((gNa_o * (m_o(i)^3) * h_o(i) * (VNa_o - V_o(i))) + (gK_o * (n_o(i)^4) * (VK_o - V_o(i))) + (gA_o * a_o(i) * b_o(i) * (VA_o - V_o(i))) + (gh_o * r_o(i) * (Vh_o - V_o(i))) + (gL_o * (VL_o - V_o(i))) + I0)/C_o;
        m_o(i+1) = m_o(i) + dt * (m_o_inf(V_o(i)) - m_o(i))/tm(V_o(i));
        h_o(i+1) = h_o(i) + dt * (h_o_inf(V_o(i)) - h_o(i))/th(V_o(i));
        n_o(i+1) = n_o(i) + dt * (n_o_inf(V_o(i)) - n_o(i))/tn(V_o(i));
        a_o(i+1) = a_o(i) + dt * (a_o_inf(V_o(i)) - a_o(i))/ta;
        b_o(i+1) = b_o(i) + dt * (b_o_inf(V_o(i)) - b_o(i))/tb(V_o(i));
        r_o(i+1) = r_o(i) + dt * (r_o_inf(V_o(i)) - r_o(i))/tr(V_o(i));

    end
end

function m_inf = m_o_inf(V)
m_inf = (alpha_m(V))/(alpha_m(V) + beta_m(V));
end

function h_inf = h_o_inf(V)
h_inf = (alpha_h(V))/(alpha_h(V) + beta_h(V));
end

function n_inf = n_o_inf(V)
n_inf = (alpha_n(V))/(alpha_n(V) + beta_n(V));
end

function a_inf = a_o_inf(V)
a_inf = 1/(1 + exp(-(V + 14)/16.6));
end

function b_inf = b_o_inf(V)
b_inf = 1/(1 + exp((V + 71)/7.3));
end

function r_inf = r_o_inf(V) 
r_inf = 1/(1 + exp((V + 84)/10.2));
end

function tM = tm(V)
tM = 1/(alpha_m(V) + beta_m(V));
end

function tH = th(V)
tH = 1/(alpha_h(V) + beta_h(V));
end

function tN = tn(V)
tN = 1/(alpha_n(V) + beta_n(V));
end

function tB = tb(V)
tB = 1/((0.000009/(exp((V - 26)/18.5))) + (0.014/(0.2 + (exp(-(V + 70)/11)))));
end

function tR = tr(V)
tR = 1/(((exp(-14.59 - 0.086 * V)) + exp(-1.87 + 0.0701 * V)));
end

function aM = alpha_m(V)
aM = -0.1 * (V+38)/(exp(-(V + 38)/10)-1);
end

function bM = beta_m(V)
bM = 4 * exp(-(V + 65)/18);
end

function aH = alpha_h(V)
aH = 0.07 * exp(-(V + 63)/20);
end

function bH = beta_h(V)
bH = 1/(exp(-(V + 33)/10));
end

function aN = alpha_n(V)
aN = 0.018 * (V - 25)/(1 - exp(-(V - 25)/25));
end

function bN = beta_n(V)
bN = 0.0036 * (V - 35)/(exp((V - 35)/12)-1);
end
