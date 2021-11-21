#include <stdio.h>
#include <stdlib.h>
#include <stdexcept>

void test1()
{
	throw std::runtime_error(   std::string( __FILE__ ) 		+ std::string( ":" ) 		+ std::to_string( __LINE__ ) 		+ std::string( " in " ) 		+ std::string( __PRETTY_FUNCTION__ ) 	);
}

int main ()
{
  test1();
}
