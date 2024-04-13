import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

specimen1 = pd.read_csv('D:\Srivatsan\HSA-gripper-files\FPU50 Characterization\specimen1.csv')
specimen2 = pd.read_csv('D:\Srivatsan\HSA-gripper-files\FPU50 Characterization\specimen2.csv')
specimen3 = pd.read_csv('D:\Srivatsan\HSA-gripper-files\FPU50 Characterization\specimen3.csv')

# process specimen data to extract data up to 1 mm

FEA_data = pd.read_csv('D:\Srivatsan\HSA-gripper-files\FPU50 Characterization\FEA-FPU50-tensile.csv') # FEA data

data1 = specimen1[specimen1['Displacement'] < 1]
data2 = specimen2[specimen2['Displacement'] < 1]
data3 = specimen3[specimen3['Displacement'] < 1]

# plotting the data

plt.figure()
plt.plot(data1['Displacement'], data1['Force'])
plt.plot(data2['Displacement'], data2['Force'])
plt.plot(data3['Displacement'], data3['Force'])

plt.title("Force Displacement Curve")
plt.xlabel("Displacement $[mm]$")
plt.ylabel("Force $[N]$")
plt.legend(['Specimen 1', 'Specimen 2', 'Specimen 3'])


specimen_thickness = 3.4 # in mm
specimen_width = 6 # in mm


def stress_strain(force, displacement):
    area = specimen_thickness * specimen_width # cross sectional area of the specimen

    stress = force / area
    strain = displacement / 65 # change in length / original: dog bone

    return stress, strain

stress1, strain1 = stress_strain(data1['Force'], data1['Displacement'])
stress2, strain2 = stress_strain(data2['Force'], data2['Displacement'])
stress3, strain3 = stress_strain(data3['Force'], data3['Displacement'])


plt.figure()
plt.plot(strain1, stress1)
plt.plot(strain2, stress2)
plt.plot(strain3, stress3)
plt.title("Stress Strain Curve")
plt.xlabel("Strain $[-]$")
plt.ylabel("Stress $[N/mm^2]$")
plt.legend(['Specimen 1', 'Specimen 2', 'Specimen 3'])


model = LinearRegression()

stress2 = np.array(stress2).reshape(-1, 1) # using specimen 2
strain2= np.array(strain2).reshape(-1, 1)
model.fit(strain2, stress2[0:65])

fit_line_data = model.predict(strain2)

plt.figure()
plt.plot(strain2, fit_line_data, 'b--', label = 'Fit Line')
plt.plot(strain2, stress2[0:65], 'k-', label = 'Data', linewidth = 0.5)
plt.legend()
plt.show()


# FEA data analysis

force_data = FEA_data['Force1']
disp_data = FEA_data['Displacement1']
new_data = FEA_data[FEA_data['Displacement1'] < 1] # displacement less than 1 mm

new_force_data = new_data['Force1']
new_disp_data = new_data['Displacement1']

new_data

def stress_strain_FEA(force, displacement):
    area = specimen_thickness * specimen_width # cross sectional area of the specimen

    stress = force / area
    strain = displacement / 33 # change in length / original: FEA model

    return stress, strain

stress, strain = stress_strain_FEA(new_force_data, new_disp_data)


stress_strain_data = {'Stress':stress, 'Strain': strain}
df = pd.DataFrame(stress_strain_data)
# df

area = specimen_thickness * specimen_width
Youngs_modulus_N = (df.iloc[-1]['Stress'] - df.iloc[0]['Stress']) / (df.iloc[-1]['Strain'] - df.iloc[0]['Strain'])

print("FEA: Young's Modulus (in MPa) = ", Youngs_modulus_N)
print("ASTM Type IV: Young's Modulus (in MPa) = ", model.coef_[0])
# stress_strain_data
plt.figure()
plt.plot(disp_data, force_data, label = 'FEA data')
plt.plot(specimen2['Displacement'], specimen2['Force'], label = 'Specimen 2')

plt.title("Force Displacement Curve - FPU50")
plt.xlabel("Displacement $[mm]$")
plt.ylabel("Force $[N]$")
plt.legend()
plt.show()

plt.figure()
plt.plot(strain2, stress2, label = 'Specimen')
plt.plot(df['Strain'], df['Stress'], label = 'FEA data')

plt.title("Stress Strain Curve - FPU50")
plt.xlabel("Strain $[-]$")
plt.ylabel("Stress $[N/mm^2]$")
plt.legend()
plt.show()

# df.to_csv('stress-strain-PA6-FEA.csv')

'''
This is a comment block
'''