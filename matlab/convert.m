input=dlmread("lab3-in.txt");
coef=dlmread('lab3-coef.txt');
output=dlmread("lab3-out.txt");

registers=zeros(25,1);
Prod=fimath('ProductMode','FullPrecision','SumMode','FullPrecision');
T1=numerictype('WordLength',16,'FractionLength',15);
T2=numerictype('WordLength',17,'FractionLength',15);
rms=0.0;
rms2=0.0;
 for j=1:25
        disp(coef(j,1));
 end
for i=1:999
    circshift(registers,1);
    registers(1,1)=input(1,i);
    sum=fi(0,Prod,T2);
    smu_dec=0.0;
    for j=1:25
        in=fi(registers(j),Prod,T1);
        coef_fix=fi(coef(j),Prod,T1);
        sum=sum+fi(in*coef_fix,Prod,T2);
        smu_dec=smu_dec+(registers(j)*coef(j));
    end

    rms=rms+((double(sum)-output(1,i)).^2);
    rms2=rms2+((smu_dec-output(1,i)).^2);
end 
rms=rms/999;
rms=sqrt(rms);
disp(rms);
rms2=rms2/999;
rms2=sqrt(rms2);
disp(rms2);