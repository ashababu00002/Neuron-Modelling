# Neuron-Modelling


Modelling of Transcranial Ultrasound Stimulation (TUS) at the Peak-Phase of Theta-Cycles in the Hippocampus

1. Objective
The study aims to explore the effects of closed-loop TUS applied to the hippocampal CA1 region during theta rhythm peak phases. This intervention is hypothesized to enhance memory performance by targeting encoding and retrieval phases of memory processing.

2. Materials and Methods
   Subjects: 20 male Sprague-Dawley rats divided into four groups:
  - Peak stimulation (n=5)
  - Trough stimulation (n=5)
  - Random stimulation (n=5)
  - Sham stimulation (n=5)
  Procedure:
  - Skull resected to expose hippocampal CA1 for electrode placement.
  - Closed-loop ultrasound applied during specific theta rhythm phases.
  - Rats were anesthetized during stimulation but awake during behavioral tests.
  Behavioral Test: Y-maze used to assess memory and exploration.
  Ultrasound Parameters: 500 kHz frequency, 50 ms stimulus duration, and 1 Hz pulse repetition.

3. Modeling Approach
- Utilized the Izhikevich neuron model for simulating neuronal dynamics.
- Observed theta-nested gamma oscillations and analyzed excitatory/inhibitory effects of TUS.
- Key variables:
  - Membrane potential (v)
  - Recovery variable (u)
  - Synaptic current (I)
- Results showed enhanced excitation when TUS was applied at theta peaks, while trough stimulation had inhibitory effects.

4. Results
   Key Findings:
  - TUS at theta peaks increased pyramidal cell excitation.
  - Trough-phase stimulation showed inhibitory effects.
  - Memory performance improved in peak-stimulated rats, as shown in Y-maze exploration.
  Figures:
  - Detailed neuron responses (pyramidal, fast-spiking, regular-spiking cells).
  - Comparison of theta peaks and trough effects across different intensities (I = 5, 10, 15, 20).

5. Conclusions
- Demonstrated the potential of closed-loop TUS to enhance memory by modulating theta-gamma oscillations.
- Provided insights into phase-specific effects of TUS in the hippocampus.

6. Future Work
- Expanding the model to include more neurons for higher accuracy.
- Exploring human applications of TUS while addressing ethical concerns.
- Testing in clinical populations, such as those with Alzheimer’s or cognitive impairments.

This work underscores the feasibility of TUS for memory enhancement and lays the foundation for future computational and experimental advancements.
