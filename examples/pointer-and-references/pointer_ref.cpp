//Author: F. Holliday
//Program name: Parameter Passing by Reference and by Pointer

//This program consisting of three files was created to serve as a supplement to a lecture on pointers and references.
//These two related topics usually need a substancial amount of study and experimentation in order to understand 
//both of them well.

//The reader is invited to study, run, modify, and re-organize this program.  Hopefully, insight into parameter
//passing will be gained.

//No module in C appears in this program because reference variables do not exist in C language.



#include <iostream>
#include <iomanip>

double compute_total_via_reference_cpp(double &,double &);

double compute_total_via_pointers_cpp(double *,double *);

extern "C" double compute_total_via_reference_x86(double &,double &);  //Note: this prototype and the one following it
                                                                       //refer to the exact sample x86 code.
extern "C" double compute_total_via_pointers_x86(double *,double *);


using namespace std;

int main(int argc, char* argv[])
{//===== Begin section "Pass by Reference" to a C++ function ==================================================================
 cout << "Begin section that passes parameters by reference to a C++ function" << endl;
 double retail_price = 10.00;
 double & rp = retail_price;  //rp is a reference to retail_price
 cout << "The reference shelf price is " << setw(4) << setprecision(2) << fixed << left << rp << endl; 
 double tax_rate = 0.25;
 double & tr = tax_rate;
 cout << "The reference sales tax rate is " << setw(4) << setprecision(3) << fixed << left << tr << endl;
 double final_cost = compute_total_via_reference_cpp(retail_price,tax_rate);  //Both passed in parameters are references.
 cout << "The final cost as computed by references passed to a C++ function is " << setw(4) << setprecision(2) << fixed 
      << left << final_cost << endl << endl  << endl;


 //===== Begin section "Pass by Pointer to a C++ function =====================================================================
 cout << "Begin section that passes parameters by pointer to a C++ function" << endl;
 double * price_pointer = new double(10.00);
 cout << "The pointer shelf price is " << setw(4) << setprecision(2) << fixed << left << *price_pointer << endl;
 double * tax_pointer = new double(0.250);
 cout << "The pointer tax rate is " << setw(4) << setprecision(3) << fixed << left << *tax_pointer << endl;
 double amount_due = compute_total_via_pointers_cpp(price_pointer,tax_pointer);
  cout << "The final cost as computed by pointers passed to a C++ function is " << setw(4) << setprecision(2) << fixed 
      << left << amount_due << endl << endl  << endl;


 //===== Begin section "Pass by Reference to an X86 assembly function ==========================================================
 cout << "Begin section that passes parameters by reference to an x86 function" << endl;
 final_cost = compute_total_via_reference_x86(rp,tr);
 cout << "The final cost as computed by references passed to an x86 function is " << setw(4) << setprecision(2) << fixed 
      << left << final_cost << endl << endl  << endl;


 //===== Begin section "Pass by Pointer to an X86 assembly function ============================================================
 cout << "Begin section that passes parameters by pointer to an x86 function" << endl;
 amount_due = compute_total_via_pointers_x86(price_pointer,tax_pointer);
 cout << "The final cost as computed by pointers passed to an x86 function is " << setw(4) << setprecision(2) << fixed 
      << left << final_cost << endl << endl  << endl;

 return 0;
}//End of main




double compute_total_via_reference_cpp(double & price_ref,double & tax_ref)
{double total;
 total = price_ref * (1.0 + tax_ref);
 return total;
}//End of compute_total_via_reference_cpp

double compute_total_via_pointers_cpp(double * price_point,double * tax_point)
{double total;
 total = *price_point * (1.0 + *tax_point);
 return total;
}//End of compute_total_via_pointers_cpp

