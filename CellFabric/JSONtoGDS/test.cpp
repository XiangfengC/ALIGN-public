#include <nlohmann/json.hpp>
//#include <gtest/gtest.h>

#include <iostream>
#include <fstream>

using namespace nlohmann;

int main() {
    std::filebuf fb;
    if ( fb.open( "mydesign_dr_globalrouting.json", std::ios::in)) {
      std::istream is(&fb);
      json j;
      is >> j;
      fb.close();

      {
	json rect = *(j.find("bbox")); 
	int llx = rect[0];
	int lly = rect[1];
	int urx = rect[2];
	int ury = rect[3];
	std::cout << "bbox: " << "["
		  << llx << ","
		  << lly << ","
		  << urx << ","
		  << ury << "]" << std::endl;
      }
	   
      auto p = *j.find("terminals");
      for ( auto pp = p.begin(); pp != p.end(); ++pp) {
	std::string layer = (*pp)["layer"];
	std::string netName = (*pp)["netName"];
	json rect = (*pp)["rect"];
	int llx = rect[0];
	int lly = rect[1];
	int urx = rect[2];
	int ury = rect[3];
	std::cout << layer << "," << netName << "," << "["
		  << llx << ","
		  << lly << ","
		  << urx << ","
		  << ury << "]" << std::endl;
      }


    } else {
      std::cerr << "Failed to open file." << std::endl;
    }

    return 0;
}
