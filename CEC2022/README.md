# Hunter Lead Optimization (HLO)

Hunter Lead Optimization (HLO) is a novel predictive metaheuristic optimization algorithm inspired by a hunter's anticipatory lead-aiming strategy when targeting moving prey. Unlike conventional optimizers that react only to the current best solution, HLO predicts the future location of the optimum using estimated prey velocity and projectile time-of-flight concepts. This predictive mechanism enables an effective balance between exploration and exploitation, improving search efficiency and robustness on complex optimization problems.

## Highlights

* Novel predictive search mechanism inspired by lead-targeting behavior.
* Future optimum estimation using velocity and time-of-flight modeling.
* Adaptive confidence-based search strategy.
* Dynamic exploration-exploitation balance.
* Stochastic perturbation mechanism for maintaining diversity.
* Competitive performance on benchmark and engineering optimization problems.
* Simple MATLAB implementation with low computational complexity.

---

## Algorithm Description

In HLO, each search agent acts as a combined **hunter–bullet unit**.

* The current best solution represents the **prey**.
* The prey's movement is estimated using consecutive best solutions.
* Each hunter predicts the prey's future position.
* A confidence coefficient determines how strongly an agent follows the prediction.
* Adaptive stochastic perturbations maintain exploration.
* Greedy selection retains improved solutions.

This predictive hunting behavior allows HLO to efficiently explore promising regions while avoiding premature convergence.

---

## MATLAB Function

```matlab
[PreyFit, Prey, HLO_curve] = HLO(SearchAgents_no, Max_iter, lb, ub, dim, fobj);
```

### Inputs

| Parameter       | Description                  |
| --------------- | ---------------------------- |
| SearchAgents_no | Number of search agents      |
| Max_iter        | Maximum number of iterations |
| lb              | Lower bound of search space  |
| ub              | Upper bound of search space  |
| dim             | Problem dimension            |
| fobj            | Objective function handle    |

### Outputs

| Output    | Description                                                           |
| --------- | --------------------------------------------------------------------- |
| PreyFit   | Best fitness value obtained                                           |
| Prey      | Best solution vector                                                  |
| HLO_curve | Convergence curve containing the best fitness value at each iteration |

---

## Example

```matlab
clc;
clear;
close all;

SearchAgents_no = 30;
Max_iter = 2000;
dim = 30;

lb = -100;
ub = 100;

fobj = @(x) sum(x.^2);

[PreyFit, Prey, HLO_curve] = HLO(SearchAgents_no, Max_iter, lb, ub, dim, fobj);

fprintf('Best Fitness = %f\n', PreyFit);
```

---

## Benchmark Validation

HLO has been extensively evaluated on:

* CEC2017 Benchmark Suite (29 functions)
* CEC-BC-2019 Benchmark Suite (10 functions)
* CEC2022 Benchmark Suite (12 functions)

The algorithm was compared against numerous recent and classical optimization methods, including:

* ALA
* DOA
* HBO
* KEO
* MShOA
* MSO
* PO
* RFO
* WO
* AZOA
* L-SHADE
* GWO
* PSO

Experimental results demonstrate that HLO consistently achieves highly competitive performance across unimodal, multimodal, hybrid, and composition optimization problems.

---

## Applications

HLO can be applied to:

* Continuous optimization
* Engineering design optimization
* Constrained optimization
* Economic Load Dispatch (ELD)
* Machine learning parameter tuning
* Feature selection
* Control system optimization
* Other real-world optimization problems

---

## Computational Complexity

The computational complexity of HLO is:

```text
O(N × D × T)
```

where:

* N = Number of search agents
* D = Problem dimension
* T = Number of iterations

This linear complexity makes HLO suitable for high-dimensional optimization tasks.

---

## Reference

If you use HLO in your research, please cite:

```bibtex
@article{Hasan2025HLO,
  title={Hunter Lead Optimization: A Predictive Metaheuristic for Benchmark and Real-World Engineering Problems},
  author={Hasan, Dler O. and Mohammed, Hardi M. and Abdul, Zrar Khalid},
  journal={Cluster Computing},
  year={2025}
}
```

---

## Author

**Dler O. Hasan**

Department of Computer Science
Charmo University
Kurdistan Region, Iraq

Email: [dler.sys@gmail.com](mailto:dler.sys@gmail.com)

Email: [dler.osman@chu.edu.iq](mailto:dler.osman@chu.edu.iq)

Google Scholar:
https://scholar.google.com/citations?user=6EvWZuEAAAAJ&hl=en&oi=ao

---

## License

This project is released for academic and research purposes.

If you use this code in your work, please cite the original publication.
