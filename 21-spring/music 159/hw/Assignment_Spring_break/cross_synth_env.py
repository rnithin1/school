#!/usr/bin/python3

################################################################################
##### EXAMPLE USAGE: python3 cross_synth_env.py --path1 Sound/Brahms_4.wav #####
#####                   --path2 Sound/Diner.wav --x 0.7 --X 0.3 --q 1      #####
#####                   --y 0.5 --Y 0.5                                    #####
################################################################################

from scipy.io import wavfile
import numpy as np
import argparse 

AVERAGE = False

parser = argparse.ArgumentParser(description='Envelope cross-synthesis.')

parser.add_argument("--path1", help="Path of the first audio file")
parser.add_argument("--path2", help="Path of the second audio file")
parser.add_argument("--x", help="Signal 1 amplitude coefficient")
parser.add_argument("--X", help="Signal 2 amplitude coefficient")
parser.add_argument("--q", help="Cross coefficient")
parser.add_argument("--y", help="Signal 1 phase coefficient")
parser.add_argument("--Y", help="Signal 2 phase coefficient")
parser.add_argument("--thresh1", help="Lowpass window for Signal 1")
parser.add_argument("--thresh2", help="Lowpass window for Signal 1")

## Assemble command-line arguments
args = parser.parse_args()
path1 = args.path1
path2 = args.path2
x = float(args.x)
X = float(args.X)
q = float(args.q)
y = float(args.y)
Y = float(args.Y)
thresh1 = float(args.thresh1) if args.thresh1 != None else None
thresh2 = float(args.thresh2) if args.thresh2 != None else None

## Load in data streams and truncate
samplerate1, data1 = wavfile.read(path1)
samplerate2, data2 = wavfile.read(path2)

## If there are two channels, average them (or take only one)
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

######################################
##### Obtain amplitude and phase #####
######################################

spec1 = np.fft.fft(data1)
spec2 = np.fft.fft(data2)

amp1 = np.abs(spec1)
amp2 = np.abs(spec2)

## Set maximum thresholds if none exist
if thresh1 is None:
    thresh1 = np.max(data1)

if thresh2 is None:
    thresh2 = np.max(data2)

###########################
##### Obtain envelope #####
###########################

## Create lowpass windows
w1 = (amp1 < thresh1).astype(np.int) + 0.5 * (amp1 == thresh1).astype(np.int)
w2 = (amp2 < thresh2).astype(np.int) + 0.5 * (amp2 == thresh2).astype(np.int)

## Create real cepstra
cep1 = np.fft.ifft(np.log(amp1))
cep2 = np.fft.ifft(np.log(amp2))

## Lowpass filter
cep1_lp = w1 * cep1
cep2_lp = w2 * cep2

## Create envelope
e1 = np.fft.fft(cep1_lp)
e2 = np.fft.fft(cep2_lp)

########################
##### Obtain phase #####
########################
phase1 = np.angle(spec1)
phase2 = np.angle(spec2)

#################################################
##### Construct signal, move to time domain #####
#################################################
amp_star = x * e1 + X * e2 + q * np.sqrt(amp1 * amp2)
phase_star = y * phase1 + Y * phase2

recon = amp_star * np.exp(1j * phase_star)
analysis = np.fft.ifft(recon)

analysis = analysis.astype(np.int16)

wavfile.write("out.wav", min(samplerate1, samplerate2), analysis)
