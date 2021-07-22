import numpy as np
from hw9 import CartPoleSystem

def test_inertia_matrix():
	data = np.load('testdata.npz')
	q_vals = data['q_vals']
	q_dot_vals = data['q_dot_vals']
	
	cart_mass_vals = data['cart_mass_vals']
	pole_mass_vals = data['pole_mass_vals']
	L_vals = data['L_vals']

	M_desired = data['M_desired']
	C_desired = data['C_desired']
	N_desired = data['N_desired']

	for i in range(len(q_vals)):
		q = q_vals[i]
		q_dot = q_dot_vals[i]
		cart_mass = cart_mass_vals[i]
		pole_mass = pole_mass_vals[i]
		L = L_vals[i]

		M_des = M_desired[i]
		C_des = C_desired[i]
		N_des = N_desired[i]

		system = CartPoleSystem(cart_mass, pole_mass, L)
		student_M = system.M(q)
		if not np.allclose(student_M, M_des):
			print("Inertia Matrix Test Failed.\n")
			print("Last input:")
			print("q =", q)
			print("cart mass =", cart_mass)
			print("pole mass =", pole_mass)
			print("pole length =", L)
			print()
			print("Your output:")
			print(student_M)
			print()
			print("Desired output:")
			print(M_des)
			return
	print("Inertia Matrix Test Passed.\n")

def test_coriolis_matrix():
	data = np.load('testdata.npz')
	q_vals = data['q_vals']
	q_dot_vals = data['q_dot_vals']
	
	cart_mass_vals = data['cart_mass_vals']
	pole_mass_vals = data['pole_mass_vals']
	L_vals = data['L_vals']

	M_desired = data['M_desired']
	C_desired = data['C_desired']
	N_desired = data['N_desired']

	for i in range(len(q_vals)):
		q = q_vals[i]
		q_dot = q_dot_vals[i]
		cart_mass = cart_mass_vals[i]
		pole_mass = pole_mass_vals[i]
		L = L_vals[i]

		M_des = M_desired[i]
		C_des = C_desired[i]
		N_des = N_desired[i]

		system = CartPoleSystem(cart_mass, pole_mass, L)

		student_C = system.C(q, q_dot)

		if not np.allclose(student_C, C_des):
			print("Coriolis Matrix Test Failed.\n")
			print("Last input:")
			print("q =", q)
			print("q_dot =", q_dot)
			print("cart mass =", cart_mass)
			print("pole mass =", pole_mass)
			print("pole length =", L)
			print()
			print("Your output:")
			print(student_C)
			print()
			print("Desired output:")
			print(C_des)
			return
	print("Coriolis Matrix Test Passed.\n")

def test_gravity_vector():
	data = np.load('testdata.npz')
	q_vals = data['q_vals']
	q_dot_vals = data['q_dot_vals']
	
	cart_mass_vals = data['cart_mass_vals']
	pole_mass_vals = data['pole_mass_vals']
	L_vals = data['L_vals']

	M_desired = data['M_desired']
	C_desired = data['C_desired']
	N_desired = data['N_desired']

	for i in range(len(q_vals)):
		q = q_vals[i]
		q_dot = q_dot_vals[i]
		cart_mass = cart_mass_vals[i]
		pole_mass = pole_mass_vals[i]
		L = L_vals[i]

		M_des = M_desired[i]
		C_des = C_desired[i]
		N_des = N_desired[i]

		system = CartPoleSystem(cart_mass, pole_mass, L)

		student_N = system.N(q)

		if not np.allclose(student_N, N_des):
			print("Gravity Vector Test Failed.\n")
			print("Last input:")
			print("q =", q)
			print("cart mass =", cart_mass)
			print("pole mass =", pole_mass)
			print("pole length =", L)
			print()
			print("Your output:")
			print(student_N)
			print()
			print("Desired output:")
			print(N_des)
			return
	print("Gravity Vector Test Passed.\n")

if __name__ == '__main__':
	test_inertia_matrix()
	print()
	test_coriolis_matrix()
	print()
	test_gravity_vector()
