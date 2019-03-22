input=dlmread("lab3-in.txt");
coef=dlmread('lab3-coef.txt');
output=dlmread("lab3-out.txt");

for precision=1:15
registers=zeros(25,1);
rms=0.0;
for i=1:999
    registers=circshift(registers,1);
    registers(1,1)=input(1,i);
    sum=fi(0,1,precision+2,precision);
    for j=1:25
        in=fi(registers(j),1,precision+1,precision);
        coef_fix=fi(coef(j),1,precision+1,precision);
        sum=sum+fi(in*coef_fix,1,precision+2,precision);
    end
    rms=rms+((double(sum)-output(1,i)).^2);
end 
rms=rms/999;
rms=sqrt(rms);
disp("for "+ precision+ "  " +rms);
end 