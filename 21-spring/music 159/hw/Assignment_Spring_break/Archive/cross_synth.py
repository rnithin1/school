from scipy.io import wavfile
import numpy as np
import argparse 

AVERAGE = False

parser = argparse.ArgumentParser(description='Basic cross-synthesis.')

parser.add_argument("--path1", help="Path of the first audio file")
parser.add_argument("--path2", help="Path of the second audio file")
parser.add_argument("--x", help="Signal 1 amplitude coefficient")
parser.add_argument("--X", help="Signal 2 amplitude coefficient")
parser.add_argument("--q", help="Cross coefficient")
parser.add_argument("--y", help="Signal 1 phase coefficient")
parser.add_argument("--Y", help="Signal 2 phase coefficient")

args = parser.parse_args()
path1 = args.path1
path2 = args.path2
x = float(args.x)
X = float(args.X)
q = float(args.q)
y = float(args.y)
Y = float(args.Y)

samplerate1, data1 = wavfile.read(path1)
samplerate2, data2 = wavfile.read(path2)

if len(data1.shape) == 2:
    if AVERAGE:
        data1 = np.average(data1, axis=1)
    else:
        data1 = data1[:, 0]

if len(data2.shape) == 2:
    if AVERAGE:
        data2 = np.average(data2, axis=1)
    else:
        data2 = data2[:, 0]

trunc = min(len(data1), len(data2))

data1 = data1[0:trunc]
data2 = data2[0:trunc]

data1 = data1.astype(np.float64)
data2 = data2.astype(np.float64)

spec1 = np.fft.fft(data1)
spec2 = np.fft.fft(data2)

amp1 = np.abs(spec1)
amp2 = np.abs(spec2)

phase1 = np.angle(spec1)
phase2 = np.angle(spec2)

amp_star = x * amp1 + X * amp2 + q * np.sqrt(amp1 * amp2)
phase_star = y * phase1 + Y * phase2

recon = amp_star * np.exp(1j * phase_star)
analysis = np.fft.ifft(recon)

analysis = analysis.astype(np.int16)

wavfile.write("out.wav", min(samplerate1, samplerate2), analysis)
