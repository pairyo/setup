#include <mysql++.h>
#include <iostream>
 
int main()
{
   using namespace mysqlpp;
   using namespace std;
 
   try
   {
      mysqlpp::Connection conn(false);
      if(conn.connect("database name", "hostname", "username", "password"))
      {
          cout << "connection successful" << endl;
      }
   }
   catch (Exception& e)
   {
      cerr << "Exception: " << e.what() << endl;
   }
}
