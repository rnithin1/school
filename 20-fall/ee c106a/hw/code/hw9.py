"""
Starter code for EE C106A Fall 2020 Homework 9.
Author: Amay Saxena

To test your implementation of the inertia matrix, coriolis matrix, and grvity vector,
run the unit tests by running 

python hw9_test.py

You will need to make sure hw9.py, hw9_test.py, and testdata.npz are all in the same directory.
Make sure these tests pass before you start implementing and simulating your controller.

After you have implemented the dynamics and your controller, you will be able to simulate it
by running this file. The file takes in the following command-line arguments.

--x0     : initial value for x (default: 1.0).
--theta0 : initial value for theta (default: 0.2).
--alpha1 : controller gain alpha1 (default: 0.1).
--alpha2 : controller gain alpha2 (default: 0.1).
--beta1  : controller gain beta1 (default: 0.0).
--beta2  : controller gain beta2 (default: 0.0).

It will then produce a plot of the trajectory of x and theta starting from time 0
with your provided initial conditions for 100 seconds under the influence of your
control law with the provided gains.

Example usage:

python hw9.py --x0 1.0 --theta0 0.1 --alpha1 0.1 --alpha2 0.1 --beta1 0.0 --beta2 0.0

"""
import numpy as np
import scipy.integrate
import matplotlib.pyplot as plt
import argparse

G_ACCEL = 9.81

class CartPoleSystem(object):
	def __init__(self, cart_mass=1.0, pole_mass=1.0, pole_length=1.0):
		self.cart_mass = cart_mass
		self.pole_mass = pole_mass
		self.pole_length = pole_length

	def M(self, q):
		"""
		part (b)

		Returns the generalized inertia matrix of the cart-pole system.
		Note: you can access the mass of the cart, mass of the pole, and the length
		of the pole as self.cart_mass, self.pole_mass, and self.pole_length respectively.

		Arguments:
			q: np.ndarray of size (2,). q = [x, theta].
			cart_mass: mass M of the cart.
			pole_mass: mass m of the weight on top of the pole.
			pole_length: length L of the pole.
		"""
		pass

	def C(self, q, q_dot):
		"""
		part (b)

		Returns the Coriolis matrix of the cart-pole system.
		Note: you can access the mass of the cart, mass of the pole, and the length
		of the pole as self.cart_mass, self.pole_mass, and self.pole_length respectively.

		Arguments:
			q: np.ndarray of size (2,). q = [x, theta].
			q_dot: np.ndarray of size (2,). q = [x_dot, theta_dot].
			cart_mass: mass M of the cart.
			pole_mass: mass m of the weight on top of the pole.
			pole_length: length L of the pole.
		"""
		pass

	def N(self, q):
		"""
		part (b)

		Returns the Gravity vector of the cart-pole system as a numpy nddarray of shape (2,).
		Note: you can access the mass of the cart, mass of the pole, and the length
		of the pole as self.cart_mass, self.pole_mass, and self.pole_length respectively.

		Note: gravitational acceleration is stored as a global variable G_ACCEL and should be taken
		to be 9.81 m/s^2.

		Arguments:
			q: np.ndarray of size (2,). q = [x, theta].
			q_dot: np.ndarray of size (2,). q = [x_dot, theta_dot].
			cart_mass: mass M of the cart.
			pole_mass: mass m of the weight on top of the pole.
			pole_length: length L of the pole.
		"""
		pass

	def control_law_computed_torque(self, q, q_dot, alpha1, alpha2, beta1, beta2):
		"""
		part (e)

		Implements the computed-torque control law. When the cart is in state [q, q_dot], return the 
		required control input u = [F, tau] that would help stabilize the system to the desired point.

		Kp = diag(alpha1, alpha2)
		Kv = diag(beta1, beta2)

		Note: you can access the mass of the cart, mass of the pole, and the length
		of the pole as self.cart_mass, self.pole_mass, and self.pole_length respectively.
		"""
		pass

	def state_space_grad(self, x, u):
		"""
		Implements f(x, u) where x_dot = f(x, u) is the state-space representation of the cart-pole system.
		state x = [q, q_dot] and input u = [F, tau].
		"""
		q = x[:2]
		q_dot = x[2:]

		M = self.M(q)
		C = self.C(q, q_dot)
		N = self.N(q)

		x_dot = np.zeros(4)
		x_dot[:2] = q_dot
		x_dot[2:] = np.dot(np.linalg.inv(M), -C.dot(q_dot) - N + u)
		return x_dot

	def simulate(self, x0, control_law, end_time):
		def closed_loop(x, t):
			q, q_dot = x[:2], x[2:]
			u = control_law(q, q_dot)
			return self.state_space_grad(x, u)
		t = np.arange(0.0, end_time, 0.01)
		x = scipy.integrate.odeint(closed_loop, x0, t)
		plt.plot(t, x[:, 0], label='x')
		plt.plot(t, x[:, 1], label='theta')
		plt.legend()
		plt.show()

def main():
	parser = argparse.ArgumentParser()
	parser.add_argument("--x0", help="Value of x at time 0.", type=float, default=1.0)
	parser.add_argument("--theta0", help="Value of theta at time 0.", type=float, default=0.2)
	parser.add_argument("--alpha1", help="Controller gain alpha1.", type=float, default=0.1)
	parser.add_argument("--alpha2", help="Controller gain alpha2.", type=float, default=0.1)
	parser.add_argument("--beta1", help="Controller gain beta1.", type=float, default=0.0)
	parser.add_argument("--beta2", help="Controller gain beta2.", type=float, default=0.0)
	
	args = parser.parse_args()

	M, m, L = 1.0, 1.0, 1.0
	system = CartPoleSystem(M, m, L)
	control_law = lambda q, q_dot: system.control_law_computed_torque(q, q_dot, args.alpha1, args.alpha2, args.beta1, args.beta2)
	x0 = np.array([args.x0, args.theta0, 0.0, 0.0])
	system.simulate(x0, control_law, 100)

if __name__ == '__main__':
	main()


