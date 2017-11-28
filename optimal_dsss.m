function optimal_dsss()


%Initialisation
alice_cord_x=0;
alice_cord_y=0;

bob_cord_x=0;
bob_cord_y=10;

eve_cord_x=4;
eve_cord_y=-15;

%Step size
%% We shall be varying this to study various capture strategies
beta_b=1;
beta_e=1;
alpha=2;
Es= 45;% FIRST ROUD TEST= 47; %Power of source in dbm
P_alice=(10^(Es/10))/1000; 

count=0;
threshold=1000;

chip_bandwidth= 100*10^6; %bits/sec
c_light=3*10^8; %m/s

%% Sequence Initialisation
pnSequence2 = comm.PNSequence('Polynomial','x^5+x^2+1', ...
    'InitialConditions',[0 0 0 1 0],'SamplesPerFrame',31);
code = pnSequence2();

%% While count, i.e,  chase time is less than
while count<=threshold && (pdist([0,0;bob_cord_x,bob_cord_y])<100) % Need to figure out where to put this
    
    d_ae=pdist([0,0;eve_cord_x,eve_cord_y]); % Eve knows from power
    d_ab=pdist([0,0;bob_cord_x,bob_cord_y]); % Bob has knowledge of oreientation of Alice /has not s two cases
    d_be=pdist([bob_cord_x,bob_cord_y;eve_cord_x,eve_cord_y]); % Eve knows this from Power measurement
    
    
    %% Initialization
    if count==0
        % Actual measurements
      P_eve_alice=P_alice*(d_ae)^-alpha;
      P_eve_bob=P_bob*(d_be)^-alpha;
      % Eve knows know distance d_ae and d_be but not their coordinates.
      
      % 1. The evader moves to e[1]. Already at a co-ordinate
%     % 2. The pursuer gets the measurement y0[1] and it constructs  @By0[1](p[0]) which is a circle of radius y0[1] around the point p[0].
%      Radius of circle centred at eve_cord_x,eve_cord_y: d_be
      % Eve selects a direction randomly from uniform distribution between 0 and 2*pi: radian from X axis
      theta= random('uniform', 0, 2*pi);
      % update Eve coordinate
      eve_cord_x=eve_cord_x + cos(theta);
      eve_cord_y=eve_cord_x+ sin(theta);
      
    end
      %% Path differnece
      % Since accurate path difference cannot be calculted the upper bound
      % is calculated
      
      
      %% At every other instant Eve and Bob know the mutual distance
      actual_path_diff=(d_ae+d_be)-d_ab;
      actual_delay_chip=floor(actual_path_diff*chip_bandwidth/c_light);
      
      path_upper_bound= 2*min(d_ae,d_be);
      % No of configuration needed= chip equivalent travlled in this time
      n_chip= ceil(path_upper_bound*chip_bandwidth/c_light); % n_chip is ceil so it corresponds to the number of distributions 
      
      code_eve=zeroes(1,n_chip); % all sets of code which Eve will be using to jam
      for n=1:n_chip
      code_eve(n,:)=circshift(code,n-1); % shift for one option is zero
      % Effective Cross-Correlation
      [corr1,index]= crosscorr(code,code_eve,30)
      if n==actual_delay_chip
          val_corr(n)=max(corr1(31:61));
      else
          val_corr(n)=corr1(31);
      end
%% Effective Correlation: 
% 1/n_chip*(1+

    end
    total_cross_corr(count)=sum(val_corr);
    
    
% Alice Tranmists> Eve measures




%% Strategy after boundary is reached
% There can be two cases:  1. Boundary is perfectly circular  2. Boundary
% can be relaxed out of uncertainty
% POLICY: Bob moves along the boundary, 







end
