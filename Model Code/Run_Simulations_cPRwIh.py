#!/usr/bin/env python
# coding: utf-8

# In[4]:


######################################################################################
# Two-compartment hippocampal CA3 pyramidal neuron model with smooth activation 
# functions and hyperpolarized-activated cation current, 2021.
# A variant of original Pinsky-Rinzel neuron model, 1994.

# Contact: Bilal (bilalghori87@gmail.com) 
######################################################################################

# Plot Supplementary Figure 8a

import numpy as np
import time
import os
import scipy.io as sio
import matplotlib.pyplot as plt
from cPRmodel_Ih import solve_cPRmodel_Ih

start_time = time.time()

t_dur      = 1000          # [ms]
g_c        = 2.1           # [mS/cm^2] Weak
I_stim_s   = -0.5          # [uA/cm^2]
I_stim_d   = 2.27          # [uA/cm^2]
stim_start = 0.2*t_dur     # [ms]
stim_end   = 0.8*t_dur     # [ms]

# Zero state
#g_h       = 0.0           # [mS/cm^2]
#Vi_half   = -85+60        # [mV]

# Control state
g_h        = 0.03          # [mS/cm^2]
Vi_half    = -81+60        # [mV]

# Low level Ih upregulation state
#g_h       = 0.035         # [mS/cm^2]
#Vi_half   = -78+60        # [mV]

# Intermediate level Ih upregulation state
#g_h        = 0.04         # [mS/cm^2]
#Vi_half    = -75+60       # [mV]

# Highest level Ih upregulation state
#g_h        = 0.06         # [mS/cm^2]
#Vi_half    = -71+60       # [mV]

E_h = -25                  # [mV]

Ih_flag   =  1
print('=====================================================================')
print('Coupling conductance, gc = ',g_c,'mS/cm^2')
print('Somatic stimulation at Is = ',I_stim_s,'uA/cm^2')
print('Dendritic stimulation at Is = ',I_stim_d,'uA/cm^2')
print('maximal conductance, gh = ',g_h,'mS/cm^2')
print('half-activation voltage, Vi_half = ',Vi_half ,'mV')
print('reversal voltage, E_h = ',E_h ,'mV')
print('=====================================================================')


sol = solve_cPRmodel_Ih(t_dur, g_c,g_h,Vi_half,E_h,Ih_flag,I_stim_s, I_stim_d, stim_start, stim_end)

Vs, Vd, n, h, s, c, q, i, Ca = sol.y
t = sol.t

# Compute Ih current

I_h = g_h*i*(Vd-E_h)

print('elapsed time: ', round(time.time() - start_time, 1), 'seconds')


if not os.path.exists('figures'):
       os.makedirs('figures')
        
# plot
f1 = plt.figure(1)
plt.plot(t,I_h,'-', label='Ih')
plt.title('Ih current')
plt.xlabel('time [ms]')
plt.ylabel('I [uA/cm^2]')
plt.legend(loc='upper right')

plt.savefig('figures/figure1.tif',dpi=300)
plt.show()

# plot
f2 = plt.figure(2)
plt.plot(t, Vs, '-', label='Vs')
plt.plot(t, Vd, '-', label='Vd')
plt.title('Membrane potentials')
plt.xlabel('time [ms]')
plt.ylabel('V [mV]')
plt.legend(loc='upper right')

plt.savefig('figures/figure2.tif',dpi=300)
plt.show()


# plot
f3 = plt.figure(3)
plt.plot(t, Ca, '-', label='Ca')
plt.title('Calcium level')
plt.xlabel('time [s]')
plt.ylabel('Ca')
plt.legend(loc='upper right')

plt.savefig('figures/figure3.tif',dpi=300)
plt.show()


f4 = plt.figure(4)
plt.plot(t, n, '-', label='n')
plt.plot(t, h, '-', label='h')
plt.plot(t, s, '-', label='s')
plt.plot(t, c, '-', label='c')
plt.plot(t, q, '-', label='q')
plt.plot(t, i, '-', label='i')
plt.title('Gating Kinetics')
plt.xlabel('time [ms]')
plt.legend(loc='upper right')

plt.savefig('figures/figure4.tif',dpi=300)
plt.show()



# save to file

if not os.path.exists('data/Supplementary_FigS8a'):
       os.makedirs('data/Supplementary_FigS8a')
        

filename='data/Supplementary_FigS8a/cPRmodel_Ih_control_Is_-0.5_Id_2.27_FigS8.mat'

sio.savemat(filename,{'time':t,'Vs':Vs,'Vd':Vd,'n':n,'h':h,'s':s,'c':c,'q':q,'i':i,'Ca':Ca,'g_h':g_h,'E_h':E_h, 'Ih':g_h*i*(Vd-E_h)})


print('=====================================================================')
print('Supplementary Figure 8a data is generated...')
print('=====================================================================')



# Plot Supplementary Figure 8a

t_dur      = 1000          # [ms]
g_c        = 2.1           # [mS/cm^2] Weak
I_stim_s   = -0.5          # [uA/cm^2]
I_stim_d   = 15            # [uA/cm^2]
stim_start = 0.2*t_dur     # [ms]
stim_end   = 0.8*t_dur     # [ms]

# Zero state
#g_h       = 0.0           # [mS/cm^2]
#Vi_half   = -85+60        # [mV]

# Control state
g_h        = 0.03          # [mS/cm^2]
Vi_half    = -81+60        # [mV]

# Low level Ih upregulation state
#g_h       = 0.035         # [mS/cm^2]
#Vi_half   = -78+60        # [mV]

# Intermediate level Ih upregulation state
#g_h        = 0.04         # [mS/cm^2]
#Vi_half    = -75+60       # [mV]

# Highest level Ih upregulation state
#g_h        = 0.06         # [mS/cm^2]
#Vi_half    = -71+60       # [mV]

E_h = -25                  # [mV]

Ih_flag   =  1
print('=====================================================================')
print('Coupling conductance, gc = ',g_c,'mS/cm^2')
print('Somatic stimulation at Is = ',I_stim_s,'uA/cm^2')
print('Dendritic stimulation at Is = ',I_stim_d,'uA/cm^2')
print('maximal conductance, gh = ',g_h,'mS/cm^2')
print('half-activation voltage, Vi_half = ',Vi_half ,'mV')
print('reversal voltage, E_h = ',E_h ,'mV')
print('=====================================================================')


sol = solve_cPRmodel_Ih(t_dur, g_c,g_h,Vi_half,E_h,Ih_flag,I_stim_s, I_stim_d, stim_start, stim_end)

Vs, Vd, n, h, s, c, q, i, Ca = sol.y
t = sol.t

# Compute Ih current

I_h = g_h*i*(Vd-E_h)

print('elapsed time: ', round(time.time() - start_time, 1), 'seconds')


if not os.path.exists('figures'):
       os.makedirs('figures')
        
# plot
f1 = plt.figure(1)
plt.plot(t,I_h,'-', label='Ih')
plt.title('Ih current')
plt.xlabel('time [ms]')
plt.ylabel('I [uA/cm^2]')
plt.legend(loc='upper right')

plt.savefig('figures/figure5.tif',dpi=300)
plt.show()

# plot
f2 = plt.figure(2)
plt.plot(t, Vs, '-', label='Vs')
plt.plot(t, Vd, '-', label='Vd')
plt.title('Membrane potentials')
plt.xlabel('time [ms]')
plt.ylabel('V [mV]')
plt.legend(loc='upper right')

plt.savefig('figures/figure6.tif',dpi=300)
plt.show()


# plot
f3 = plt.figure(3)
plt.plot(t, Ca, '-', label='Ca')
plt.title('Calcium level')
plt.xlabel('time [s]')
plt.ylabel('Ca')
plt.legend(loc='upper right')

plt.savefig('figures/figure7.tif',dpi=300)
plt.show()


f4 = plt.figure(4)
plt.plot(t, n, '-', label='n')
plt.plot(t, h, '-', label='h')
plt.plot(t, s, '-', label='s')
plt.plot(t, c, '-', label='c')
plt.plot(t, q, '-', label='q')
plt.plot(t, i, '-', label='i')
plt.title('Gating Kinetics')
plt.xlabel('time [ms]')
plt.legend(loc='upper right')

plt.savefig('figures/figure8.tif',dpi=300)
plt.show()



# save to file

if not os.path.exists('data/Supplementary_FigS8b'):
       os.makedirs('data/Supplementary_FigS8b')
        

filename='data/Supplementary_FigS8b/cPRmodel_Ih_control_Is_-0.5_Id_15_FigS8.mat'

sio.savemat(filename,{'time':t,'Vs':Vs,'Vd':Vd,'n':n,'h':h,'s':s,'c':c,'q':q,'i':i,'Ca':Ca,'g_h':g_h,'E_h':E_h, 'Ih':g_h*i*(Vd-E_h)})

print('=====================================================================')
print('Supplementary Figure 8b data is generated...')
print('=====================================================================')



# In[ ]:




