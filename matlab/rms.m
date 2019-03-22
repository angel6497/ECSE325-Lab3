output=dlmread("lab3-out.txt");
output_generated=dlmread("output_decimal.txt");
rms1=0.0;
for i=1:999
    rms1=rms1+((output_generated(i,1)-output(1,i)).^2);
end 
rms1=rms1/999;
rms1=sqrt(rms1);
disp(rms1);