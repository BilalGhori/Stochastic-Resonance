from scipy.integrate import solve_ivp, odeint
import numpy as np


def solve_cPRmodel_noIh(t_dur, g_c, I_stim_s, I_stim_d, stim_start, stim_end):
    C_m = 3      # membrane capacitance [uF cm**-2]
    p = 0.5      # proportion of the membrane area taken up by the soma
    g_L = 0.1    # [mS cm**-2]
    g_Na = 30    # [mS cm**-2]
    g_KDR = 15   # [mS cm**-2]
    g_Ca = 10    # [mS cm**-2]
    g_KCa = 15   # [mS cm**-2]
    g_KAHP = 0.8 # [mS cm**-2]

    E_L = -60   # [mV]
    E_Na = 60   # [mV]
    E_K = -75   # [mV]
    E_KAHP =-75 # [mV]
    E_Ca = 80   # [mV]
    E_KCa = -75 # [mV]
    
   
                   
# Activation/in-activation Gatting Kinetics   
    

    def alpha_m(Vs):
        V1 = Vs + 46.9
        alpha = - 0.32 * V1 / (np.exp(-V1 / 4.) - 1.)
        return alpha

    def beta_m(Vs):
        V2 = Vs + 19.9
        beta = 0.28 * V2 / (np.exp(V2 / 5.) - 1.)
        return beta
    
    def alpha_n(Vs):
        V3 = Vs + 24.9
        alpha = - 0.016 * V3 / (np.exp(-V3 / 5.) - 1)
        return alpha

    def beta_n(Vs):
        V4 = 0.025*Vs + 1.
        beta = 0.25 * np.exp(-V4)
        return beta

    def alpha_h(Vs):
        V5= Vs
        alpha = 0.128 * np.exp((-43. - V5) / 18.)
        return alpha

    def beta_h(Vs):
        V6 = Vs + 20.
        beta = 4. / (1 + np.exp(-V6 / 5.))
        return beta

    
    def alpha_s(Vd):
        V7= Vd
        alpha = 1.6 / (1 + np.exp(-0.072 * (V7-5.)))
        return alpha

    def beta_s(Vd):
        V6 = Vd + 8.9
        beta = 0.02 * V6 / (np.exp(V6 / 5.) - 1.)
        return beta
        
    def m_inf(Vs):
        return alpha_m(Vs) / (alpha_m(Vs) + beta_m(Vs))
  
    def taum(Vs):
        return 1 / (alpha_m(Vs) + beta_m(Vs))
    
    def n_inf(Vs):
        return alpha_n(Vs) / (alpha_n(Vs) + beta_n(Vs))
    
    def taun(Vs):
        return 1 / (alpha_n(Vs) + beta_n(Vs))
    
    def h_inf(Vs):
        return alpha_h(Vs) / (alpha_h(Vs) + beta_h(Vs))
    
    def tauh(Vs):
        return 1 / (alpha_h(Vs) + beta_h(Vs))
    
    def s_inf(Vd):
        return alpha_s(Vd) / (alpha_s(Vd) + beta_s(Vd))
    
    def taus(Vd):
        return 1 / (alpha_s(Vd) + beta_s(Vd))
    
    def c_inf(Vd):
        V8=Vd
        return (1.0/(1.0 + np.exp((-10.1 - V8)/0.1016)))**0.00925

    def tauc(Vd):
        V9=Vd
        return (3.627*np.exp(0.03704*V9))

    def q_inf(Ca):
        return (0.7894*np.exp(0.0002726*Ca))-(0.7292*np.exp(-0.01672*Ca))

    def tauq(Ca):
        return (657.9*np.exp(-0.02023*Ca))+(301.8*np.exp(-0.002381*Ca))

    def Chi(Ca):
        return (1.073*np.sin(0.003453*Ca+0.08095) + 0.08408*np.sin(0.01634*Ca-2.34) +0.01811*np.sin(0.0348*Ca-0.9918))
    
   

    

    def dVdt(t, V):
       
        Vs, Vd, n, h, s, c, q, Ca = V

        I_leak_s = g_L*(Vs - E_L)
        I_leak_d = g_L*(Vd - E_L)
        I_Na = g_Na * m_inf(Vs)**2 * h * (Vs - E_Na)
        I_DR = g_KDR * n * (Vs - E_K)
        I_ds = g_c * (Vd - Vs)
        
        I_Ca = g_Ca * s**2 * (Vd - E_Ca)
        I_KCa = g_KCa * c*Chi(Ca)* (Vd - E_KCa)
        I_KAHP = g_KAHP * q * (Vd - E_KAHP)
          
        I_sd = -I_ds 
        if t>stim_start and t<stim_end:
            dVsdt = (1./C_m)*( -I_leak_s - I_Na - I_DR + I_ds/p + I_stim_s/p )
        else:
            dVsdt = (1./C_m)*( -I_leak_s - I_Na - I_DR + I_ds/p)
            
      
       
           
        dVddt = (1./C_m)*( -I_leak_d - I_Ca - I_KCa - I_KAHP + I_sd/(1-p) + I_stim_d/(1-p))
        dndt = (n_inf(Vs) - n)/taun(Vs)
        dhdt = (h_inf(Vs) - h)/tauh(Vs)
        dsdt = (s_inf(Vd) - s)/taus(Vd)
        dcdt = (c_inf(Vd) - c)/tauc(Vd)
        dqdt = (q_inf(Ca) - q)/tauq(Ca)
        dCadt = -0.13*I_Ca - 0.075*Ca

        return dVsdt, dVddt, dndt, dhdt, dsdt, dcdt, dqdt, dCadt

    t_span = (0, t_dur)

    Vs0 = -64.74602
    Vd0 = -64.62836
    n0  = 0.0004751724
    h0  = 0.9987894
    s0  = 0.00939306
    c0  = 0.00698
    q0  = 0.06293
    i0  = 0.9999898
    Ca0 = 0.2211822
    
    
  
    V0 = [Vs0, Vd0, n0, h0, s0, c0, q0, Ca0]

    sol = solve_ivp(dVdt, t_span, V0, max_step=0.05)

    return sol

