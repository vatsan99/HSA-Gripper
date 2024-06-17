
# This code estimates the Young's Modulus of the characterized material

import pandas as pd
import matplotlib.pyplot as plt

from sklearn.linear_model import LinearRegression

data = pd.read_csv('D:\Srivatsan\HSA-gripper-files\FPU50 Characterization\FEA-PA6-tensile.csv')

force_data = data['Force1']
disp_data = data['Displacement1']

specimen_thickness = 3.4 # in mm
specimen_width = 6 # in mm
original_length = 33 # in mm - distance between the grips

new_length = disp_data + original_length


def stress_strain(force, displacement):
    area = specimen_thickness * specimen_width # cross sectional area of the specimen

    # elastic_region = 
    stress = force / area

    strain = displacement / original_length # change in length / original

    return stress, strain

stress, strain = stress_strain(force_data, disp_data)

stress_strain_data = {'Stress':stress, 'Strain': strain}
df = pd.DataFrame(stress_strain_data) # convert stress-strain data to a dataframe


area = specimen_thickness * specimen_width
Youngs_modulus_N = (df.iloc[-2]['Stress'] - df.iloc[0]['Stress']) / (df.iloc[-2]['Strain'] - df.iloc[0]['Strain'])

print("Young's Modulus (in MPa) = ", Youngs_modulus_N)

plt.figure()
plt.plot(disp_data, force_data)
plt.title("Force Displacement Curve")
plt.xlabel("Displacement $[mm]$")
plt.ylabel("Force $[N]$")
plt.show()

plt.figure()
plt.plot(strain, stress)
plt.title("Stress Strain Curve")
plt.xlabel("Strain $[-]$")
plt.ylabel("Stress $[N/mm^2]$")
plt.show()