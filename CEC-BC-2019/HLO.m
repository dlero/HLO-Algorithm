%_______________________________________________________________%
%  Hunter Lead Optimization (HLO) source codes version 1.0                                 %
%                                                                                                                                   %
%  Developed in MATLAB R2017a (9.2)                                                                     %
%                                                                                                                                   %
%  Author and programmer: Dler O. Hasan                                                                %
%                                                                                                                                   %
%         e-Mail: dler.sys@gmail.com                                                                             %
%                     dler.osman@chu.edu.iq                                                                       %
%                                                                                                                                   %
%       Google Scholar Profile: https://scholar.google.com/citations?user=6EvWZuEAAAAJ&hl=en&oi=ao        %
%                                                                                                                                    %
%   Main paper: Dler O. Hasan, Hardi M. Mohammed, Zrar Khalid Abdul,                 %
%               Hunter Lead Optimization: A Predictive Metaheuristic for Benchmark and Real-World Engineering Problems,%
%               IEEE Access,                                                               %
%               DOI: https://doi.org/10.1109/ACCESS.2026.3735902                           %
%                                                                                                                                     %
%________________________________________________________________%
function [PreyFit, Prey, HLO_curve] = HLO(N, Max_iter, lb, ub, dim, fobj)

    lb = ones(1, dim) .* lb;
    ub = ones(1, dim) .* ub;

    B = zeros(N, dim);

    for j = 1:dim
        B(:, j) = lb(j) + rand(N, 1) .* (ub(j) - lb(j));
    end

    % --- initialize fitness and best trackers -----------------------------
    fit = inf(1, N); % fitness values (minimization problem)

    for i = 1:N
        fit(i) = fobj(B(i, :));
    end

    [PreyFit, idx] = min(fit); % find current best score & index
    Prey = B(idx, :); % best position vector
    Prey_prev = Prey; % store previous best for velocity estimate

    % --- HLO curve for convergence plotting -------------------------------
    HLO_curve = inf(1, Max_iter);

    vp = 1.0; % virtual projectile speed (units per iteration)

    % Main loop
    for it = 1:Max_iter
        % Eq. (3): --- estimate prey (best) velocity from last iteration -----------
        V_prey = Prey - Prey_prev;

        %  Eq. (6): (confidence)
        [~, order] = sort(fit, 'ascend'); % best -> worst ordering indices
        ranks = 1:N; % rank values 1..N
        ra(order) = ranks; % ra(i) gives rank of agent i
        alpha = 1 - (ra - 1) ./ max(N - 1, 1); % attention in (1..0], best agents get ~1

        for i = 1:N
            %Eq. (4): ToF
            ToF = norm(B(i, :) - Prey) / vp; % estimated time until "hit"
            %Eq. (5): Prey_pred
            Prey_pred = Prey + V_prey .* ToF;

            %Eq. (9):
            beta = (1 - it / Max_iter) ^ 2;
            %Eq. (8):
            epsilon = 0.07 * randn(1, dim) .* (ub - lb) .* beta;

            %Eq. (7):
            Target = (1 - alpha(i)) .* Prey + alpha(i) .* Prey_pred + epsilon;

            %Eq. (11)
            b = rand > 0.9;
            eta = (0.3 + 0.7 * alpha(i)) .* (b * rand(1, dim) + (1 - b) * randn(1, dim));
            %Eq. (10): Bnew
            Bnew = B(i, :) + eta .* (Target - B(i, :)); % apply step

            % ---- enforce bounds -----
            Bnew = apply_bounds(Bnew, lb, ub);

            % %Eq. (12): ---- greedy replacement if better -----------
            fnew = fobj(Bnew);

            if fnew < fit(i)
                B(i, :) = Bnew;
                fit(i) = fnew;
            end
        end
        % --- update global best and keep previous best for next velocity --
        [best_curr, loc_curr] = min(fit); % current generation best
        Prey_prev = Prey; % move old best to prev

        if best_curr < PreyFit
            PreyFit = best_curr; % update best score
            Prey = B(loc_curr, :); % update best position
        end
        HLO_curve(it) = PreyFit; % store best-so-far value
    end

    function X_new = apply_bounds(X_new, lb, ub)
        X_new = max(X_new, lb);
        X_new = min(X_new, ub);
    end
end
