#include <cstdio>
 #include <iostream>
 using namespace std;
int main(int argc, char *argv[]){
	 int Opc;
std::cout << "\nimplementacion del compildor Mezcal" << std::endl;
std::cout << "\nMENÚ\n" << std::endl;
std::cout << "\n1.Impresion de asteriscos\n" << std::endl;
std::cout << "\n2.Mayor y menor de 5 numeros\n" << std::endl;
std::cout << "\n3.Imprecion ordenada de 10 numeros\n" << std::endl;
std::cout << "\n4.Media, mediana y moda de 10 numeros\n" << std::endl;
std::cout << "\n5.Salir\n" << std::endl;
std::cout << "Ingresa el numero del programa: " << std::endl;
	 std::cin >> Opc;
while(Opc!=5){
if(Opc==1){
	 int numero;
std::cout << "Dame un numero entero: " << std::endl;
	 std::cin >> numero;
std::cout << "\n" << std::endl;
for(int i=numero;i>0;i=i-1){
for(int j=0;j<i;j=j+1){
std::cout << "*";}
std::cout << "\n" << std::endl;
}
}
else if(Opc==2){
	 int X,n,mayor;
	 int menor;
X=1;
mayor=0;
menor=0;
while(X<=5){
std::cout << "\nDame el Número" << std::endl;
	 std::cin >> n;
if(X==1){
mayor=n;
menor=n;
}
else if(n>mayor){
mayor=n;
}
else if(n<menor){
menor=n;
}
X+=1;
}
std::cout << "\nEl número mayor es: " << mayor << std::endl;std::cout << "\nEl núero menor es: " << menor << std::endl;std::cout << "" << std::endl;
}
else if(Opc==3){
	 int menor;
	 int numero;
	 int temporal;
int Array[10];
std::cout << "Ingresa 10 Números\n" << std::endl;
for(int i=0;i<=9;i=i+1){
std::cout << "Dame el Número" << std::endl;
	 std::cin >> numero;
Array[i]=numero;
}
std::cout << " " << std::endl;
for(int j=0;j<=9;j=j+1){
	 int n;
n=j+1;
for(int t=0;t<=8;t=t+1){
if(Array[t]<Array[n]){
temporal=Array[n];
Array[n]=Array[t];
Array[t]=temporal;
}
}
}
std::cout << " " << std::endl;
std::cout << "Array Ordenado de Menor a Mayor" << std::endl;
std::cout << " " << std::endl;
for(int t=9;t>=0;t=t-1){
std::cout << Array[t]  << std::endl;
}
}
else if(Opc==4){
int Array[10];
int Aux[10];
	 int Cont;
	 int Posicion;
	 int Numero;
	 int Cont2;
	 int posMayor;
	 int Num;
	 int NumMayor;
	 int O;
O=0;
	 int Band;
	 int temporal;
Band=0;
	 int n;
	 int suma;
	 float media;
media=0;
suma=0;
Numero=0;
std::cout << "\nDame 10 Números\n" << std::endl;
for(int i=0;i<10;i=i+1){
std::cout << "Dame Número:" << std::endl;
	 std::cin >> Num;
Array[i]=Num;
}
for(int Cont=0;Cont<=9;Cont=Cont+1){
Aux[Cont]=0;
}
for(int Cont=0;Cont<10;Cont=Cont+1){
Numero=Array[Cont];
Posicion=Cont;
for(int Cont2=Cont;Cont2<=9;Cont2=Cont2+1){
if(Array[Cont2]==Numero){
Aux[Posicion]+=1;
}
}
}
NumMayor=Aux[O];
posMayor=0;
for(int Cont=0;Cont<=9;Cont=Cont+1){
if(Aux[Cont]>NumMayor){
posMayor=Cont;
NumMayor=Aux[Cont];
}
}
std::cout << "\nLa MODA es : " << std::endl;
std::cout << Array[posMayor]  << std::endl;
std::cout << "\n" << std::endl;
for(int j=0;j<=9;j=j+1){
	 int n;
n=j+1;
for(int t=0;t<=8;t=t+1){
if(Array[t]<Array[n]){
temporal=Array[n];
Array[n]=Array[t];
Array[t]=temporal;
}
}
}
std::cout << "Array Ordenado de Menor a Mayor" << std::endl;
for(int t=9;t>=0;t=t-1){
std::cout << Array[t]  << std::endl;
}
std::cout << "\nLa MEDIANA es: " << std::endl;
std::cout << Array[5]  << std::endl;
std::cout << "y" << std::endl;
std::cout << Array[4]  << std::endl;
std::cout << "\n" << std::endl;
for(int Cont=0;Cont<=9;Cont=Cont+1){
suma+=Array[Cont];
}
media=(float)suma/10.0;
std::cout << "La MEDIA es: " << media << std::endl;}
else{
std::cout << "\nError\n" << std::endl;

}
std::cout << "\nMENÚ\n" << std::endl;
std::cout << "\n1. impresion de asteriscos\n" << std::endl;
std::cout << "\n2. mayor y menor de 5 numeros\n" << std::endl;
std::cout << "\n3. Imprecion ordenada de 10 numeros\n" << std::endl;
std::cout << "\n4. media, mediana y moda de 10 numeros\n" << std::endl;
std::cout << "\n5. Salir\n" << std::endl;
std::cout << "Ingresa el numero del programa: " << std::endl;
	 std::cin >> Opc;
}

}

