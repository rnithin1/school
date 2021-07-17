`cross_synth.py` contains the base implementation of the cross-synthesis algorithm as described in class.

`cross_synth_env.py` contains the cepstral implementation of cross-synthesis using a low-pass filter. This file is more commented, and
contains information on the exact process.

Example usage for `cross_synth_env.py`: 
`python3 cross_synth_env.py --path1 Sound/Brahms_4.wav --path2 Sound/Diner.wav --x 0.7 --X 0.3 --q 1 --y 0.5 --Y 0.5`

It is called the exact same way for `cross_synth.py`. The threshold parameters for `cross_synth_env.py` are optional, and are not there in the original implementation.
                   

