%% Plot Value costs for all time periods and capacity states
for n=1:5
    for c=1:4
        subplot(5,4,(n-1)*4 + c)
        imagesc(V(:,:,c,n));
        set(gca, 'YDir', 'normal')
        if n==1
            title(['Cap State= ',num2str(c)]);
            caxis([70000000 120000000]);
        elseif n==5
            xlabel('P State');
            %caxis([0 300000000]);
        else
            %caxis([0 300000000]);
        end
        
        if c==1
            ylabel(['N=', num2str(n), ', T State']);
        end
        colorbar;
    end
    sgtitle('Best Value Costs');
    
end
%%
for n=1:5
    for c=1:4
        subplot(5,4,(n-1)*4 + c)
        imagesc(X(:,:,c,n));
        set(gca, 'YDir', 'normal')
        colorbar;
    end
end

%% Plot best actions for all time periods and capacity states
for n=1:5
    for c=1:4
        subplot(5,4,(n-1)*4 + c)
        imagesc(X(:,:,c,n));
        set(gca, 'YDir', 'normal')
        if n==1
            title(['Cap State= ',num2str(c)]);
            %caxis([70000000 120000000]);
        elseif n==5
            xlabel('P State');
            %caxis([0 300000000]);
        else
            %caxis([0 300000000]);
        end
        
        if c==1
            ylabel(['N=', num2str(n), ', T State']);
        end
        colorbar;
    end
    sgtitle('Best Action (SDP)');
    
end

%% Look at V and X to manipulate time period N=1 V results
% Try to recreate optimal best choice matrix in time period N=1 using X
temp = 151;
precip = 32;
n = 2;
nextV = V(:,:,:,n);
Vtest = zeros(temp, precip);

for p=1:precip
    for t=1:temp
        % large dam
        if X(t,p,1,1) == 2
            % calc transition matrix
            T_cap = [0 1 0 0];
            TRows = cell(3,1);
            TRows{1} = T_Temp(:,t, 1)';
            TRows{2} = T_Precip(:,p, 1)';
            TRows{3} = T_cap;
            [ T ] = transrow2mat( TRows );
            
            indexNonZeroT = find(T > 0);
            nextV(indexNonZeroT);
            expV = sum(T(indexNonZeroT) .* nextV(indexNonZeroT));
            Vtest(t,p) = (expV + infra_cost(2+1))/1.03;
            disp(['Large Dam: T=', num2str(t), ', P=', num2str(p)]);
        % flex dam
        elseif X(t,p,1,1) == 3
            if X(t,p,3,2)==4
                T_cap = [0 0 0 1];
            else
                T_cap = [0 0 1 0];
            end
            TRows = cell(3,1);
            TRows{1} = T_Temp(:,t, 1)';
            TRows{2} = T_Precip(:,p, 1)';
            TRows{3} = T_cap;
            [ T ] = transrow2mat( TRows );
            
            indexNonZeroT = find(T > 0);
            expV = sum(T(indexNonZeroT) .* nextV(indexNonZeroT));
            Vtest(t,p) = (expV + infra_cost(3+1))/1.03;
            disp(['Flex Dam: T=', num2str(t), ', P=', num2str(p)]);
        % small dam
        elseif X(t,p,1,1) == 1
            T_cap = [1 0 0 0];
            TRows = cell(3,1);
            TRows{1} = T_Temp(:,t, 1)';
            TRows{2} = T_Precip(:,p, 1)';
            TRows{3} = T_cap;
            [ T ] = transrow2mat( TRows );
            
            indexNonZeroT = find(T > 0);
            expV = sum(T(indexNonZeroT) .* nextV(indexNonZeroT));
            Vtest(t,p) = (expV + infra_cost(1+1))/1.03;
            disp(['Small Dam: T=', num2str(t), ', P=', num2str(p)]);
        end
    end
end

%% 

subplot(1,3,2)
imagesc(Vtest(:,:));
set(gca, 'YDir', 'normal');
colorbar;
title('Best Value Test');

subplot(1,3,1)
imagesc(V(:,:,1,1));
set(gca, 'YDir', 'normal');
colorbar;
title('Best Value SDP')

subplot(1,3,3)
test(:,:) = V(:,:,1,1)-Vtest(:,:);
imagesc(test(:,:));
set(gca, 'YDir', 'normal');
colorbar;
caxis([0 4000000]);
title('Best Value SDP - Vest Value Test');


%% 

figure
divby = [1, 1.806, 3.262, 5.8916, 10.641];
for n=1:5
    for c=1:2
        subplot(5,2,(n-1)*2 + c)
        imagesc(shortageCost(:,:,c,1)/divby(n));
        set(gca, 'YDir', 'normal')
        colorbar;
    end
end

%%
figure
for n=1:5
    for c=1:2
        subplot(5,2,(n-1)*2 + c)
        imagesc(V(:,:,c,n)-shortageCost(:,:,c,1)/divby(n));
        set(gca, 'YDir', 'normal')
        colorbar;
    end
end