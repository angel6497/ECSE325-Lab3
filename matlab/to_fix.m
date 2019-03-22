coef=dlmread('lab3-coef.txt');
input=dlmread("lab3-in.txt");
fileID = fopen('coef-fix-3-2.txt','w');
fileID2 = fopen('lab3-fix-3-2.txt','w');
A=fi(coef, 1, 3,2);
In=fi(input, 1, 3,2);
for i=1:25
fprintf(fileID, '%s\n', bin(A(i)));
end 
for i=1:999
fprintf(fileID2, '%s\n', bin(In(i)));
end 
fclose(fileID);
fclose(fileID2);