# leela_ane

An attempt to get the [lc0](https://lczero.org) network to run on the Neural Engine of the M1 chip. Why? For faster chess programs!

# Using this repo

Github file size limit is 100MB. [Download the .mlmodel file](https://www.icloud.com/iclouddrive/0fDbML6roDn8p9EN_Pon0vy_Q#42850-T40) and place next to AppDelegate.swift.

# Creating the .mlmodel file

To run on the ANE, one must have a CoreML .mlmodel file, unless one is doing [this](https://github.com/geohot/tinygrad/tree/ane/ane).

1. Start with network "42850" from https://lczero.org/play/networks/bestnets/. This is in the Leela network format.
2. Also download this `t40.yml` file: https://gist.github.com/daylen/7ac1e9d9c9d38a9eaadff133f3546df2
3. Use net_to_model.py in [my fork of lczero-training](https://github.com/daylen/lczero-training) to create a .mlmodel file from the network weights and yml. Note that unfortunately this only supports POLICY_CLASSICAL, not POLICY_CONVOLUTION

# Benchmarking

For reasons I don't understand yet, inference on ANE and GPU is slower than inference on CPU:

```
.all (Activates ANE) Time to evaluate: 28.928249542 seconds
.cpuAndGpu Time to evaluate: 29.006600709 seconds
.cpuOnly Time to evaluate: 16.062404083 seconds
```

# Verifying ANE usage

I found [these instructions](https://github.com/hollance/neural-engine/blob/master/docs/is-model-using-ane.md) useful. (tl;dr there is no programmatic way to identify whether the ANE is being used, so the trick is to set a breakpoint on `-[_ANEModel program]`. When using `.all` for `computeUnits` it does break on that line.
