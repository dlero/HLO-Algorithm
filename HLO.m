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
%               Cluster Computing,                                                               %
%               DOI:                                                               %
%                                                                                                                                     %
%________________________________________________________________%
function [PreyFit, Prey, HLO_curve] = HLO(SearchAgents_no, Max_iter, lb, ub, dim, fobj)

    lb = ones(1, dim) .* lb;
    ub = ones(1, dim) .* ub;

    B = zeros(SearchAgents_no, dim);

    for j = 1:dim
        B(:, j) = lb(j) + rand(SearchAgents_no, 1) .* (ub(j) - lb(j));
    end

    % --- initialize fitness and best trackers -----------------------------
    fit = inf(1, SearchAgents_no); % fitness values (minimization problem)

    for i = 1:SearchAgents_no
        fit(i) = fobj(B(i, :));
    end

    [PreyFit, idx] = min(fit); % find current best score & index
    Prey = B(idx, :); % best position vector
    Prey_prev = Prey; % store previous best for velocity estimate

    % --- HLO curve for convergence plotting -------------------------------
    HLO_curve = inf(1, Max_iter);

    proj_speed = 1.0; % virtual projectile speed (units per iteration)

    % Main loop
    for it = 1:Max_iter
        % Eq. (3): --- estimate prey (best) velocity from last iteration -----------
        V_prey = Prey - Prey_prev;

        %  Eq. (6): ? (confidence)
        [~, order] = sort(fit, 'ascend'); % best -> worst ordering indices
        ranks = 1:SearchAgents_no; % rank values 1..N
        invperm(order) = ranks; % invperm(i) gives rank of agent i
        confidence = 1 - (invperm - 1) ./ max(SearchAgents_no - 1, 1); % ? attention in (1..0], best agents get ~1

        % --- for each agent, predict where best will be when a "projectile arrives"
        for i = 1:SearchAgents_no
            %Eq. (4): ToF
            ToF = norm(B(i, :) - Prey) / proj_speed; % estimated time until "hit"
            %Eq. (5): Prey_pred
            Prey_pred = Prey + V_prey .* ToF;

            %Eq. (9): ?
            beta = (1 - it / Max_iter) ^ 2; % decays from 0.2 -> 0
            %Eq. (8): ?
            explorationNoise = 0.07 * randn(1,dim) .* (ub - lb) .* beta;

            %Eq. (7):
            Target = (1 - confidence(i)) .* Prey + confidence(i) .* Prey_pred + explorationNoise;

            %?
            b = rand > 0.9;
            eta = (0.3 + 0.7 * confidence(i)) .* (b * rand(1, dim) + (1 - b) * randn(1, dim));
            %Eq. (10): Bnew
            Bnew = B(i, :) + eta .* (Target - B(i, :)); % apply step

            % ---- enforce bounds -----
            Bnew = max(Bnew, lb); % clip lower bound
            Bnew = min(Bnew, ub); % clip upper bound

            % %Eq. (11): ---- greedy replacement if better -----------
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

end
