import numpy as np

########## PROBLEM 4 ##########

def g02(t, v2, R2):
    '''
    Problem 4 (a)
        Returns the 4x4 rigid body pose g_02 at time t given that the
        satellite is orbitting at radius R2 and linear velocity v2.

        Args:
            t: time at which the configuration is computed.
            v2: linear speed of the satellite, in meters per second.
            R2: radius of the orbit, in meters.
        Returns:
            4x4 rigid pose of frame {2} as seen from frame {0} as a numpy array.

        Functions you might find useful:
            numpy.sin
            numpy.cos
            numpy.array
            numpy.sqrt
            numpy.matmul
            numpy.eye

        Note: Feel free to use one or more of the other functions you have implemented
        in this file.
    '''
    g = np.array([[1, 0, 0, 0],
                  [0, 1, 0, 0],
                  [0, 0, 1, 0],
                  [0, 0, 0, 1]])
    return g

def g01(t, v1, R1):
    '''
    Problem 4 (b)
        Returns the 4x4 rigid body pose g_01 at time t given that the
        satellite is orbitting at radius R1 and linear velocity v1.

        Args:
            t: time at which the configuration is computed.
            v1: linear speed of the satellite, in meters per second.
            R1: radius of the orbit, in meters.
        Returns:
            4x4 rigid pose of frame {1} as seen from frame {0} as a numpy array.

        Functions you might find useful:
            numpy.sin
            numpy.cos
            numpy.array
            numpy.sqrt
            numpy.matmul
            numpy.eye

        Note: Feel free to use one or more of the other functions you have implemented
        in this file.
    '''
    g = np.array([[1, 0, 0, 0],
                  [0, 1, 0, 0],
                  [0, 0, 1, 0],
                  [0, 0, 0, 1]])
    return g

def g21(t, v1, R1, v2, R2):
    '''
    Problem 4 (c)
        Returns the 4x4 rigid body pose g_21 at time t given that the
        first satellite is orbitting at radius R1 and linear velocity v1
        and the second satellite is orbitting at radius R2 and linear 
        velocity v2.

        Args:
            t: time at which the configuration is computed.
            v1: linear speed of satellite 1, in meters per second.
            R1: radius of the orbit of satellite 1, in meters.
            v2: linear speed of satellite 2, in meters per second.
            R2: radius of the orbit of satellite 2, in meters.
        Returns:
            4x4 rigid pose of frame {2} as seen from frame {0} as a numpy array.

        Functions you might find useful:
            numpy.matmul
            numpy.linalg.inv

        Note: Feel free to use one or more of the other functions you have implemented
        in this file.
    '''
    g = np.array([[1, 0, 0, 0],
                  [0, 1, 0, 0],
                  [0, 0, 1, 0],
                  [0, 0, 0, 1]])
    return g

########## END PROBLEM 2 ##########
