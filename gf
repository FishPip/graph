// Graph.cpp : Diese Datei enthält die Funktion "main". Hier beginnt und endet die Ausführung des Programms.
//

#include <iostream>
#include <vector>
#include <map>
#include <algorithm>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>

template <typename T>
bool isInside(std::vector<T> v, T i) {
    for (int q = 0; q < v.size(); q++) 
        if (v[q] == i)
            return true;
    
    return false;
}

template <typename T>
std::vector<T> getKeysOfMap(std::map<T, int> m) {
    std::vector<T> v;
    for (auto i = m.begin(); i != m.end(); i++) 
        v.push_back((*i).first);
    
    return v;
}

template <typename T>
class Graph {
public:
    std::vector<T> knoten;
    std::map<T, std::map<T, int>> adjazenzList;
    std::vector<T> besuchteKnoten;

    Graph() {}

    void addKnoten(T i) {
        if (not isInside(knoten, i)) {
            knoten.push_back(i);
            std::map<T, int > w;
            adjazenzList[i] = w;
        }
    }

    void addKante(T i1, T i2, int weight) {
        if (isInside(knoten, i1) && isInside(knoten, i2))
            adjazenzList[i1][i2] = weight;
    }

    void tiefSuche(T startIndx) {
        if (isInside(knoten, startIndx)) {
            besuchteKnoten.push_back(startIndx);

            std::vector<T> nachbaren = getKeysOfMap(adjazenzList[startIndx]);

            if (nachbaren.size() == 0) {
                std::cout << "end" << std::endl;
            }

            for (auto c : nachbaren) {
                if (not isInside(besuchteKnoten, c)) {
                    std::cout << c << std::endl;
                    tiefSuche(c);
                }

            }
        }
    }

private:
    
};

int main()
{
    Graph<std::string>* g = new Graph<std::string>();

    std::string line;
    std::ifstream myfile("P:\\Info_GK_2025\\Graphen\\zentral.txt");
    int ammoutOfKnoten = 0;
    

    if (myfile.is_open())
    {
        while (std::getline(myfile, line))
        {
            if (line[0] == '#')
                continue;
            ammoutOfKnoten = std::stoi(line);
            break;
        }

        for (int i = 0; i < ammoutOfKnoten; i++) {
            std::getline(myfile, line);

            if (line[0] == '#') {
                i--;
                continue;
            }

            g->addKnoten(line);
        }

        while (std::getline(myfile, line))
        {
            if (line[0] == '#')
                continue;

            std::stringstream ss;
            ss << line;
            std::string i1s;
            std::string i2s;
            std::string ws;
            int i1;
            int i2;
            int w;

            ss >> i1s;
            ss >> i2s;
            ss >> ws;

            w = std::stoi(ws);
            i1 = std::stoi(i1s);
            i2 = std::stoi(i2s);

            /*std::cout << w << std::endl;
            std::cout << i1 << std::endl;
            std::cout << i2 << std::endl;*/


            g->addKante(g->knoten[i1], g->knoten[i2], w);

        }

        myfile.close();
    }

    g->tiefSuche("Peitz");

}

// Programm ausführen: STRG+F5 oder Menüeintrag "Debuggen" > "Starten ohne Debuggen starten"
// Programm debuggen: F5 oder "Debuggen" > Menü "Debuggen starten"

// Tipps für den Einstieg: 
//   1. Verwenden Sie das Projektmappen-Explorer-Fenster zum Hinzufügen/Verwalten von Dateien.
//   2. Verwenden Sie das Team Explorer-Fenster zum Herstellen einer Verbindung mit der Quellcodeverwaltung.
//   3. Verwenden Sie das Ausgabefenster, um die Buildausgabe und andere Nachrichten anzuzeigen.
//   4. Verwenden Sie das Fenster "Fehlerliste", um Fehler anzuzeigen.
//   5. Wechseln Sie zu "Projekt" > "Neues Element hinzufügen", um neue Codedateien zu erstellen, bzw. zu "Projekt" > "Vorhandenes Element hinzufügen", um dem Projekt vorhandene Codedateien hinzuzufügen.
//   6. Um dieses Projekt später erneut zu öffnen, wechseln Sie zu "Datei" > "Öffnen" > "Projekt", und wählen Sie die SLN-Datei aus.
